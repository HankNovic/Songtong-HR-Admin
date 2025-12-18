<script lang="ts" setup>
import axios from "../../util/axiosInstance"
import { reactive, ref } from "vue";
import { useRouter } from "vue-router";
import { validateDepartmentForm } from "../../util/useFormValidation";

const router = useRouter();
const datas = reactive({
  form: {
    name: null as string | null,
    number: null as number | null
  }
});

const errorMessage = ref("");

const validateForm = (): boolean => {
  return validateDepartmentForm(datas.form, errorMessage);
};

const add = () => {
  if (!validateForm()) {
    return;
  }

  const payload = {
    ...datas.form,
    number: Number(datas.form.number),
  };

  axios.post('/dep23B', payload)
    .then((res) => {
      if (res.data == true) {
        alert("添加成功");
        router.push({ name: "DepShow" });
      } else {
        alert("添加失败，请稍后重试");
      }
    })
    .catch((error) => {
      console.error('添加部门失败:', error);
      alert("添加失败，请稍后重试");
    });
};
</script>

<template>
  <div id="container">
    <form class="form-horizontal" @submit.prevent="add">
      <div class="form-group">
        <label class="col-sm-2 control-label">部门编号</label>
        <div class="col-sm-10">
          <input type="number" class="form-control" placeholder="请输入部门编号" v-model="datas.form.number">
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">部门名称</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" placeholder="请输入部门名称" v-model="datas.form.name">
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
          <div v-if="errorMessage" class="error-message">
            {{ errorMessage }}
          </div>
          <button type="submit" class="btn btn-primary">保存</button>
          <button type="button" class="btn btn-default" @click="router.push({ name: 'DepShow' })" style="margin-left: 10px;">取消</button>
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

.form-group {
  margin-bottom: 15px;
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

.control-label {
  padding-top: 7px;
  margin-bottom: 0;
  text-align: right;
  font-weight: 700;
}

.col-sm-2 {
  width: 16.66666667%;
  float: left;
  position: relative;
  min-height: 1px;
  padding-right: 15px;
  padding-left: 15px;
}

.col-sm-10 {
  width: 83.33333333%;
  float: left;
  position: relative;
  min-height: 1px;
  padding-right: 15px;
  padding-left: 15px;
}

.col-sm-offset-2 {
  margin-left: 16.66666667%;
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

#buttons {
  margin-top: auto;
  padding-top: 10px;
  align-self: flex-start;
}

.error-message {
  margin-bottom: 10px;
  padding: 8px 12px;
  border-radius: 4px;
  background-color: #fee;
  color: #c33;
  font-size: 13px;
}
</style>

