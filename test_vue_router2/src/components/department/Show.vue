<script lang="ts" setup>
import axios from "../../util/axiosInstance"
import { ref, reactive, computed, type Ref } from "vue";
import { useRouter } from "vue-router";
import { useClickOutsideClearSelection } from "../../util/useClickOutsideClearSelection";
import { usePagination } from "../../util/usePagination";
import { useSyncTableHeader } from "../../util/useSyncTableHeader";
import { useSearchReset } from "../../util/useSearchReset";
import BaseTableHeader from "../common/BaseTableHeader.vue";

interface Department {
  id: number;
  name: string;
  number: number;
}

const router = useRouter();
const selectedId = ref(-1);
const selectedIds = ref<number[]>([]);
const batchMode = ref(false);
const createInitialForm = () => ({
  name: null as string | null,
  number: null as number | null,
});

const datas = reactive({
  form: createInitialForm(),
  list: [] as Department[]
});

const depColumns = [
  { key: "id", title: "ID" },
  { key: "number", title: "部门编号" },
  { key: "name", title: "部门名称" },
];

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
} = usePagination<Department>({
  source: computed(() => datas.list),
  storageKey: "pagination_pageSize_department",
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
  selectedIds.value = checked ? datas.list.map(d => d.id) : [];
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

const search = () => {
  console.log('搜索部门函数被调用');
  console.log('搜索参数:', datas.form);
  try {
    axios.get('/dep23B', { params: datas.form })
      .then((res) => {
        console.log('部门列表请求成功，响应数据:', res.data);
        let list: Department[] = res.data || [];

        // 前端再次根据表单条件过滤，避免后端未实现筛选时无效
        if (datas.form.number !== null && datas.form.number !== '' as any) {
          const keyword = String(datas.form.number as any);
          list = list.filter(d => String(d.number).includes(keyword));
        }
        if (datas.form.name) {
          const nameKeyword = String(datas.form.name);
          list = list.filter(d => d.name?.includes(nameKeyword));
        }

        // 按照编号升序排列
        list.sort((a, b) => a.number - b.number);
        datas.list = list;
        console.log('部门列表（筛选+升序排列）:', datas.list);
      })
      .catch((error) => {
        console.error('部门列表请求失败:', error);
      });
  } catch (error) {
    console.error('搜索函数执行出错:', error);
  }
};

const selectTr = (id: number) => {
  console.log('选中部门ID:', id);
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

const showAdd = () => {
  console.log('点击了新增按钮');
  try {
    router.push({ name: "DepAdd" });
    console.log('路由跳转到部门添加页面');
  } catch (error) {
    console.error('路由跳转失败:', error);
  }
};

const showUpdate = () => {
  console.log('点击了修改按钮');
  console.log('selectedId:', selectedId.value);
  if (selectedId.value > -1) {
    try {
      router.push({ name: "DepUpdate", query: { id: selectedId.value } });
      console.log('路由跳转到部门修改页面');
    } catch (error) {
      console.error('路由跳转失败:', error);
    }
  } else {
    alert("请选中数据");
  }
};

const deleteData = () => {
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
  if (!confirm("确定要删除选中的部门吗？删除后该部门下的员工部门信息将被置空。")) return;
  Promise.all(selectedIds.value.map(id => axios.delete('/dep23B/' + id)))
    .then(() => {
      alert("删除成功");
      search();
      selectedIds.value = [];
      selectedId.value = -1;
    })
    .catch((error) => {
      console.error('删除失败:', error);
      alert("删除失败，请稍后重试");
    });
};

// 使用可复用的点击外部取消选中功能
useClickOutsideClearSelection(selectedId, selectedIds, batchMode);

// 页面加载时自动查询
search();
</script>

<template>
  <div id="container">
    <div class="form-horizontal">
      <form class="form-group" @submit.prevent="search">
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="部门编号" v-model="datas.form.number">
        </div>
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="部门名称" v-model="datas.form.name">
        </div>
        <div class="col-sm-3">
          <button type="submit" class="btn btn-primary" v-auto-blur>搜索</button>
          <button type="button" class="btn btn-default" v-auto-blur style="margin-left: 8px;" @click="resetSearch">重置</button>
        </div>
      </form>
    </div>

    <div class="table-wrapper">
      <BaseTableHeader
        ref="headerRef"
        :columns="depColumns"
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
              v-for="dep in pagedData"
              :key="dep.id"
              :class="{ selected: isSelected(dep.id) }"
              @click="selectTr(dep.id)"
            >
              <td class="col-check" v-if="batchMode">
                <input
                  type="checkbox"
                  :checked="isSelected(dep.id)"
                  @click.stop
                  @change="toggleSelect(dep.id, ($event.target as HTMLInputElement).checked)"
                />
              </td>
              <td><span class="ellipsis-cell">{{ dep.id }}</span></td>
              <td><span class="ellipsis-cell">{{ dep.number }}</span></td>
              <td><span class="ellipsis-cell">{{ dep.name }}</span></td>
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
      <button type="button" class="btn btn-primary" v-auto-blur v-if="!batchMode" @click="showAdd">新增</button>
      <button type="button" class="btn btn-primary" v-auto-blur v-if="!batchMode" @click="showUpdate">修改</button>
      <button type="button" class="btn btn-danger" v-auto-blur @click="deleteData">删除</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
#container {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 10px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
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

.table-wrapper {
  flex: 1 1 auto;
  overflow: hidden;
  margin-top: 10px;
  display: flex;
  flex-direction: column;
  min-height: 0;
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
</style>

