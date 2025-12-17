import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import { applyTheme, getInitialTheme } from './util/useTheme'
import { autoBlur } from './directives/autoBlur'

import "jquery"
import "bootstrap"
import "bootstrap/dist/css/bootstrap.css"

// 应用初始主题（亮/暗）
applyTheme(getInitialTheme());

// 在应用启动时恢复登录状态（从 localStorage）
const savedUser = localStorage.getItem('user');
const savedPermissions = localStorage.getItem('permissions');
const savedRoles = localStorage.getItem('roles');
if (savedUser || savedPermissions || savedRoles) {
  // 登录状态会在路由守卫中恢复
}

const app = createApp(App);
app.use(router);
app.directive('auto-blur', autoBlur);
app.mount('#app');
