package com.lz08.hrsys_ssm2.dao;

import com.lz08.hrsys_ssm2.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    /**
     * 根据用户名查询用户
     */
    User findByUsername(@Param("username") String username);

    /**
     * 根据ID查询用户
     */
    User findById(@Param("id") Integer id);

    /**
     * 查询用户的所有角色
     */
    List<Integer> findRoleIdsByUserId(@Param("userId") Integer userId);

    /**
     * 查询角色的所有权限
     */
    List<Integer> findPermissionIdsByRoleId(@Param("roleId") Integer roleId);

    /**
     * 查询所有用户
     */
    List<User> findAll();

    /**
     * 查询所有角色
     */
    List<com.lz08.hrsys_ssm2.entity.Role> findAllRoles();

    /**
     * 查询所有权限
     */
    List<com.lz08.hrsys_ssm2.entity.Permission> findAllPermissions();

    /**
     * 根据ID查询权限
     */
    com.lz08.hrsys_ssm2.entity.Permission findPermissionById(@Param("id") Integer id);

    // 用户 CRUD
    int insertUser(User user);
    int updateUser(User user);
    int deleteUser(@Param("id") Integer id);
    int batchUpdateUsers(@Param("users") List<User> users);

    // 角色 CRUD
    int insertRole(com.lz08.hrsys_ssm2.entity.Role role);
    int updateRole(com.lz08.hrsys_ssm2.entity.Role role);
    int deleteRole(@Param("id") Integer id);

    // 权限 CRUD
    int insertPermission(com.lz08.hrsys_ssm2.entity.Permission permission);
    int updatePermission(com.lz08.hrsys_ssm2.entity.Permission permission);
    int deletePermission(@Param("id") Integer id);

    // 关联清理
    int deleteUserRoles(@Param("userId") Integer userId);
    int deleteRolePermissions(@Param("roleId") Integer roleId);
    int deleteUserRolesByRoleId(@Param("roleId") Integer roleId);
    int deleteRolePermissionsByPermission(@Param("permissionId") Integer permissionId);

    // 关联新增
    int insertUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId);
    int insertRolePermission(@Param("roleId") Integer roleId, @Param("permissionId") Integer permissionId);
}

