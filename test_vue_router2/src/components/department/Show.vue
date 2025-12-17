<script lang="ts" setup>
import axios from "../../util/axiosInstance"
import { ref, reactive, computed } from "vue";
import { useRouter } from "vue-router";
import { useClickOutsideClearSelection } from "../../util/useClickOutsideClearSelection";

interface Department {
  id: number;
  name: string;
  number: number;
}

const router = useRouter();
const selectedId = ref(-1);
const selectedIds = ref<number[]>([]);
const batchMode = ref(false);
const datas = reactive({
  form: {
    name: null as string | null,
    number: null as number | null
  },
  list: [] as Department[]
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
        datas.list = res.data;
        // 按照编号升序排列
        datas.list.sort((a, b) => {
          return a.number - b.number;
        });
        console.log('部门列表（升序排列）:', datas.list);
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
          <input type="text" class="form-control" placeholder="部门名称" v-model="datas.form.name">
        </div>
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="部门编号" v-model="datas.form.number">
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
            <th>部门编号</th>
            <th>部门名称</th>
          </tr>
        </thead>
        <tbody class="scrollable-tbody">
          <tr class="data" v-for="dep in datas.list" v-bind:key="dep.id" v-bind:class="{ selected: isSelected(dep.id) }" @click="selectTr(dep.id)">
            <td class="col-check" v-if="batchMode">
              <input type="checkbox" :checked="isSelected(dep.id)" @click.stop @change="toggleSelect(dep.id, ($event.target as HTMLInputElement).checked)" />
            </td>
            <td class="table-cell-ellipsis" v-text="dep.id"></td>
            <td class="table-cell-ellipsis" v-text="dep.number"></td>
            <td class="table-cell-ellipsis" v-text="dep.name"></td>
          </tr>
        </tbody>
      </table>
    </div>

    <div id="buttons">
      <button type="button" class="btn btn-default" @click="toggleBatch">
        {{ batchMode ? '退出批量' : '批量操作' }}
      </button>
      <button type="button" class="btn btn-primary" v-if="!batchMode" @click="showAdd">新增</button>
      <button type="button" class="btn btn-primary" v-if="!batchMode" @click="showUpdate">修改</button>
      <button type="button" class="btn btn-danger" @click="deleteData">删除</button>
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
  margin-top: auto;
  padding-top: 10px;
  align-self: flex-start;
}

.table-wrapper {
  flex: 1;
  overflow: auto;
  margin-top: 10px;
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

.table-cell-ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>

