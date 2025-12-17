<script lang="ts" setup>
import { ref, reactive, computed } from "vue";
import { getAllPermissions, createPermission, updatePermission, deletePermission } from "../../api/permission";
import type { Permission } from "../../types/user";
import { useClickOutsideClearSelection } from "../../util/useClickOutsideClearSelection";

const selectedId = ref(-1);
const selectedIds = ref<number[]>([]);
const batchMode = ref(false);
const loading = ref(false);
const errorMessage = ref("");
const datas = reactive({
  form: {
    name: null as string | null,
    code: null as string | null
  },
  list: [] as Permission[]
});

const showEditDialog = ref(false);
const editMode = ref<"create" | "edit">("create");
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
  selectedIds.value = checked ? datas.list.map(p => p.id) : [];
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
    const res = await getAllPermissions();
    if (res.code === 200) {
      datas.list = res.data || [];
      if (datas.form.name) {
        datas.list = datas.list.filter(p => p.name?.includes(datas.form.name as string));
      }
      if (datas.form.code) {
        datas.list = datas.list.filter(p => p.code?.includes(datas.form.code as string));
      }
      // 移除类型过滤逻辑
    } else {
      errorMessage.value = res.message || "获取权限列表失败";
    }
  } catch (err: any) {
    console.error("权限列表请求失败:", err);
    errorMessage.value = err?.message || "权限列表请求失败";
  } finally {
    loading.value = false;
  }
};

const selectTr = (id: number) => {
  if (batchMode.value) {
  if (selectedIds.value.includes(id)) {
    selectedIds.value = selectedIds.value.filter(v => v !== id);
    if (selectedId.value === id) {
      selectedId.value = selectedIds.value[0] ?? -1;
    }
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
};

const openAddDialog = () => {
  resetEditForm();
  editMode.value = "create";
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
  const current = datas.list.find(p => p.id === selectedId.value);
  if (!current) return;
  editMode.value = "edit";
  editForm.id = current.id ?? null;
  editForm.name = current.name ?? "";
  editForm.code = current.code ?? "";
  editForm.description = (current as any).description ?? "";
  editForm.status = (current as any).status || "启用";
  showEditDialog.value = true;
};

const submitEdit = async () => {
  if (!editForm.name || !editForm.code) {
    alert("名称和编码不能为空");
    return;
  }
  try {
    const payload = {
      id: editForm.id ?? undefined,
      name: editForm.name,
      code: editForm.code,
      description: editForm.description || undefined,
      status: editForm.status || "启用",
    };
    const res = editMode.value === "create"
      ? await createPermission(payload)
      : await updatePermission(payload as any);
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
  if (batchMode.value) {
    if (selectedIds.value.length === 0) {
      alert("请选中要删除的数据");
      return;
    }
  } else {
    if (selectedId.value < 0) {
      alert("请先选中要删除的数据行");
      return;
    }
    selectedIds.value = [selectedId.value];
  }
  if (!confirm("确定要删除选中的权限吗？")) return;
  try {
    await Promise.all(selectedIds.value.map(id => deletePermission(id)));
    alert("删除成功");
  selectedIds.value = [];
  selectedId.value = -1;
    search();
  } catch (e: any) {
    alert(e?.message || "删除失败");
  }
};

// 使用可复用的点击外部取消选中功能
useClickOutsideClearSelection(selectedId, selectedIds, batchMode);

const statusDotClass = (status?: string) => {
  const normalized = status || "启用";
  return normalized === "启用" ? "status-dot status-dot--active" : "status-dot status-dot--inactive";
};

// 页面加载时自动查询
search();
</script>

<template>
  <div id="container">

    
    <div class="form-horizontal">
      <form class="form-group" @submit.prevent="search">
        <div class="col-sm-2">
          <input type="text" class="form-control" placeholder="权限名称" v-model="datas.form.name">
        </div>
        <div class="col-sm-2">
          <input type="text" class="form-control" placeholder="权限编码" v-model="datas.form.code">
        </div>
        <div class="col-sm-2">
          <button type="submit" class="btn btn-primary">搜索</button>
        </div>
        <div class="col-sm-2">
          <button type="button" class="btn btn-default" @click="search">刷新</button>
        </div>
      </form>
    </div>

    <div class="table-wrapper">
    <table class="table table-striped table-bordered table-hover">
      <thead>
        <tr>
          <th class="col-check" v-if="batchMode">
            <input type="checkbox" :checked="isAllSelected" @change="toggleSelectAll(($event.target as HTMLInputElement).checked)" />
          </th>
          <th>ID</th>
          <th>权限名称</th>
          <th>权限编码</th>
          <th>描述</th>
          <th class="status-col">状态</th>
        </tr>
      </thead>
      <tbody class="scrollable-tbody">
        <tr class="data" v-for="permission in datas.list" v-bind:key="permission.id" v-bind:class="{ selected: isSelected(permission.id) }" @click="selectTr(permission.id)">
          <td class="col-check" v-if="batchMode">
            <input type="checkbox" :checked="isSelected(permission.id)" @click.stop @change="toggleSelect(permission.id, ($event.target as HTMLInputElement).checked)" />
          </td>
          <td class="table-cell-ellipsis" v-text="permission.id"></td>
          <td class="table-cell-ellipsis" v-text="permission.name"></td>
          <td class="table-cell-ellipsis" v-text="permission.code"></td>
          <td v-text="permission.description || '-'"></td>
          <td class="status-col">
            <span class="status-cell">
              <span :class="statusDotClass(permission.status)"></span>
              <span>{{ permission.status || '启用' }}</span>
            </span>
          </td>
        </tr>
      </tbody>
    </table>
    </div>

    <div id="buttons">
      <button type="button" class="btn btn-default" @click="toggleBatch">
        {{ batchMode ? '退出批量' : '批量操作' }}
      </button>
      <button type="button" class="btn btn-primary" v-if="!batchMode" @click="openAddDialog">新增</button>
      <button type="button" class="btn btn-primary" v-if="!batchMode" @click="openEditDialog">修改</button>
      <button type="button" class="btn btn-danger" @click="deleteData">删除</button>
    </div>

    <!-- 新增/修改弹窗 -->
    <div v-if="showEditDialog" class="modal-mask">
      <div class="modal-container">
        <h4>{{ editMode === 'create' ? '新增权限' : '修改权限' }}</h4>
        <div class="form-row">
          <label>权限名称</label>
          <input v-model="editForm.name" type="text" class="form-control" placeholder="请输入权限名称">
        </div>
        <div class="form-row">
          <label>权限编码</label>
          <input v-model="editForm.code" type="text" class="form-control" placeholder="请输入权限编码">
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
          <button class="btn btn-primary" @click="submitEdit">保存</button>
          <button class="btn btn-default" @click="showEditDialog = false">取消</button>
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
  margin-top: auto;
  padding-top: 10px;
  align-self: flex-start;
}

.table-wrapper {
  flex: 1;
  overflow: auto;
  width: 100%;
}

.table {
  width: 100%;
  border-collapse: collapse;
  table-layout: fixed;
}

.table thead th {
  position: sticky;
  top: 0;
  background: var(--color-table-header-bg);
  color: var(--color-table-header-text);
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

.col-sm-2 {
  display: inline-block;
  padding: 0 5px;
  vertical-align: top;
  width: 16.66666667%;
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

.modal-container h4 {
  margin-top: 0;
  margin-bottom: 20px;
  font-size: 18px;
  font-weight: 600;
}

.modal-actions {
  text-align: right;
  margin-top: 20px;
}

.modal-actions .btn {
  margin-left: 10px;
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

.table-cell-ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>

