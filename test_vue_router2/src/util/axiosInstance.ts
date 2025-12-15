import axiosAPI from 'axios';

// 使用create({config})方法创建axios实例
const axios = axiosAPI.create({
  baseURL: 'http://localhost:8013', // 请求后端数据的地址
  timeout: 5000, // 请求超时设置，单位ms
  headers: {
    'Content-Type': 'application/json'
  }
});

export default axios;
