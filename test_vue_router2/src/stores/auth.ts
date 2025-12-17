import { ref, computed } from 'vue';
import type { User } from '../types/user';
import { login as loginApi } from '../api/auth';

// 用户信息
const user = ref<User | null>(null);
// 权限列表
const permissions = ref<string[]>([]);
// 角色列表
const roles = ref<string[]>([]);

/**
 * 登录
 */
export function useAuth() {
  const login = async (username: string, password: string) => {
    try {
      const response = await loginApi({ username, password });
      if (response.code === 200) {
        const { user: userData, permissions: perms, roles: roleList } = response.data;
        user.value = userData;
        permissions.value = perms;
        roles.value = roleList;
        
        // 保存到 localStorage
        localStorage.setItem('user', JSON.stringify(userData));
        localStorage.setItem('permissions', JSON.stringify(perms));
        localStorage.setItem('roles', JSON.stringify(roleList));
        
        return { success: true, message: '登录成功' };
      } else {
        return { success: false, message: response.message || '登录失败' };
      }
    } catch (error: any) {
      console.error('登录错误:', error);
      return { 
        success: false, 
        message: error.message || '网络错误，请稍后重试' 
      };
    }
  };

  /**
   * 登出
   */
  const logout = () => {
    user.value = null;
    permissions.value = [];
    roles.value = [];
    localStorage.removeItem('user');
    localStorage.removeItem('permissions');
    localStorage.removeItem('roles');
  };

  /**
   * 检查是否有权限
   */
  const hasPermission = (code: string): boolean => {
    return permissions.value.includes(code);
  };

  /**
   * 检查是否有角色
   */
  const hasRole = (code: string): boolean => {
    return roles.value.includes(code);
  };

  /**
   * 从 localStorage 恢复登录状态
   */
  const restoreAuth = () => {
    const savedUser = localStorage.getItem('user');
    const savedPermissions = localStorage.getItem('permissions');
    const savedRoles = localStorage.getItem('roles');
    
    if (savedUser) {
      user.value = JSON.parse(savedUser);
    }
    if (savedPermissions) {
      permissions.value = JSON.parse(savedPermissions);
    }
    if (savedRoles) {
      roles.value = JSON.parse(savedRoles);
    }
  };

  return {
    user: computed(() => user.value),
    permissions: computed(() => permissions.value),
    roles: computed(() => roles.value),
    isAuthenticated: computed(() => user.value !== null),
    login,
    logout,
    hasPermission,
    hasRole,
    restoreAuth
  };
}

