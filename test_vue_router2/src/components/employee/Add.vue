<script lang="ts" setup>
import axios from "../../util/axiosInstance"
import { reactive } from "vue";
import { useRouter } from "vue-router";

interface Department {
  id: number;
  name: string;
}

const router = useRouter();
const datas = reactive({
  form: {
    number: null as number | null,
    name: null as string | null,
    gender: null as string | null,
    age: null as number | null,
    dep: { id: null as number | null }
  },
  depList: [] as Department[]
});

const add = () => {
  axios.post('/emp', datas.form)
    .then((res) => {
      if (res.data == true) {
        router.push({ name: "EmpShow" })
      } else {
        alert("系统错误");
      }
    });
};

// 从后端获取部门列表
const searchDep = () => {
  axios.get('/dep23B')
    .then((res) => {
      datas.depList = res.data;
      console.log('部门数据加载成功:', res.data);
      // 如果部门列表不为空，设置默认选中第一个部门
      if (datas.depList.length > 0) {
        datas.form.dep.id = datas.depList[0].id;
      }
    })
    .catch((error) => {
      console.error('部门数据加载失败:', error);
      datas.depList = [];
    });
};

searchDep();
</script>

<template>
  <div id="container">
    <form class="form-horizontal" @submit.prevent="add">
      <div class="form-group">
        <label class="col-sm-2 control-label">编号</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" placeholder="请输入编号" v-model="datas.form.number">
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">名字</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" placeholder="请输入名字" v-model="datas.form.name">
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">性别</label>
        <div class="col-sm-10">
          <input type="radio" value="男" v-model="datas.form.gender"/>男
          <input type="radio" value="女" v-model="datas.form.gender"/>女
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">年龄</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" placeholder="请输入年龄" v-model="datas.form.age">
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">部门</label>
        <div class="col-sm-10">
          <select class="form-control" v-model="datas.form.dep.id">
            <option v-for="dep in datas.depList" v-text="dep.name" v-bind:key="dep.id" v-bind:value="dep.id"></option>
          </select>
        </div>
      </div>
      <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-primary">保存</button>
      </div>
    </div>
    </form>
  </div>
</template>

<style scoped>
#container {
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
  padding: 10px;
  box-sizing: border-box;
  min-height: 100%;
  display: flex;
  flex-direction: column;
}

#buttons {
  margin-top: auto;
  padding-top: 10px;
  align-self: flex-start;
}
</style>