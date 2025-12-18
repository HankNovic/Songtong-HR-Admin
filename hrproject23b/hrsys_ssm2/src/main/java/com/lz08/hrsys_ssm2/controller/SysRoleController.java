package com.lz08.hrsys_ssm2.controller;

import com.lz08.hrsys_ssm2.common.Result;
import com.lz08.hrsys_ssm2.entity.Role;
import com.lz08.hrsys_ssm2.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("sysRole")
@Tag(name = "SysRole Controller", description = "角色管理模块接口")
public class SysRoleController {

    @Autowired
    private UserService userService;

    @Operation(summary = "查询所有角色", description = "获取系统所有角色列表")
    @GetMapping
    public Result<List<Role>> findAllRoles() {
        List<Role> roles = userService.findAllRoles();
        return Result.success(roles);
    }

    @Operation(summary = "新增角色", description = "创建新角色")
    @PostMapping
    public Result<Boolean> createRole(@RequestBody Role role) {
        boolean ok = userService.createRole(role);
        return ok ? Result.success(true) : Result.error("新增角色失败");
    }

    @Operation(summary = "修改角色", description = "更新角色信息")
    @PutMapping
    public Result<Boolean> updateRole(@RequestBody Role role) {
        boolean ok = userService.updateRole(role);
        return ok ? Result.success(true) : Result.error("修改角色失败");
    }

    @Operation(summary = "删除角色", description = "根据ID删除角色")
    @DeleteMapping("{id}")
    public Result<Boolean> deleteRole(@PathVariable Integer id) {
        boolean ok = userService.deleteRole(id);
        return ok ? Result.success(true) : Result.error("删除角色失败");
    }

    @Operation(summary = "获取角色权限ID列表", description = "查询指定角色的权限ID列表")
    @GetMapping("{id}/permissions")
    public Result<List<Integer>> getRolePermissions(@PathVariable Integer id) {
        List<Integer> ids = userService.findPermissionIdsByRoleId(id);
        return Result.success(ids);
    }

    @Operation(summary = "更新角色权限", description = "覆盖式更新角色的权限列表")
    @PutMapping("{id}/permissions")
    public Result<Boolean> updateRolePermissions(@PathVariable Integer id, @RequestBody List<Integer> permissionIds) {
        boolean ok = userService.updateRolePermissions(id, permissionIds);
        return ok ? Result.success(true) : Result.error("更新角色权限失败");
    }
}

