import axios from "../util/axiosInstance";
import type { Result } from "../types/api";

// 获取角色的权限ID列表
export async function getRolePermissions(roleId: number): Promise<Result<number[]>> {
  const res = await axios.get(`/sysRole/${roleId}/permissions`);
  return res.data;
}

// 更新角色的权限ID列表（覆盖式）
export async function updateRolePermissions(roleId: number, permissionIds: number[]): Promise<Result<boolean>> {
  const res = await axios.put(`/sysRole/${roleId}/permissions`, permissionIds);
  return res.data;
}

