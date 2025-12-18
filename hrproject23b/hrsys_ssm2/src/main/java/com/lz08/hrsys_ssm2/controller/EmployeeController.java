package com.lz08.hrsys_ssm2.controller;

import com.lz08.hrsys_ssm2.entity.Employee;
import com.lz08.hrsys_ssm2.service.DepartmentService;
import com.lz08.hrsys_ssm2.service.EmployeeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Nullable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("emp")
@Tag(name="Employee Controller",description = "员工模块接口")
public class EmployeeController {

    @Autowired
    EmployeeService empService;
    @Autowired
    DepartmentService depService;

    Logger logger = LoggerFactory.getLogger(EmployeeController.class);



    @Operation(summary = "search all employee",description = "查询所有员工")
    @GetMapping
    public List<Employee> search(Employee condition) {
        List<Employee> list = empService.search(condition);
        logger.info("查询员工列表，条件: {}", condition);
        return list;
    }

    @Operation(summary="search employee by id",description = "根据id查询单个员工")
    @GetMapping("/{id}")
    public Employee search(@Parameter(description="员工id",name="id",required=true) @PathVariable Integer id) {
        Employee emp = empService.searchById(id);
        return emp;
    }

    @Operation(summary="add employee",description = "添加员工")
    @PostMapping
    public boolean add(@Parameter(description = "hrsys.entity.Employee")@RequestBody Employee emp) {
        boolean flag = empService.add(emp);
        return flag;
    }

    @Operation(summary="update employee",description = "修改员工")
    @PutMapping
    public boolean update(@Parameter(description="hrsys.entity.Employee") @RequestBody Employee emp) {
        boolean flag = empService.update(emp);
        return flag;
    }

    @Operation(summary="delete employee",description = "删除员工")
    @DeleteMapping("{id}")
    public boolean delete(@Parameter(description="员工id",name="id",required=true)@PathVariable Integer id) {
        boolean flag = empService.delete(id);
        return flag;
    }

}
