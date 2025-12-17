import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import { COLOR_VARS } from './constants/colors'

import "jquery"
import "bootstrap"
import "bootstrap/dist/css/bootstrap.css"

// 注入全局颜色变量到 :root
const root = document.documentElement;
Object.entries(COLOR_VARS).forEach(([key, value]) => {
  root.style.setProperty(key, value);
});

// 在应用启动时恢复登录状态（从 localStorage）
const savedUser = localStorage.getItem('user');
const savedPermissions = localStorage.getItem('permissions');
const savedRoles = localStorage.getItem('roles');
if (savedUser || savedPermissions || savedRoles) {
  // 登录状态会在路由守卫中恢复
}

createApp(App).use(router).mount('#app')
