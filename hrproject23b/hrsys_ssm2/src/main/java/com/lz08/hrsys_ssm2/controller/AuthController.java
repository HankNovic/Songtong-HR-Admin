package com.lz08.hrsys_ssm2.controller;

import com.lz08.hrsys_ssm2.common.Result;
import com.lz08.hrsys_ssm2.controller.dto.LoginRequest;
import com.lz08.hrsys_ssm2.entity.Permission;
import com.lz08.hrsys_ssm2.entity.User;
import com.lz08.hrsys_ssm2.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin
@RestController
@RequestMapping("auth")
@Tag(name = "Auth Controller", description = "认证和权限模块接口")
public class AuthController {

    @Autowired
    private UserService userService;

    @Operation(summary = "用户登录", description = "验证用户名和密码，返回用户信息和权限列表")
    @PostMapping("/login")
    public Result<Map<String, Object>> login(
            @Parameter(description = "登录请求") @RequestBody LoginRequest request) {
        
        User user = userService.login(request.getUsername(), request.getPassword());
        if (user == null) {
            return Result.error(401, "用户名或密码错误");
        }

        // 获取用户的所有权限（去重）
        List<Permission> permissions = userService.findPermissionsByUserId(user.getId());
        
        // 构建返回数据
        Map<String, Object> data = new HashMap<>();
        data.put("user", user);
        
        // 权限列表（只返回权限代码，前端根据代码控制菜单显示）
        List<String> permissionCodes = permissions.stream()
                .map(Permission::getCode)
                .collect(Collectors.toList());
        data.put("permissions", permissionCodes);
        
        // 角色列表
        if (user.getRoles() != null) {
            List<String> roleCodes = user.getRoles().stream()
                    .map(role -> role.getCode())
                    .collect(Collectors.toList());
            data.put("roles", roleCodes);
        } else {
            data.put("roles", new java.util.ArrayList<>());
        }

        return Result.success("登录成功", data);
    }

    @Operation(summary = "获取当前用户权限列表", description = "根据用户ID查询权限列表")
    @GetMapping("/permissions")
    public Result<List<String>> getPermissions(
            @Parameter(description = "用户ID") @RequestParam Integer userId) {
        
        List<Permission> permissions = userService.findPermissionsByUserId(userId);
        List<String> permissionCodes = permissions.stream()
                .map(Permission::getCode)
                .collect(Collectors.toList());
        
        return Result.success(permissionCodes);
    }

    @Operation(summary = "生成BCrypt密码（测试用）", description = "生成指定密码的BCrypt哈希值，用于数据库插入")
    @GetMapping("/generate-password")
    public Result<Map<String, String>> generatePassword(
            @Parameter(description = "明文密码") @RequestParam(defaultValue = "123456") String password) {
        
        org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder encoder = 
            new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder();
        
        String encodedPassword = encoder.encode(password);
        
        Map<String, String> result = new HashMap<>();
        result.put("rawPassword", password);
        result.put("encodedPassword", encodedPassword);
        result.put("sql", String.format("UPDATE `user` SET `password` = '%s' WHERE `username` = 'your_username';", encodedPassword));
        
        return Result.success("密码生成成功", result);
    }
}

