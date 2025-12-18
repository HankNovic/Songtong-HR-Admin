package com.lz08.hrsys_ssm2.service;

import com.lz08.hrsys_ssm2.entity.Permission;
import com.lz08.hrsys_ssm2.entity.Role;
import com.lz08.hrsys_ssm2.entity.User;

import java.util.List;

public interface UserService {
    /**
     * 根据用户名查询用户（包含角色和权限）
     */
    User findByUsernameWithRolesAndPermissions(String username);

    /**
     * 验证用户登录
     * @param username 用户名
     * @param password 明文密码
     * @return 验证成功返回用户信息（包含权限），失败返回null
     */
    User login(String username, String password);

    /**
     * 查询所有用户
     */
    List<User> findAllUsers();

    /**
     * 查询所有角色
     */
    List<Role> findAllRoles();

    /**
     * 查询所有权限
     */
    List<Permission> findAllPermissions();

    /**
     * 根据用户ID查询权限列表
     */
    List<Permission> findPermissionsByUserId(Integer userId);
    List<Integer> findPermissionIdsByRoleId(Integer roleId);
    List<Integer> findRoleIdsByUserId(Integer userId);

    // 用户 CRUD
    boolean createUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(Integer id);
    boolean batchUpdateUsers(List<User> users);
    boolean updateUserRoles(Integer userId, List<Integer> roleIds);

    // 角色 CRUD
    boolean createRole(Role role);
    boolean updateRole(Role role);
    boolean deleteRole(Integer id);
    boolean updateRolePermissions(Integer roleId, List<Integer> permissionIds);

    // 权限 CRUD
    boolean createPermission(Permission permission);
    boolean updatePermission(Permission permission);
    boolean deletePermission(Integer id);
}

