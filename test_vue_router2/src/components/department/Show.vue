<script lang="ts" setup>
import axios from "../../util/axiosInstance"
import { ref, reactive } from "vue";
import { useRouter } from "vue-router";

interface Department {
  id: number;
  name: string;
  number: number;
}

const router = useRouter();
const selectedId = ref(-1);
const datas = reactive({
  form: {
    name: null as string | null,
    number: null as number | null
  },
  list: [] as Department[]
});

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
  selectedId.value = id;
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
  if (selectedId.value > -1) {
    if (confirm("确定要删除该部门吗？删除后该部门下的员工部门信息将被置空。")) {
      axios.delete('/dep23B/' + selectedId.value)
        .then((res) => {
          if (res.data == true) {
            alert("删除成功");
            search();
            selectedId.value = -1;
          } else {
            alert("删除失败");
          }
        })
        .catch((error) => {
          console.error('删除失败:', error);
          alert("删除失败，请稍后重试");
        });
    }
  } else {
    alert("请选中数据");
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

    <table class="table table-striped table-bordered table-hover">
      <thead>
        <tr>
          <th>ID</th>
          <th>部门编号</th>
          <th>部门名称</th>
        </tr>
      </thead>
      <tbody class="scrollable-tbody">
        <tr class="data" v-for="dep in datas.list" v-bind:key="dep.id" v-bind:class="{ selected: dep.id == selectedId }" @click="selectTr(dep.id)">
          <td v-text="dep.id"></td>
          <td v-text="dep.number"></td>
          <td v-text="dep.name"></td>
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
  width: 800px;
  margin: 10px auto;
}

#container .selected {
  background: #337ab7;
  color: #fff;
}

#buttons button {
  margin-right: 5px;
}

.table {
  width: 100%;
  display: block;
  overflow-x: auto;
}

.table thead,
.table tbody tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}

.table thead {
  width: calc(100% - 17px); /* Adjust for scrollbar width */
}

.scrollable-tbody {
  display: block;
  max-height: 300px; /* 根据需要调整高度 */
  overflow-y: auto;
  width: 100%;
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

