package com.lz08.hrsys_ssm2.controller;

import com.lz08.hrsys_ssm2.common.Result;
import com.lz08.hrsys_ssm2.entity.User;
import com.lz08.hrsys_ssm2.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("sysUser")
@Tag(name = "SysUser Controller", description = "用户管理模块接口")
public class SysUserController {

    @Autowired
    private UserService userService;

    @Operation(summary = "查询所有用户", description = "获取系统所有用户列表")
    @GetMapping
    public Result<List<User>> findAllUsers() {
        List<User> users = userService.findAllUsers();
        // 清除密码字段
        users.forEach(user -> user.setPassword(null));
        return Result.success(users);
    }

    @Operation(summary = "新增用户", description = "创建新用户（密码将自动加密）")
    @PostMapping
    public Result<Boolean> createUser(@RequestBody User user) {
        boolean ok = userService.createUser(user);
        return ok ? Result.success(true) : Result.error("新增用户失败");
    }

    @Operation(summary = "修改用户", description = "更新用户信息（如需修改密码请传入密码字段）")
    @PutMapping
    public Result<Boolean> updateUser(@RequestBody User user) {
        try {
            if (user.getId() == null) {
                return Result.error("用户ID不能为空");
            }
            boolean ok = userService.updateUser(user);
            return ok ? Result.success(true) : Result.error("修改用户失败");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改用户失败：" + e.getMessage());
        }
    }

    @Operation(summary = "批量修改用户", description = "批量更新用户姓名、邮箱和状态")
    @PutMapping("/batch")
    public Result<Boolean> batchUpdateUsers(@RequestBody List<User> users) {
        boolean ok = userService.batchUpdateUsers(users);
        return ok ? Result.success(true) : Result.error("批量修改用户失败");
    }

    @Operation(summary = "删除用户", description = "根据ID删除用户")
    @DeleteMapping("{id}")
    public Result<Boolean> deleteUser(@PathVariable Integer id) {
        boolean ok = userService.deleteUser(id);
        return ok ? Result.success(true) : Result.error("删除用户失败");
    }

    @Operation(summary = "获取用户角色ID列表", description = "查询指定用户的角色ID列表")
    @GetMapping("{id}/roles")
    public Result<List<Integer>> getUserRoles(@PathVariable Integer id) {
        List<Integer> ids = userService.findRoleIdsByUserId(id);
        return Result.success(ids);
    }

    @Operation(summary = "更新用户角色", description = "覆盖式更新用户的角色列表")
    @PutMapping("{id}/roles")
    public Result<Boolean> updateUserRoles(@PathVariable Integer id, @RequestBody List<Integer> roleIds) {
        boolean ok = userService.updateUserRoles(id, roleIds);
        return ok ? Result.success(true) : Result.error("更新用户角色失败");
    }
}

