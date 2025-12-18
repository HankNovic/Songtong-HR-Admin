<script lang="ts" setup>
import { ref, reactive, computed, type Ref } from "vue";
import { getAllRoles, createRole, updateRole, deleteRole } from "../../api/role";
import { getAllPermissions } from "../../api/permission";
import { getRolePermissions, updateRolePermissions } from "../../api/rolePermission";
import type { Role } from "../../types/user";
import { useClickOutsideClearSelection } from "../../util/useClickOutsideClearSelection";
import { usePagination } from "../../util/usePagination";
import { useSyncTableHeader } from "../../util/useSyncTableHeader";
import { useSearchReset } from "../../util/useSearchReset";
import BaseTableHeader from "../common/BaseTableHeader.vue";
import BaseLoadingOverlay from "../common/BaseLoadingOverlay.vue";

const selectedId = ref(-1);
const selectedIds = ref<number[]>([]);
const batchMode = ref(false);
const loading = ref(false);
const errorMessage = ref("");
const createInitialForm = () => ({
  name: null as string | null,
  code: null as string | null,
});

const datas = reactive({
  form: createInitialForm(),
  list: [] as Role[]
});

const roleColumns = [
  { key: "id", title: "ID" },
  { key: "name", title: "角色名称" },
  { key: "code", title: "角色编码" },
  { key: "description", title: "描述" },
  { key: "status", title: "状态", className: "status-col" },
];

// 系统角色保护：ID范围（前 3 个）
const MAX_SYSTEM_ROLE_ID = 3;
// 系统角色名称（根据实际数据调整）
const SYSTEM_ROLE_NAMES = ["管理员", "经理", "员工"];

// 检查是否为系统角色
const isSystemRole = (role: Role | null | undefined): boolean => {
  if (!role) return false;
  return (role.id <= MAX_SYSTEM_ROLE_ID) || SYSTEM_ROLE_NAMES.includes(role.name);
};

const headerRef = ref<InstanceType<typeof BaseTableHeader> | null>(null);
const bodyTableRef = ref<HTMLTableElement | null>(null);
const bodyWrapperRef = ref<HTMLElement | null>(null);

const {
  currentPage,
  pageSize,
  total,
  totalPages,
  pageSizeOptions,
  pagedData,
  setPage,
  setPageSize,
  hasPrev,
  hasNext,
} = usePagination<Role>({
  source: computed(() => datas.list),
  storageKey: "pagination_pageSize_sysRole",
});

const { reset: resetSearchForm } = useSearchReset(datas.form, createInitialForm);

const resetSearch = () => {
  resetSearchForm();
  search();
};

useSyncTableHeader(
  headerRef,
  bodyTableRef,
  bodyWrapperRef,
  [pagedData as unknown as Ref<unknown>, batchMode as unknown as Ref<unknown>]
);

const allPermissions = ref<{ id: number; name: string; code: string }[]>([]);
const assignedPermissionIds = ref<number[]>([]);
const showPermDialog = ref(false);
const currentRole = ref<Role | null>(null);

const showEditDialog = ref(false);
const editMode = ref<"create" | "edit">("create");
// 当前正在编辑的角色（用于系统角色只允许部分字段修改）
const currentEditingRole = ref<Role | null>(null);
const editForm = reactive({
  id: null as number | null,
  name: "",
  code: "",
  description: "",
  status: "启用"
});

const toggleBatch = () => {
  batchMode.value = !batchMode.value;
  if (!batchMode.value) {
    selectedIds.value = [];
    selectedId.value = -1;
  }
};

const isAllSelected = computed(() => datas.list.length > 0 && selectedIds.value.length === datas.list.length);

const toggleSelectAll = (checked: boolean) => {
  if (!batchMode.value) return;
  selectedIds.value = checked ? datas.list.map(r => r.id) : [];
  selectedId.value = checked && datas.list.length > 0 ? datas.list[0].id : -1;
};

const toggleSelect = (id: number, checked: boolean) => {
  if (!batchMode.value) return;
  if (checked) {
    if (!selectedIds.value.includes(id)) selectedIds.value.push(id);
    selectedId.value = id;
  } else {
    selectedIds.value = selectedIds.value.filter(v => v !== id);
    if (selectedId.value === id) selectedId.value = selectedIds.value[0] ?? -1;
  }
};

const isSelected = (id: number) =>
  batchMode.value ? selectedIds.value.includes(id) : selectedId.value === id;

const search = async () => {
  loading.value = true;
  errorMessage.value = "";
  try {
    const res = await getAllRoles();
    if (res.code === 200) {
      datas.list = res.data || [];
      if (datas.form.name) {
        datas.list = datas.list.filter(r => r.name?.includes(datas.form.name as string));
      }
      if (datas.form.code) {
        datas.list = datas.list.filter(r => r.code?.includes(datas.form.code as string));
      }
    } else {
      errorMessage.value = res.message || "获取角色列表失败";
    }
  } catch (err: any) {
    console.error("角色列表请求失败:", err);
    errorMessage.value = err?.message || "角色列表请求失败";
  } finally {
    loading.value = false;
  }
};

const selectTr = (id: number) => {
  if (batchMode.value) {
  if (selectedIds.value.includes(id)) {
    selectedIds.value = selectedIds.value.filter(v => v !== id);
      if (selectedId.value === id) selectedId.value = selectedIds.value[0] ?? -1;
    } else {
      selectedIds.value.push(id);
      selectedId.value = id;
    }
  } else {
    selectedId.value = id;
  }
};

const resetEditForm = () => {
  editForm.id = null;
  editForm.name = "";
  editForm.code = "";
  editForm.description = "";
  editForm.status = "启用";
  currentEditingRole.value = null;
};

const openAddDialog = () => {
  resetEditForm();
  editMode.value = "create";
  currentEditingRole.value = null;
  showEditDialog.value = true;
};

const openEditDialog = () => {
  if (batchMode.value && selectedIds.value.length !== 1) {
    alert("批量模式下只能选择一条进行编辑");
    return;
  }
  if (selectedId.value < 0) {
    alert("请选中数据");
    return;
  }
  const current = datas.list.find(r => r.id === selectedId.value);
  if (!current) return;
  editMode.value = "edit";
  currentEditingRole.value = current;
  editForm.id = current.id ?? null;
  editForm.name = current.name ?? "";
  editForm.code = current.code ?? "";
  editForm.description = (current as any).description ?? "";
  editForm.status = (current as any).status || "启用";
  showEditDialog.value = true;
};

const submitEdit = async () => {
  const isEditingSystem = editMode.value === "edit" && currentEditingRole.value && isSystemRole(currentEditingRole.value);

  // 新增或编辑普通角色：名称和编码必填
  if (!isEditingSystem) {
    if (!editForm.name || !editForm.code) {
      alert("名称和编码不能为空");
      return;
    }
  }

  try {
    const payload: any = {
      id: editForm.id ?? undefined,
      description: editForm.description || undefined,
      status: editForm.status || "启用",
    };

    if (editMode.value === "create") {
      // 新增：名称和编码必须提交
      payload.name = editForm.name;
      payload.code = editForm.code;
    } else {
      // 编辑
      if (isEditingSystem && currentEditingRole.value) {
        // 系统角色：名称和编码保持不变，只允许修改描述和状态
        payload.name = currentEditingRole.value.name;
        payload.code = currentEditingRole.value.code;
      } else {
        // 普通角色：允许修改名称和编码
        payload.name = editForm.name;
        payload.code = editForm.code;
      }
    }
    const res = editMode.value === "create"
      ? await createRole(payload)
      : await updateRole(payload as any);
    if (res.code === 200 && res.data === true) {
      alert(editMode.value === "create" ? "新增成功" : "修改成功");
      showEditDialog.value = false;
      search();
    } else {
      alert(res.message || "提交失败");
    }
  } catch (e: any) {
    alert(e?.message || "提交失败");
  }
};

const deleteData = async () => {
  let idsToDelete: number[] = [];

  if (batchMode.value) {
    if (selectedIds.value.length === 0) {
      alert("请选中要删除的数据");
      return;
    }
    idsToDelete = selectedIds.value;
  } else {
    if (selectedId.value < 0) {
      alert("请先选中要删除的数据行");
      return;
    }
    idsToDelete = [selectedId.value];
  }

  // 检查是否包含系统角色
  const systemRoles = datas.list.filter(r =>
    idsToDelete.includes(r.id) && isSystemRole(r)
  );

  if (systemRoles.length > 0) {
    const names = systemRoles.map(r => r.name).join("、");
    alert(`系统角色不可删除：${names}\n\n系统角色是系统运行的基础角色，删除可能导致权限体系异常。`);
    return;
  }

  // 过滤掉系统角色（双重保护）
  idsToDelete = idsToDelete.filter(id => {
    const role = datas.list.find(r => r.id === id);
    return role && !isSystemRole(role);
  });

  if (idsToDelete.length === 0) {
    alert("没有可删除的角色");
    return;
  }

  if (!confirm(`确定要删除选中的 ${idsToDelete.length} 个角色吗？`)) return;
  try {
    await Promise.all(selectedIds.value.map(id => deleteRole(id)));
    alert("删除成功");
  selectedIds.value = [];
  selectedId.value = -1;
    search();
  } catch (e: any) {
    alert(e?.message || "删除失败");
  }
};

const statusDotClass = (status?: string) => {
  const normalized = status || "启用";
  return normalized === "启用" ? "status-dot status-dot--active" : "status-dot status-dot--inactive";
};

// 使用可复用的点击外部取消选中功能
useClickOutsideClearSelection(selectedId, selectedIds, batchMode);

// 分配权限
const openAssignPermissions = async () => {
  if (batchMode.value && selectedIds.value.length !== 1) {
    alert("批量模式下只能选择一条进行分配");
    return;
  }
  if (selectedId.value < 0) {
    alert("请选中角色");
    return;
  }
  currentRole.value = datas.list.find(r => r.id === selectedId.value) || null;
  if (!currentRole.value) return;

  try {
    const [permRes, rolePermRes] = await Promise.all([
      getAllPermissions(),
      getRolePermissions(currentRole.value.id)
    ]);
    if (permRes.code === 200) {
      allPermissions.value = permRes.data || [];
    }
    if (rolePermRes.code === 200) {
      assignedPermissionIds.value = rolePermRes.data || [];
    }
    showPermDialog.value = true;
  } catch (e: any) {
    alert(e?.message || "加载权限失败");
  }
};

const saveRolePermissions = async () => {
  if (!currentRole.value) return;
  try {
    const res = await updateRolePermissions(currentRole.value.id, assignedPermissionIds.value);
    if (res.code === 200 && res.data === true) {
      alert("分配权限成功");
      showPermDialog.value = false;
      search();
    } else {
      alert(res.message || "分配权限失败");
    }
  } catch (e: any) {
    alert(e?.message || "分配权限失败");
  }
};

// 页面加载时自动查询
search();
</script>

<template>
  <div id="container">

    
    <div class="form-horizontal">
      <form class="form-group" @submit.prevent="search">
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="角色名称" v-model="datas.form.name">
        </div>
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="角色编码" v-model="datas.form.code">
        </div>
        <div class="col-sm-3">
          <button type="submit" class="btn btn-primary" v-auto-blur>搜索</button>
          <button type="button" class="btn btn-default" v-auto-blur style="margin-left: 8px;" @click="resetSearch">重置</button>
        </div>
      </form>
    </div>

    <div class="table-wrapper">
      <BaseLoadingOverlay :show="loading" text="加载中..." />
      <BaseTableHeader
        ref="headerRef"
        :columns="roleColumns"
        :showCheckbox="batchMode"
      >
        <template #checkbox>
          <input
            type="checkbox"
            :checked="isAllSelected"
            @change="toggleSelectAll(($event.target as HTMLInputElement).checked)"
          />
        </template>
      </BaseTableHeader>

      <div class="table-body-wrapper" ref="bodyWrapperRef">
        <table
          ref="bodyTableRef"
          class="table table-striped table-bordered table-hover"
        >
      <tbody class="scrollable-tbody">
            <tr
              class="data"
              v-for="role in pagedData"
              :key="role.id"
              :class="{ selected: isSelected(role.id) }"
              @click="selectTr(role.id)"
            >
              <td class="col-check" v-if="batchMode">
                <input
                  type="checkbox"
                  :checked="isSelected(role.id)"
                  @click.stop
                  @change="toggleSelect(role.id, ($event.target as HTMLInputElement).checked)"
                />
              </td>
              <td><span class="ellipsis-cell">{{ role.id }}</span></td>
              <td>
                <span class="ellipsis-cell">
                  {{ role.name }}
                  <span
                    v-if="isSystemRole(role)"
                    class="system-badge"
                    title="系统角色，仅允许修改描述和状态"
                  >[系统]</span>
                </span>
              </td>
              <td><span class="ellipsis-cell">{{ role.code }}</span></td>
              <td><span class="description-cell">{{ role.description || '-' }}</span></td>
              <td class="status-col">
                <span class="status-cell">
                  <span :class="statusDotClass(role.status)"></span>
                  <span>{{ role.status || '启用' }}</span>
                </span>
          </td>
        </tr>
      </tbody>
    </table>
      </div>
    </div>

    <div class="table-footer">
      <div class="pagination-wrapper">
        <span>每页</span>
        <select v-model.number="pageSize" @change="setPageSize(pageSize)">
          <option v-for="size in pageSizeOptions" :key="size" :value="size">{{ size }}</option>
        </select>
        <span>条，共 {{ total }} 条</span>
        <button type="button" class="btn btn-default btn-xs" v-auto-blur :disabled="!hasPrev" @click="setPage(currentPage - 1)">上一页</button>
        <span>第 {{ currentPage }} / {{ totalPages }} 页</span>
        <button type="button" class="btn btn-default btn-xs" v-auto-blur :disabled="!hasNext" @click="setPage(currentPage + 1)">下一页</button>
      </div>

    <div id="buttons">
      <button type="button" class="btn btn-default" v-auto-blur @click="toggleBatch">
        {{ batchMode ? '退出批量' : '批量操作' }}
      </button>
      <button type="button" class="btn btn-primary" v-auto-blur v-if="!batchMode" @click="openAddDialog">新增</button>
      <button type="button" class="btn btn-primary" v-auto-blur v-if="!batchMode" @click="openEditDialog">修改</button>
      <button
        type="button"
        class="btn btn-danger"
        v-auto-blur
        @click="deleteData"
        :disabled="batchMode ? (selectedIds.length === 0 || selectedIds.some(id => {
          const role = datas.list.find(r => r.id === id);
          return role && isSystemRole(role);
        })) : (selectedId < 0 || (selectedId >= 0 && isSystemRole(datas.list.find(r => r.id === selectedId)!)))"
        :title="batchMode ? (selectedIds.some(id => {
          const role = datas.list.find(r => r.id === id);
          return role && isSystemRole(role);
        }) ? '选中的角色中包含系统角色，不可删除' : '') : (selectedId >= 0 && isSystemRole(datas.list.find(r => r.id === selectedId)!) ? '系统角色不可删除' : '')"
      >
        删除
      </button>
      <button type="button" class="btn btn-primary" v-auto-blur v-if="!batchMode" @click="openAssignPermissions">分配权限</button>
      </div>
    </div>

    <!-- 新增/修改弹窗 -->
    <div v-if="showEditDialog" class="modal-mask">
      <div class="modal-container">
        <h4>{{ editMode === 'create' ? '新增角色' : '修改角色' }}</h4>
        <div class="form-row">
          <label>角色名称</label>
          <input
            v-model="editForm.name"
            type="text"
            class="form-control"
            placeholder="请输入角色名称"
            :disabled="!!(editMode === 'edit' && currentEditingRole && isSystemRole(currentEditingRole))"
          >
        </div>
        <div class="form-row">
          <label>角色编码</label>
          <input
            v-model="editForm.code"
            type="text"
            class="form-control"
            placeholder="请输入角色编码"
            :disabled="!!(editMode === 'edit' && currentEditingRole && isSystemRole(currentEditingRole))"
          >
        </div>
        <div
          class="form-row"
          v-if="editMode === 'edit' && currentEditingRole && isSystemRole(currentEditingRole)"
        >
          <small class="system-edit-tip">
            系统自带角色仅允许修改“描述”和“状态”，名称与编码已锁定。
          </small>
        </div>
        <div class="form-row">
          <label>描述</label>
          <textarea v-model="editForm.description" class="form-control" rows="3" placeholder="请输入描述（可选）"></textarea>
        </div>
        <div class="form-row">
          <label>状态</label>
          <select v-model="editForm.status" class="form-control">
            <option value="启用">启用</option>
            <option value="禁用">禁用</option>
          </select>
        </div>
        <div class="modal-actions">
          <button class="btn btn-primary" v-auto-blur @click="submitEdit">保存</button>
          <button class="btn btn-default" v-auto-blur @click="showEditDialog = false">取消</button>
        </div>
      </div>
    </div>

    <!-- 分配权限弹窗 -->
    <div v-if="showPermDialog" class="modal-mask">
      <div class="modal-container">
        <h4>为 {{ currentRole?.name }} 分配权限</h4>
        <div class="role-list">
          <label v-for="p in allPermissions" :key="p.id" class="role-item">
            <input type="checkbox" :value="p.id" v-model="assignedPermissionIds" />
            {{ p.name }} ({{ p.code }})
          </label>
        </div>
        <div class="modal-actions">
          <button class="btn btn-primary" v-auto-blur @click="saveRolePermissions">保存</button>
          <button class="btn btn-default" v-auto-blur @click="showPermDialog = false">取消</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
#container {
  width: 100%;
  margin: 0;
  padding: 10px;
  box-sizing: border-box;
  height: 100%;
  min-height: 0;
  display: flex;
  flex-direction: column;
}

.notice-box {
  background-color: #fff3cd;
  border: 1px solid #ffc107;
  border-radius: 4px;
  padding: 10px;
  margin-bottom: 15px;
}

.notice-box p {
  margin: 0;
  color: #856404;
}

#container .selected {
  background: var(--color-primary);
  color: var(--color-text-light);
}

#buttons button {
  margin-right: 5px;
}

#buttons {
  padding-top: 10px;
  align-self: flex-start;
}

.modal-mask {
  position: fixed;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.4);
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-container {
  background: #fff;
  padding: 20px;
  border-radius: 6px;
  width: 400px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}

.form-row {
  margin-bottom: 12px;
}

.form-row label {
  display: block;
  margin-bottom: 6px;
  font-weight: 600;
}

.form-row .form-control {
  width: 100%;
  padding: 6px 10px;
  box-sizing: border-box;
}

.role-list {
  max-height: 240px;
  overflow: auto;
  border: 1px solid #eee;
  padding: 10px;
  margin: 10px 0;
}

.role-item {
  display: block;
  margin-bottom: 6px;
}

.modal-actions {
  text-align: right;
  margin-top: 16px;
}

.modal-actions .btn + .btn {
  margin-left: 12px;
}

.table-wrapper {
  flex: 1 1 auto;
  margin-top: 10px;
  display: flex;
  flex-direction: column;
  min-height: 0;
  overflow: hidden;
  width: 100%;
  position: relative;
}

.table-body-wrapper {
  flex: 1 1 auto;
  overflow: auto;
}

.table-footer {
  margin-top: auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.pagination-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
}

.pagination-wrapper select {
  height: 26px;
  padding: 2px 6px;
}

.table {
  width: 100%;
  border-collapse: collapse;
  table-layout: fixed;
}

.table-body-wrapper .table {
  margin-top: 0;
}

.table thead th {
  position: sticky;
  top: 0;
  background: var(--color-table-header-bg);
  color: var(--color-table-header-text);
  border-color: var(--color-table-header-border);
  z-index: 2;
}

.scrollable-tbody {
  display: table-row-group;
  max-height: none;
  overflow: visible;
  width: 100%;
}

.col-check {
  width: 50px;
  min-width: 50px;
  max-width: 50px;
  text-align: center;
}

.col-check input {
  margin: 0;
}

.form-group {
  margin-bottom: 15px;
}

.col-sm-2,
.col-sm-3 {
  display: inline-block;
  padding: 0 5px;
  vertical-align: top;
}

.col-sm-2 {
  width: 16.66666667%;
}

.col-sm-3 {
  width: 25%;
}

.form-control {
  width: 100%;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.btn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  border: 1px solid transparent;
  border-radius: 4px;
}

.btn-primary {
  color: #fff;
  background-color: #337ab7;
  border-color: #2e6da4;
}

.btn-primary:hover {
  background-color: #286090;
  border-color: #204d74;
}

.btn-default {
  color: #333;
  background-color: #fff;
  border-color: #ccc;
}

.btn-default:hover {
  background-color: #e6e6e6;
  border-color: #adadad;
}

.btn-danger {
  color: #fff;
  background-color: #d9534f;
  border-color: #d43f3a;
}

.btn-danger:hover {
  background-color: #c9302c;
  border-color: #ac2925;
}

.system-badge {
  display: inline-block;
  margin-left: 6px;
  padding: 2px 6px;
  font-size: 11px;
  color: #d97706;
  background-color: #fef3c7;
  border: 1px solid #fbbf24;
  border-radius: 3px;
  font-weight: 500;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.system-edit-tip {
  display: block;
  margin-top: 6px;
  font-size: 12px;
  color: #6b7280;
}

.status-col {
  width: 120px;
  min-width: 120px;
  text-align: left;
  vertical-align: middle;
}

.status-cell {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  white-space: nowrap;
}

.status-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #9ca3af;
  display: inline-block;
  flex-shrink: 0;
}

.status-dot--active {
  background: #22c55e;
}

.status-dot--inactive {
  background: #9ca3af;
}
</style>

