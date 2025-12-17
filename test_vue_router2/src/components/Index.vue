<script lang="ts" setup>
import { onMounted, ref, computed } from "vue";
import { useRouter, useRoute } from "vue-router";
import { useAuth } from "../stores/auth";
import { useTheme } from "../util/useTheme";

const router = useRouter();
const route = useRoute();
const auth = useAuth();
const { theme, toggleTheme } = useTheme();

// 控制各个菜单的展开/收起状态
const empExpanded = ref(true);
const depExpanded = ref(true);
const permExpanded = ref(true);
const collapsed = ref(true);
const preview = ref('');
const previewTop = ref(0);
const hidePreviewTimer = ref<number | null>(null);

// 切换菜单展开/收起状态
const toggleMenu = (menu: string) => {
  if (menu === 'emp') {
    empExpanded.value = !empExpanded.value;
  } else if (menu === 'dep') {
    depExpanded.value = !depExpanded.value;
  } else if (menu === 'perm') {
    permExpanded.value = !permExpanded.value;
  }
};

const toggleCollapse = () => {
  collapsed.value = !collapsed.value;
};

const clearHidePreview = () => {
  if (hidePreviewTimer.value !== null) {
    clearTimeout(hidePreviewTimer.value);
    hidePreviewTimer.value = null;
  }
};

const scheduleHidePreview = () => {
  clearHidePreview();
  hidePreviewTimer.value = window.setTimeout(() => {
    preview.value = '';
  }, 200);
};

const showPreview = (menu: string, event: MouseEvent) => {
  if (!collapsed.value) return;
  clearHidePreview();
  const target = event.currentTarget as HTMLElement;
  const parent = target.parentElement as HTMLElement;
  const scrollTop = parent ? parent.scrollTop : 0;
  previewTop.value = target.offsetTop - scrollTop;
  preview.value = menu;
};

const hidePreview = () => {
  scheduleHidePreview();
};

// 检查权限
const hasPermission = (code: string) => {
  return auth.hasPermission(code);
};

const pageTitle = computed(() => {
  const metaTitle = (route.meta as any).title as string | undefined;
  return metaTitle ? `Alan人事管理系统 - ${metaTitle}` : "Alan人事管理系统";
});

// 登出
const handleLogout = () => {
  if (confirm('确定要退出登录吗？')) {
    auth.logout();
    router.push('/login');
  }
};

onMounted(() => {
  // 恢复登录状态
  auth.restoreAuth();

  // 如果未登录，跳转到登录页
  if (!auth.isAuthenticated.value) {
    router.push('/login');
    return;
  }

  // 仅当当前路径在根路径 "/" 时，才根据权限自动跳转到第一个有权限的页面
  // 这样在 /emp/show、/sysUser/show 等子路由刷新时，不会被强制跳回 /emp/show
  if (route.path === '/' || route.name === 'Index') {
    if (hasPermission('employee')) {
  router.push("/emp/show");
    } else if (hasPermission('department')) {
      router.push("/dep/show");
    } else if (hasPermission('sysUser')) {
      router.push("/sysUser/show");
    } else if (hasPermission('sysRole')) {
      router.push("/sysRole/show");
    } else if (hasPermission('sysPermission')) {
      router.push("/sysPermission/show");
    }
  }
});
</script>
<template>
<div id="container">
<div id="top">
  <div id="logo">{{ pageTitle }}</div>
  <div id="user-info">
    <button
      class="theme-btn"
      @click="toggleTheme"
      :title="theme === 'light' ? '切换到暗色模式' : '切换到亮色模式'"
    >
      <!-- 亮色模式下显示太阳 -->
      <svg
        v-if="theme === 'light'"
        class="theme-icon"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <circle cx="12" cy="12" r="4" fill="currentColor" />
        <path
          d="M12 2V4M12 20V22M4.22 4.22L5.64 5.64M18.36 18.36L19.78 19.78
             M2 12H4M20 12H22M4.22 19.78L5.64 18.36M18.36 5.64L19.78 4.22"
          stroke="currentColor"
          stroke-width="1.6"
          stroke-linecap="round"
        />
      </svg>
      <!-- 暗色模式下显示月亮 -->
      <svg
        v-else
        class="theme-icon"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M21 12.79C20.37 12.93 19.71 13 19.03 13C14.06 13 10.03 8.97 10.03 4
             C10.03 3.32 10.1 2.66 10.24 2.03C6.76 2.8 4.03 5.94 4.03 9.63
             C4.03 14.07 7.59 17.63 12.03 17.63C15.72 17.63 18.86 14.9 19.63 11.42
             Z"
          fill="currentColor"
        />
      </svg>
    </button>
    <span class="username">{{ auth.user.value?.username || '未登录' }}</span>
    <button class="logout-btn" @click="handleLogout">账号退出</button>
  </div>
</div>
<div id="main">
<div id="left" :class="{ collapsed }">
  <div v-if="hasPermission('employee')" class="menu-section" @mouseenter="showPreview('emp', $event)" @mouseleave="hidePreview">
    <div class="yi" @click="toggleMenu('emp')">
      <div class="menu-item-content">
        <svg class="menu-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          <path d="M20.59 22C20.59 18.13 16.74 15 12 15C7.26 15 3.41 18.13 3.41 22" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <span class="menu-text">员工管理</span>
      </div>
      <span class="arrow" :class="{ 'arrow-down': empExpanded }">▶</span>
    </div>
    <transition name="slide">
      <ul class="er" v-show="!collapsed && empExpanded">
        <li>
          <router-link to="/emp/show">员工管理</router-link>
        </li>
        <li>
          <router-link to="/emp/add">员工添加</router-link>
        </li>
      </ul>
    </transition>
  </div>

  <div v-if="hasPermission('department')" class="menu-section" @mouseenter="showPreview('dep', $event)" @mouseleave="hidePreview">
    <div class="yi" @click="toggleMenu('dep')">
      <div class="menu-item-content">
        <svg class="menu-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M3 9L12 2L21 9V20C21 20.5304 20.7893 21.0391 20.4142 21.4142C20.0391 21.7893 19.5304 22 19 22H5C4.46957 22 3.96086 21.7893 3.58579 21.4142C3.21071 21.0391 3 20.5304 3 20V9Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          <path d="M9 22V12H15V22" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <span class="menu-text">部门管理</span>
      </div>
      <span class="arrow" :class="{ 'arrow-down': depExpanded }">▶</span>
    </div>
    <transition name="slide">
      <ul class="er" v-show="!collapsed && depExpanded">
        <li><router-link to="/dep/show">部门管理</router-link></li>
        <li><router-link to="/dep/add">部门添加</router-link></li>
      </ul>
    </transition>
  </div>

  <div v-if="hasPermission('sysUser') || hasPermission('sysRole') || hasPermission('sysPermission')" class="menu-section" @mouseenter="showPreview('perm', $event)" @mouseleave="hidePreview">
    <div class="yi" @click="toggleMenu('perm')">
      <div class="menu-item-content">
        <svg class="menu-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          <path d="M7 11V7C7 5.67392 7.52678 4.40215 8.46447 3.46447C9.40215 2.52678 10.6739 2 12 2C13.3261 2 14.5979 2.52678 15.5355 3.46447C16.4732 4.40215 17 5.67392 17 7V11" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <span class="menu-text">权限管理</span>
      </div>
      <span class="arrow" :class="{ 'arrow-down': permExpanded }">▶</span>
    </div>
    <transition name="slide">
      <ul class="er" v-show="!collapsed && permExpanded">
        <li v-if="hasPermission('sysUser')"><router-link to="/sysUser/show">用户管理</router-link></li>
        <li v-if="hasPermission('sysRole')"><router-link to="/sysRole/show">角色管理</router-link></li>
        <li v-if="hasPermission('sysPermission')"><router-link to="/sysPermission/show">权限管理</router-link></li>
      </ul>
    </transition>
  </div>

  <div v-if="collapsed && preview" class="preview" :style="{ top: previewTop + 'px' }" @mouseenter="clearHidePreview" @mouseleave="hidePreview">
    <template v-if="preview === 'emp' && hasPermission('employee')">
      <router-link class="preview-item" to="/emp/show">员工管理</router-link>
      <router-link class="preview-item" to="/emp/add">员工添加</router-link>
    </template>
    <template v-else-if="preview === 'dep' && hasPermission('department')">
      <router-link class="preview-item" to="/dep/show">部门管理</router-link>
      <router-link class="preview-item" to="/dep/add">部门添加</router-link>
    </template>
    <template v-else-if="preview === 'perm'">
      <router-link v-if="hasPermission('sysUser')" class="preview-item" to="/sysUser/show">用户管理</router-link>
      <router-link v-if="hasPermission('sysRole')" class="preview-item" to="/sysRole/show">角色管理</router-link>
      <router-link v-if="hasPermission('sysPermission')" class="preview-item" to="/sysPermission/show">权限管理</router-link>
    </template>
  </div>
</div>
<button class="collapse-btn" @click="toggleCollapse" :style="{ left: collapsed ? '64px' : '240px' }">
  <svg class="collapse-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" :class="{ 'collapse-icon-rotated': !collapsed }">
    <path d="M10 6L16 12L10 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>
</button>
<div id="right">
<router-view/>
</div>
</div>
<!-- <div id="bottom"></div> -->
</div>
</template>
<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#container {
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  margin: 0;
  padding: 0;
  overflow: hidden;
}

#top {
  width: 100%;
  height: 60px;
  background: var(--color-primary);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

#top #logo {
  color: #fff;
  font-size: 24px;
  font-weight: bold;
}

#user-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.theme-btn {
  padding: 6px;
  background: transparent;
  color: #fff;
  border: none;
  border-radius: 50%;
  cursor: pointer;
  font-size: 13px;
  outline: none;
}

.theme-btn:focus,
.theme-btn:focus-visible,
.theme-btn:active {
  outline: none;
  box-shadow: none;
}

.theme-icon {
  width: 22px;
  height: 22px;
  display: block;
}

.username {
  color: #fff;
  font-size: 14px;
}

.logout-btn {
  padding: 0;
  background: transparent;
  color: #fff;
  border: none;
  border-radius: 0;
  cursor: pointer;
  font-size: 14px;
  outline: none;
}

.logout-btn:hover {
  text-decoration: underline;
}

.logout-btn:focus,
.logout-btn:focus-visible,
.logout-btn:active {
  outline: none;
  box-shadow: none;
}

#bottom {
  width: 100%;
  height: 40px;
  background: var(--color-primary);
  flex-shrink: 0;
}

#main {
  flex: 1;
  display: flex;
  overflow: hidden;
  width: 100%;
  position: relative;
}

a {
  color: #fff;
  text-decoration: none;
  display: block;
  width: 100%;
  height: 100%;
}

#left {
  width: 240px;
  flex-shrink: 0;
  background: var(--color-bg);
  padding: 10px;
  overflow: visible;
  border-right: 1px solid #ddd;
  position: relative;
  transition: width 0.2s ease;
}

#left.collapsed {
  width: 64px;
  padding: 10px 6px;
}

#left.collapsed .menu-text,
#left.collapsed .arrow,
#left.collapsed .er {
  display: none;
}

#left.collapsed .yi {
  justify-content: center;
}

#left.collapsed .menu-icon {
  margin-right: 0;
}

#left .menu-section {
  position: relative;
}

#left .menu-section + .menu-section {
  margin-top: 10px;
}

#right {
  flex: 1;
  overflow: hidden;
  padding: 10px;
  background: var(--color-bg);
  color: var(--color-text);
}

.yi {
  width: 100%;
  height: 40px;
  background: var(--color-primary);
  color: var(--color-text-light);
  margin-top: 10px;
  border-radius: 3px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 15px;
  transition: background-color 0.3s;
  user-select: none;
}

.yi:hover {
  background: var(--color-primary-hover);
}

.yi:first-child {
  margin-top: 0;
}

.menu-item-content {
  display: flex;
  align-items: center;
  gap: 10px;
  flex: 1;
}

.menu-icon {
  width: 20px;
  height: 20px;
  flex-shrink: 0;
  stroke: currentColor;
  fill: none;
}

.collapse-btn {
  position: absolute;
  top: 50%;
  width: 24px;
  height: 40px;
  border: none;
  outline: none;
  border-radius: 0 12px 12px 0;
  background: var(--color-surface);
  /* 阴影整体偏向右下，亮色为黑色阴影，暗色为白色阴影 */
  box-shadow: 3px 4px 8px var(--color-shadow-soft);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  padding: 0;
  z-index: 50;
  transform: translateY(-50%);
}

/* .collapse-btn:hover {
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
} */

.collapse-icon {
  width: 18px;
  height: 18px;
  color: var(--color-text);
  transition: transform 0.2s ease;
}

.collapse-icon-rotated {
  transform: rotate(180deg);
}

.preview {
  position: absolute;
  left: 72px;
  background: var(--color-surface);
  box-shadow: 0 6px 18px rgba(0,0,0,0.35);
  border-radius: 8px;
  padding: 8px 0;
  min-width: 180px;
  z-index: 80;
}

.preview-item {
  display: block;
  padding: 8px 16px;
  color: var(--color-text);
  text-decoration: none;
  font-size: 14px;
}

.preview-item:hover {
  background: var(--color-table-row-hover-bg);
}

.yi .arrow {
  font-size: 12px;
  transition: transform 0.3s;
  display: inline-block;
  flex-shrink: 0;
  margin-left: 10px;
}

.yi .arrow-down {
  transform: rotate(90deg);
}

.er {
  list-style: none;
  width: 100%;
  margin-bottom: 10px;
}

.er li {
  margin-top: 5px;
  text-align: center;
  background: #337aae;
  color: #fff;
  height: 35px;
  line-height: 35px;
  font-size: 14px;
  border-radius: 3px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.er li:hover {
  background: #286090;
}

.er li a {
  display: block;
  width: 100%;
  height: 100%;
  line-height: 35px;
}

/* 折叠展开动画 */
.slide-enter-active,
.slide-leave-active {
  transition: all 0.3s ease;
  overflow: hidden;
}

.slide-enter-from,
.slide-leave-to {
  max-height: 0;
  opacity: 0;
  margin-bottom: 0;
}

.slide-enter-to,
.slide-leave-from {
  max-height: 200px;
  opacity: 1;
}

/* 响应式设计 */
@media (max-width: 768px) {
  #top #logo {
    font-size: 18px;
  }

  #main {
    flex-direction: column;
  }

  #left {
    width: 100%;
    max-height: 200px;
    border-right: none;
    border-bottom: 1px solid #ddd;
  }

  #right {
    width: 100%;
  }

  .yi {
    font-size: 14px;
    height: 35px;
    line-height: 35px;
  }

  .er li {
    height: 30px;
    line-height: 30px;
    font-size: 12px;
  }
}

@media (max-width: 480px) {
  #top {
    height: 50px;
    padding: 0 10px;
  }

  #top #logo {
    font-size: 16px;
  }

  #bottom {
    height: 30px;
  }

  #left {
    padding: 5px;
    max-height: 150px;
  }

  #right {
    padding: 5px;
  }
}
</style>