package com.lz08.hrsys_ssm2.controller;

import com.lz08.hrsys_ssm2.common.Result;
import com.lz08.hrsys_ssm2.entity.Permission;
import com.lz08.hrsys_ssm2.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("sysPermission")
@Tag(name = "SysPermission Controller", description = "权限管理模块接口")
public class SysPermissionController {

    @Autowired
    private UserService userService;

    @Operation(summary = "查询所有权限", description = "获取系统所有权限列表")
    @GetMapping
    public Result<List<Permission>> findAllPermissions() {
        List<Permission> permissions = userService.findAllPermissions();
        return Result.success(permissions);
    }

    @Operation(summary = "新增权限", description = "创建新权限")
    @PostMapping
    public Result<Boolean> createPermission(@RequestBody Permission permission) {
        boolean ok = userService.createPermission(permission);
        return ok ? Result.success(true) : Result.error("新增权限失败");
    }

    @Operation(summary = "修改权限", description = "更新权限信息")
    @PutMapping
    public Result<Boolean> updatePermission(@RequestBody Permission permission) {
        boolean ok = userService.updatePermission(permission);
        return ok ? Result.success(true) : Result.error("修改权限失败");
    }

    @Operation(summary = "删除权限", description = "根据ID删除权限")
    @DeleteMapping("{id}")
    public Result<Boolean> deletePermission(@PathVariable Integer id) {
        boolean ok = userService.deletePermission(id);
        return ok ? Result.success(true) : Result.error("删除权限失败");
    }
}

