import axios from '../util/axiosInstance';
import type { Result } from '../types/api';
import type { User } from '../types/user';

/**
 * 查询所有用户
 */
export async function getAllUsers(): Promise<Result<User[]>> {
  const response = await axios.get('/sysUser');
  return response.data;
}

export async function createUser(payload: Partial<User> & { password?: string }): Promise<Result<boolean>> {
  const response = await axios.post('/sysUser', payload);
  return response.data;
}

export async function updateUser(payload: Partial<User> & { id: number }): Promise<Result<boolean>> {
  const response = await axios.put('/sysUser', payload);
  return response.data;
}

export async function deleteUser(id: number): Promise<Result<boolean>> {
  const response = await axios.delete(`/sysUser/${id}`);
  return response.data;
}

export async function batchUpdateUsers(payload: Array<Pick<User, 'id' | 'name' | 'email' | 'status'>>): Promise<Result<boolean>> {
  const response = await axios.put('/sysUser/batch', payload);
  return response.data;
}

