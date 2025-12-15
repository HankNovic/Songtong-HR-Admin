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

createApp(App).use(router).mount('#app')
