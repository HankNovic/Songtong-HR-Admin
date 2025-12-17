import axios from '../util/axiosInstance';
import type { Result } from '../types/api';
import type { Role } from '../types/user';

/**
 * 查询所有角色
 */
export async function getAllRoles(): Promise<Result<Role[]>> {
  const response = await axios.get('/sysRole');
  return response.data;
}

export async function createRole(payload: Partial<Role>): Promise<Result<boolean>> {
  const response = await axios.post('/sysRole', payload);
  return response.data;
}

export async function updateRole(payload: Partial<Role> & { id: number }): Promise<Result<boolean>> {
  const response = await axios.put('/sysRole', payload);
  return response.data;
}

export async function deleteRole(id: number): Promise<Result<boolean>> {
  const response = await axios.delete(`/sysRole/${id}`);
  return response.data;
}

