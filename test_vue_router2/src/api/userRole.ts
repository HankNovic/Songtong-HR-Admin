import axios from "../util/axiosInstance";
import type { Result } from "../types/api";

// 获取用户的角色ID列表
export async function getUserRoles(userId: number): Promise<Result<number[]>> {
  const res = await axios.get(`/sysUser/${userId}/roles`);
  return res.data;
}

// 更新用户的角色ID列表（覆盖式）
export async function updateUserRoles(userId: number, roleIds: number[]): Promise<Result<boolean>> {
  const res = await axios.put(`/sysUser/${userId}/roles`, roleIds);
  return res.data;
}

