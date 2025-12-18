import axios from '../util/axiosInstance';
import type { Result, LoginResponse } from '../types/api';

export interface LoginRequest {
  username: string;
  password: string;
}

/**
 * 用户登录
 */
export async function login(request: LoginRequest): Promise<Result<LoginResponse>> {
  const response = await axios.post('/auth/login', request);
  return response.data;
}

/**
 * 获取用户权限列表
 */
export async function getPermissions(userId: number): Promise<Result<string[]>> {
  const response = await axios.get('/auth/permissions', {
    params: { userId }
  });
  return response.data;
}

