import axiosAPI from 'axios';
import type { Result } from '../types/api';

// 动态获取后端 API 地址
// 如果当前访问的是 localhost/127.0.0.1，则后端也用 localhost
// 否则使用当前页面的 hostname 和协议（支持局域网访问和生产环境）
const getApiBaseURL = () => {
  const hostname = window.location.hostname;
  const origin = window.location.origin; // e.g. http(s)://hradmin.stwood.cn
  
  // 开发环境（Vite dev server）：直连后端 8013
  // 典型场景：用局域网 IP 打开前端（如 10.x.x.x:5173），此时不应走 /api（会命中 Vite 自身导致 404）
  if (import.meta.env.DEV) {
    const devHost = hostname === 'localhost' || hostname === '127.0.0.1' ? 'localhost' : hostname;
    return `http://${devHost}:8013`;
  }
  
  // 生产环境：优先检查是否有环境变量配置的 API 路径
  // 如果通过反向代理（如 Nginx），API 路径可能是 /api 而不是 :8013
  // 可以通过在 index.html 中设置 window.API_BASE_PATH 来覆盖
  const apiBasePath = (window as any).API_BASE_PATH;
  
  if (apiBasePath) {
    // 如果配置了 API 路径，使用同源（HTTPS）或完整 URL
    return apiBasePath.startsWith('http') ? apiBasePath : `${origin}${apiBasePath}`;
  }
  
  // 默认：生产环境走同源 HTTPS，并统一加 /api 前缀
  // 需要 Nginx 配置：location ^~ /api/ { proxy_pass http://127.0.0.1:8013/; }
  return `${origin}/api`;
};

// 使用create({config})方法创建axios实例
const axios = axiosAPI.create({
  baseURL: getApiBaseURL(), // 动态获取后端 API 地址
  timeout: 5000, // 请求超时设置，单位ms
  headers: {
    'Content-Type': 'application/json'
  }
});

// 请求拦截器
axios.interceptors.request.use(
  (config) => {
    // 可以从 localStorage 获取 token（如果后续需要）
    const user = localStorage.getItem('user');
    if (user) {
      // 如果需要 token，可以在这里添加
      // const token = JSON.parse(user).token;
      // config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// 响应拦截器
axios.interceptors.response.use(
  (response) => {
    // 统一处理响应数据
    const result: Result<any> = response.data;
    
    // 如果后端返回的是统一格式
    if (result && typeof result === 'object' && 'code' in result) {
      // 如果 code 不是 200，抛出错误
      if (result.code !== 200) {
        return Promise.reject(new Error(result.message || '请求失败'));
      }
      // 返回整个 result 对象（包含 code, message, data）
      return response;
    }
    
    return response;
  },
  (error) => {
    // 统一错误处理
    if (error.response) {
      const { status, data } = error.response;
      
      switch (status) {
        case 401:
          // 未授权，清除登录信息并跳转到登录页
          localStorage.removeItem('user');
          localStorage.removeItem('permissions');
          localStorage.removeItem('roles');
          if (window.location.pathname !== '/login') {
            window.location.href = '/login';
          }
          return Promise.reject(new Error(data?.message || '未授权，请重新登录'));
        case 403:
          return Promise.reject(new Error(data?.message || '没有权限'));
        case 404:
          return Promise.reject(new Error('请求的资源不存在'));
        case 500:
          return Promise.reject(new Error(data?.message || '服务器错误'));
        default:
          return Promise.reject(new Error(data?.message || '请求失败'));
      }
    } else if (error.request) {
      return Promise.reject(new Error('网络错误，请检查网络连接'));
    } else {
      return Promise.reject(new Error(error.message || '请求失败'));
    }
  }
);

export default axios;
