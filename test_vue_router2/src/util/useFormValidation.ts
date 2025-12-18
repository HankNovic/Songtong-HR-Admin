import { Ref } from 'vue';

/**
 * 用户表单校验
 */
export interface UserForm {
  username: string | null;
  password: string | null;
  name: string | null;
  email: string | null;
  status: string | null;
}

export const validateUserForm = (
  form: UserForm,
  errorMessage: Ref<string>,
  isEdit: boolean = false
): boolean => {
  errorMessage.value = "";

  // 用户名校验
  if (!form.username || form.username.trim() === "") {
    errorMessage.value = "请输入用户名";
    return false;
  }
  const username = form.username.trim();
  if (username.length < 3 || username.length > 20) {
    errorMessage.value = "用户名长度必须在3-20个字符之间";
    return false;
  }
  if (!/^[a-zA-Z0-9_]+$/.test(username)) {
    errorMessage.value = "用户名只能包含字母、数字和下划线";
    return false;
  }

  // 密码校验
  if (!isEdit) {
    // 新增时密码必填
    if (!form.password || form.password.trim() === "") {
      errorMessage.value = "请输入密码";
      return false;
    }
    const password = form.password.trim();
    if (password.length < 6 || password.length > 20) {
      errorMessage.value = "密码长度必须在6-20个字符之间";
      return false;
    }
  } else {
    // 编辑时密码可选，但如果填写了需要符合规则
    if (form.password && form.password.trim() !== "") {
      const password = form.password.trim();
      if (password.length < 6 || password.length > 20) {
        errorMessage.value = "密码长度必须在6-20个字符之间";
        return false;
      }
    }
  }

  // 姓名校验（可选，但如果填写了需要符合规则）
  if (form.name && form.name.trim() !== "") {
    const name = form.name.trim();
    if (name.length > 50) {
      errorMessage.value = "姓名长度不能超过50个字符";
      return false;
    }
  }

  // 邮箱校验（可选，但如果填写了需要符合邮箱格式）
  if (form.email && form.email.trim() !== "") {
    const email = form.email.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      errorMessage.value = "请输入有效的邮箱地址";
      return false;
    }
    if (email.length > 100) {
      errorMessage.value = "邮箱长度不能超过100个字符";
      return false;
    }
  }

  // 状态校验
  if (!form.status || (form.status !== "启用" && form.status !== "禁用")) {
    errorMessage.value = "请选择状态";
    return false;
  }

  return true;
};

/**
 * 部门表单校验
 */
export interface DepartmentForm {
  number: number | null;
  name: string | null;
}

export const validateDepartmentForm = (
  form: DepartmentForm,
  errorMessage: Ref<string>
): boolean => {
  errorMessage.value = "";

  if (!form.number && form.number !== 0) {
    errorMessage.value = "请输入部门编号";
    return false;
  }
  const number = Number(form.number);
  if (Number.isNaN(number) || number <= 0) {
    errorMessage.value = "部门编号必须是大于 0 的数字";
    return false;
  }

  if (!form.name || form.name.trim() === "") {
    errorMessage.value = "请输入部门名称";
    return false;
  }

  return true;
};

/**
 * 员工表单校验
 */
export interface EmployeeForm {
  number: number | null;
  name: string | null;
  gender: string | null;
  age: number | null;
  dep: { id: number | null } | null;
}

export const validateEmployeeForm = (
  form: EmployeeForm,
  errorMessage: Ref<string>
): boolean => {
  errorMessage.value = "";

  const number = Number(form.number);
  if (!form.number || Number.isNaN(number) || number <= 0) {
    errorMessage.value = "编号必须是大于 0 的数字";
    return false;
  }

  if (!form.name || !String(form.name).trim()) {
    errorMessage.value = "名字不能为空";
    return false;
  }

  if (!form.gender) {
    errorMessage.value = "请选择性别";
    return false;
  }

  const age = Number(form.age);
  if (!form.age || Number.isNaN(age) || age <= 0 || age > 120) {
    errorMessage.value = "年龄请输入 1-120 的数字";
    return false;
  }

  if (!form.dep?.id) {
    errorMessage.value = "请选择部门";
    return false;
  }

  return true;
};

