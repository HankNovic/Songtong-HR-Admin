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
  number?: number;
}

interface Employee {
  id: number;
  number: number;
  name: string;
  gender: string;
  age: number;
  dep: Department | null;
}

const router = useRouter();
const selectedId = ref(-1);
const selectedIds = ref<number[]>([]);
const batchMode = ref(false);
const createInitialForm = () => ({
    number: null as number | null,
    name: null as string | null,
    gender: "",
    age: null as number | null,
    'dep.id': ""
});

const datas = reactive({
  form: createInitialForm(),
  list: [] as Employee[],
  depList: [] as Department[]
});

const employeeColumns = [
  { key: "number", title: "编号" },
  { key: "name", title: "名字" },
  { key: "gender", title: "性别" },
  { key: "age", title: "年龄" },
  { key: "dep", title: "部门" },
];

// 表头 / 表体 DOM 引用，用于列宽同步
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
} = usePagination<Employee>({
  source: computed(() => datas.list),
  storageKey: "pagination_pageSize_employee",
});

const { reset: resetSearchForm } = useSearchReset(datas.form, createInitialForm);

const resetSearch = () => {
  resetSearchForm();
  search();
};

// 同步列宽 + 滚动条补偿（依赖 pagedData 和 batchMode 状态）
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
  selectedIds.value = checked ? datas.list.map(e => e.id) : [];
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
  console.log('搜索函数被调用');
  console.log('搜索参数:', datas.form);
  try {
    axios.get('/emp', { params: datas.form })
      .then((res) => {
        console.log('搜索请求成功，响应数据:', res.data);
        datas.list = res.data;
        // 按照编号升序排列
        datas.list.sort((a, b) => {
          // 直接比较数字类型
          return a.number - b.number;
        });
        console.log('搜索结果（升序排列）:', datas.list);
      })
      .catch((error) => {
        console.error('搜索请求失败:', error);
      });
  } catch (error) {
    console.error('搜索函数执行出错:', error);
  }
};

const searchDep = () => {
  axios.get('/dep23B')
    .then((res) => {
      datas.depList = res.data;
      console.log('部门数据加载成功:', res.data);
    })
    .catch((error) => {
      console.error('部门数据加载失败:', error);
      // 如果接口失败，保持空数组，不设置默认数据
      datas.depList = [];
    });
};

const selectTr = (id: number) => {
  console.log(id);
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
  console.log('router对象:', router);
  console.log('EmpAdd路由是否存在:', router.options.routes[0]?.children?.find(r => r.name === 'EmpAdd'));
  try {
    router.push({ name: "EmpAdd" });
    console.log('路由跳转成功');
  } catch (error) {
    console.error('路由跳转失败:', error);
  }
};

const showUpdate = () => {
  console.log('点击了修改按钮');
  console.log('selectedId:', selectedId.value);
  if (selectedId.value > -1) {
    console.log('router对象:', router);
    console.log('EmpUpdate路由是否存在:', router.options.routes[0]?.children?.find(r => r.name === 'EmpUpdate'));
    try {
      router.push({ name: "EmpUpdate", query: { id: selectedId.value } });
      console.log('路由跳转成功');
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
  if (!confirm("确定要删除选中的数据吗？")) return;
  Promise.all(selectedIds.value.map(id => axios.delete('/emp/' + id)))
    .then(() => {
      alert("删除成功");
      search();
      selectedIds.value = [];
      selectedId.value = -1;
    })
    .catch((error) => {
      console.error('批量删除失败:', error);
      alert("删除失败，请稍后重试");
    });
};

// 使用可复用的点击外部取消选中功能
useClickOutsideClearSelection(selectedId, selectedIds, batchMode);

search();
searchDep();
</script>

<template>
  <div id="container">
    <div class="form-horizontal">
      <form class="form-group" @submit.prevent="search">
        <div class="col-sm-2">
          <input type="text" class="form-control" placeholder="编号" v-model="datas.form.number">
        </div>
        <div class="col-sm-2">
          <input type="text" class="form-control" placeholder="姓名" v-model="datas.form.name">
        </div>
        <div class="col-sm-2">
          <select name="gender" class="form-control" v-model="datas.form.gender">
            <option value="">性别</option>
            <option value="男">男</option>
            <option value="女">女</option>
          </select>
        </div>
        <div class="col-sm-2">
          <input type="text" class="form-control" placeholder="年龄" v-model="datas.form.age">
        </div>
        <div class="col-sm-2">
          <select class="form-control" v-model="datas.form['dep.id']">
            <option value="">部门</option>
            <option v-for="dep in datas.depList" v-text="dep.name" v-bind:key="dep.id" v-bind:value="dep.id">
            </option>
          </select>
        </div>
        <div class="col-sm-2">
          <button type="submit" class="btn btn-primary" v-auto-blur>搜索</button>
          <button type="button" class="btn btn-default" v-auto-blur style="margin-left: 8px;" @click="resetSearch">重置</button>
        </div>
      </form>
    </div>

    <div class="table-wrapper">
      <!-- 固定表头（通用组件） -->
      <BaseTableHeader
        ref="headerRef"
        :columns="employeeColumns"
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

      <!-- 可滚动表体 -->
      <div class="table-body-wrapper" ref="bodyWrapperRef">
        <table
          ref="bodyTableRef"
          class="table table-striped table-bordered table-hover"
        >
        <tbody class="scrollable-tbody">
            <tr
              class="data"
              v-for="emp in pagedData"
              :key="emp.id"
              :class="{ selected: isSelected(emp.id) }"
              @click="selectTr(emp.id)"
            >
              <td class="col-check" v-if="batchMode">
                <input
                  type="checkbox"
                  :checked="isSelected(emp.id)"
                  @click.stop
                  @change="toggleSelect(emp.id, ($event.target as HTMLInputElement).checked)"
                />
            </td>
              <td><span class="ellipsis-cell">{{ emp.number }}</span></td>
              <td><span class="ellipsis-cell">{{ emp.name }}</span></td>
              <td><span class="ellipsis-cell">{{ emp.gender }}</span></td>
              <td><span class="ellipsis-cell">{{ emp.age }}</span></td>
              <td><span class="ellipsis-cell">{{ emp.dep != null ? emp.dep.name : '' }}</span></td>
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
  margin-top: 10px;
  display: flex;
  flex-direction: column;
  /* 允许子元素收缩，避免被内容撑开导致没有滚动条 */
  min-height: 0;
  overflow: hidden;
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

/* 去掉表体表格的顶部外边距，让表头和表体视觉上连在一起 */
.table-body-wrapper .table {
  margin-top: 0;
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
</style>