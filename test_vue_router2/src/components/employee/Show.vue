<script lang="ts" setup>
import axios from "../../util/axiosInstance"
import { ref, reactive } from "vue";
import { useRouter } from "vue-router";

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
const datas = reactive({
  form: {
    number: null as number | null,
    name: null as string | null,
    gender: "",
    age: null as number | null,
    'dep.id': ""
  },
  list: [] as Employee[],
  depList: [] as Department[]
});

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
  selectedId.value = id;
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
  if (selectedId.value > -1) {
    axios.delete('/emp/' + selectedId.value)
      .then((res) => {
        if (res.data == true) {
          search();
        } else {
          alert("系统错误");
        }
      });
  } else {
    alert("请选中数据");
  }
};

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
          <button type="submit" class="btn btn-primary">搜索</button>
        </div>
      </form>
    </div>

    <table class="table table-striped table-bordered table-hover">
      <thead>
        <tr>
          <th>编号</th>
          <th>名字</th>
          <th>性别</th>
          <th>年龄</th>
          <th>部门</th>
        </tr>
      </thead>
      <tbody class="scrollable-tbody">
        <tr class="data" v-for="emp in datas.list" v-bind:key="emp.id" v-bind:class="{ selected: emp.id == selectedId }" @click="selectTr(emp.id)">
          <td v-text="emp.number"></td>
          <td v-text="emp.name"></td>
          <td v-text="emp.gender"></td>
          <td v-text="emp.age"></td>
          <td v-text="emp.dep != null ? emp.dep.name : ''"></td>
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
</style>