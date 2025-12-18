package com.lz08.hrsys_ssm2.service.impl;

import com.lz08.hrsys_ssm2.dao.UserDao;
import com.lz08.hrsys_ssm2.entity.Permission;
import com.lz08.hrsys_ssm2.entity.Role;
import com.lz08.hrsys_ssm2.entity.User;
import com.lz08.hrsys_ssm2.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public User findByUsernameWithRolesAndPermissions(String username) {
        User user = userDao.findByUsername(username);
        if (user == null) {
            return null;
        }

        // 查询用户的角色
        List<Integer> roleIds = userDao.findRoleIdsByUserId(user.getId());
        List<Role> roles = new ArrayList<>();
        
        if (roleIds != null && !roleIds.isEmpty()) {
            // 查询所有角色
            List<Role> allRoles = userDao.findAllRoles();
            Map<Integer, Role> roleMap = allRoles.stream()
                    .collect(Collectors.toMap(Role::getId, role -> role));
            
            // 查询每个角色的权限
            for (Integer roleId : roleIds) {
                Role role = roleMap.get(roleId);
                if (role != null) {
                    List<Integer> permissionIds = userDao.findPermissionIdsByRoleId(roleId);
                    if (permissionIds != null && !permissionIds.isEmpty()) {
                        // 查询所有权限
                        List<Permission> allPermissions = userDao.findAllPermissions();
                        Map<Integer, Permission> permissionMap = allPermissions.stream()
                                .collect(Collectors.toMap(Permission::getId, permission -> permission));
                        
                        List<Permission> rolePermissions = permissionIds.stream()
                                .map(permissionMap::get)
                                .filter(Objects::nonNull)
                                .collect(Collectors.toList());
                        role.setPermissions(rolePermissions);
                    } else {
                        role.setPermissions(new ArrayList<>());
                    }
                    roles.add(role);
                }
            }
        }
        
        user.setRoles(roles);
        return user;
    }

    @Override
    public User login(String username, String password) {
        User user = findByUsernameWithRolesAndPermissions(username);
        if (user == null) {
            return null;
        }

        // 验证密码（BCrypt加密）
        if (passwordEncoder.matches(password, user.getPassword())) {
            // 密码验证成功，清除密码字段
            user.setPassword(null);
            return user;
        }

        return null;
    }

    @Override
    public List<User> findAllUsers() {
        List<User> users = userDao.findAll();
        if (users == null || users.isEmpty()) {
            return users;
        }

        // 预先查询所有角色，构建映射
        List<Role> allRoles = userDao.findAllRoles();
        Map<Integer, Role> roleMap = allRoles.stream()
                .collect(Collectors.toMap(Role::getId, r -> r));

        // 为每个用户填充已分配角色列表
        for (User user : users) {
            List<Integer> roleIds = userDao.findRoleIdsByUserId(user.getId());
            if (roleIds != null && !roleIds.isEmpty()) {
                List<Role> roles = roleIds.stream()
                        .map(roleMap::get)
                        .filter(Objects::nonNull)
                        .collect(Collectors.toList());
                user.setRoles(roles);
            } else {
                user.setRoles(new ArrayList<>());
            }
        }
        return users;
    }

    @Override
    public List<Role> findAllRoles() {
        return userDao.findAllRoles();
    }

    @Override
    public List<Permission> findAllPermissions() {
        return userDao.findAllPermissions();
    }

    @Override
    public List<Integer> findRoleIdsByUserId(Integer userId) {
        return userDao.findRoleIdsByUserId(userId);
    }

    @Override
    public List<Integer> findPermissionIdsByRoleId(Integer roleId) {
        return userDao.findPermissionIdsByRoleId(roleId);
    }

    @Override
    public List<Permission> findPermissionsByUserId(Integer userId) {
        // 查询用户的所有角色ID
        List<Integer> roleIds = userDao.findRoleIdsByUserId(userId);
        if (roleIds == null || roleIds.isEmpty()) {
            return new ArrayList<>();
        }

        // 查询所有权限
        List<Permission> allPermissions = userDao.findAllPermissions();
        Map<Integer, Permission> permissionMap = allPermissions.stream()
                .collect(Collectors.toMap(Permission::getId, permission -> permission));

        // 收集用户所有角色下的权限
        Set<Integer> permissionIds = new HashSet<>();
        for (Integer roleId : roleIds) {
            List<Integer> rolePermissionIds = userDao.findPermissionIdsByRoleId(roleId);
            if (rolePermissionIds != null) {
                permissionIds.addAll(rolePermissionIds);
            }
        }

        // 返回去重后的权限列表
        return permissionIds.stream()
                .map(permissionMap::get)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    // ================= 用户 CRUD =================
    @Override
    public boolean createUser(User user) {
        if (user.getPassword() != null) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        // 默认状态：启用
        if (user.getStatus() == null || user.getStatus().isEmpty()) {
            user.setStatus("启用");
        }
        return userDao.insertUser(user) > 0;
    }

    @Override
    public boolean updateUser(User user) {
        // 如果传入了密码，则重新加密；如果未传密码，则保持原密码
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        } else {
            // 保持旧密码
            if (user.getUsername() != null) {
                User dbUser = userDao.findByUsername(user.getUsername());
                if (dbUser != null) {
                    user.setPassword(dbUser.getPassword());
                }
            }
        }
        return userDao.updateUser(user) > 0;
    }

    @Override
    public boolean batchUpdateUsers(List<User> users) {
        if (users == null || users.isEmpty()) {
            return true;
        }
        return userDao.batchUpdateUsers(users) > 0;
    }

    @Override
    public boolean deleteUser(Integer id) {
        // 先清理关联
        userDao.deleteUserRoles(id);
        return userDao.deleteUser(id) > 0;
    }

    // ================= 角色 CRUD =================
    @Override
    public boolean createRole(Role role) {
        if (role.getStatus() == null || role.getStatus().isEmpty()) {
            role.setStatus("启用");
        }
        return userDao.insertRole(role) > 0;
    }

    @Override
    public boolean updateRole(Role role) {
        return userDao.updateRole(role) > 0;
    }

    @Override
    public boolean deleteRole(Integer id) {
        // 先清理关联
        userDao.deleteRolePermissions(id);
        userDao.deleteUserRolesByRoleId(id);
        return userDao.deleteRole(id) > 0;
    }

    // ================= 权限 CRUD =================
    @Override
    public boolean createPermission(Permission permission) {
        if (permission.getStatus() == null || permission.getStatus().isEmpty()) {
            permission.setStatus("启用");
        }
        return userDao.insertPermission(permission) > 0;
    }

    @Override
    public boolean updatePermission(Permission permission) {
        return userDao.updatePermission(permission) > 0;
    }

    @Override
    public boolean deletePermission(Integer id) {
        // 删除角色权限关联
        userDao.deleteRolePermissionsByPermission(id);
        return userDao.deletePermission(id) > 0;
    }

    @Override
    public boolean updateUserRoles(Integer userId, List<Integer> roleIds) {
        userDao.deleteUserRoles(userId);
        if (roleIds != null) {
            for (Integer rid : roleIds) {
                userDao.insertUserRole(userId, rid);
            }
        }
        return true;
    }

    @Override
    public boolean updateRolePermissions(Integer roleId, List<Integer> permissionIds) {
        userDao.deleteRolePermissions(roleId);
        if (permissionIds != null) {
            for (Integer pid : permissionIds) {
                userDao.insertRolePermission(roleId, pid);
            }
        }
        return true;
    }
}

