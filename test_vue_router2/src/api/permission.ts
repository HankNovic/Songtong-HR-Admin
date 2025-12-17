import axios from '../util/axiosInstance';
import type { Result } from '../types/api';
import type { Permission } from '../types/user';

/**
 * 查询所有权限
 */
export async function getAllPermissions(): Promise<Result<Permission[]>> {
  const response = await axios.get('/sysPermission');
  return response.data;
}

export async function createPermission(payload: Partial<Permission>): Promise<Result<boolean>> {
  const response = await axios.post('/sysPermission', payload);
  return response.data;
}

export async function updatePermission(payload: Partial<Permission> & { id: number }): Promise<Result<boolean>> {
  const response = await axios.put('/sysPermission', payload);
  return response.data;
}

export async function deletePermission(id: number): Promise<Result<boolean>> {
  const response = await axios.delete(`/sysPermission/${id}`);
  return response.data;
}

