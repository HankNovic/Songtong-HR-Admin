<script lang="ts" setup>
import { ref, reactive, computed } from "vue";
import { useRouter } from "vue-router";

// 注意：后端接口尚未实现，当前使用占位数据
interface SysRole {
  id: number;
  name: string;
  code: string;
  description?: string;
  status: string;
  createTime?: string;
}

const router = useRouter();
const selectedId = ref(-1);
const selectedIds = ref<number[]>([]);
const datas = reactive({
  form: {
    name: null as string | null,
    code: null as string | null
  },
  list: [] as SysRole[]
});

const isAllSelected = computed(() => datas.list.length > 0 && selectedIds.value.length === datas.list.length);

const toggleSelectAll = (checked: boolean) => {
  selectedIds.value = checked ? datas.list.map(r => r.id) : [];
  selectedId.value = checked && datas.list.length > 0 ? datas.list[0].id : -1;
};

const toggleSelect = (id: number, checked: boolean) => {
  if (checked) {
    if (!selectedIds.value.includes(id)) selectedIds.value.push(id);
    selectedId.value = id;
  } else {
    selectedIds.value = selectedIds.value.filter(v => v !== id);
    if (selectedId.value === id) selectedId.value = selectedIds.value[0] ?? -1;
  }
};

const isSelected = (id: number) => selectedIds.value.includes(id);

const search = () => {
  console.log('搜索角色函数被调用');
  // TODO: 等待后端接口实现
  // axios.get('/sysRole', { params: datas.form })
  //   .then((res) => {
  //     datas.list = res.data;
  //   })
  //   .catch((error) => {
  //     console.error('角色列表请求失败:', error);
  //   });
  
  // 临时占位数据
  datas.list = [
    { id: 1, name: '管理员', code: 'ADMIN', status: '启用', description: '系统管理员角色' },
    { id: 2, name: '普通用户', code: 'USER', status: '启用', description: '普通用户角色' },
    { id: 3, name: '访客', code: 'GUEST', status: '启用', description: '访客角色' }
  ];
};

const selectTr = (id: number) => {
  console.log('选中角色ID:', id);
  if (selectedIds.value.includes(id)) {
    selectedIds.value = selectedIds.value.filter(v => v !== id);
    if (selectedId.value === id) {
      selectedId.value = selectedIds.value[0] ?? -1;
    }
  } else {
    selectedIds.value.push(id);
    selectedId.value = id;
  }
};

const showAdd = () => {
  console.log('点击了新增按钮');
  // TODO: 实现角色添加功能
  alert("角色添加功能开发中，等待后端接口实现");
};

const showUpdate = () => {
  console.log('点击了修改按钮');
  if (selectedId.value > -1) {
    // TODO: 实现角色修改功能
    alert("角色修改功能开发中，等待后端接口实现");
  } else {
    alert("请选中数据");
  }
};

const deleteData = () => {
  if (selectedIds.value.length === 0) {
    alert("请选中数据");
    return;
  }
  if (!confirm("确定要删除选中的角色吗？（当前为占位操作，未调用后端）")) return;
  datas.list = datas.list.filter(r => !selectedIds.value.includes(r.id));
  selectedIds.value = [];
  selectedId.value = -1;
};

// 页面加载时自动查询
search();
</script>

<template>
  <div id="container">
    <div class="notice-box">
      <p><strong>提示：</strong>角色管理功能正在开发中，等待后端接口实现。</p>
    </div>
    
    <div class="form-horizontal">
      <form class="form-group" @submit.prevent="search">
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="角色名称" v-model="datas.form.name">
        </div>
        <div class="col-sm-3">
          <input type="text" class="form-control" placeholder="角色编码" v-model="datas.form.code">
        </div>
        <div class="col-sm-2">
          <button type="submit" class="btn btn-primary">搜索</button>
        </div>
        <div class="col-sm-2">
          <button type="button" class="btn btn-default" @click="search">刷新</button>
        </div>
      </form>
    </div>

    <table class="table table-striped table-bordered table-hover">
      <thead>
        <tr>
          <th class="col-check">
            <input type="checkbox" :checked="isAllSelected" @change="toggleSelectAll(($event.target as HTMLInputElement).checked)" />
          </th>
          <th>ID</th>
          <th>角色名称</th>
          <th>角色编码</th>
          <th>描述</th>
          <th>状态</th>
        </tr>
      </thead>
      <tbody class="scrollable-tbody">
        <tr class="data" v-for="role in datas.list" v-bind:key="role.id" v-bind:class="{ selected: isSelected(role.id) }" @click="selectTr(role.id)">
          <td class="col-check">
            <input type="checkbox" :checked="isSelected(role.id)" @click.stop @change="toggleSelect(role.id, ($event.target as HTMLInputElement).checked)" />
          </td>
          <td v-text="role.id"></td>
          <td v-text="role.name"></td>
          <td v-text="role.code"></td>
          <td v-text="role.description || '-'"></td>
          <td v-text="role.status"></td>
        </tr>
      </tbody>
    </table>

    <div id="buttons">
      <button type="button" class="btn btn-primary" @click="showAdd">新增</button>
      <button type="button" class="btn btn-primary" @click="showUpdate">修改</button>
      <button type="button" class="btn btn-danger" @click="deleteData">删除</button>
    </div>
  </div>
</template>

<style scoped>
#container {
  width: 100%;
  margin: 0;
  padding: 10px;
  box-sizing: border-box;
  min-height: 100%;
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
</style>

