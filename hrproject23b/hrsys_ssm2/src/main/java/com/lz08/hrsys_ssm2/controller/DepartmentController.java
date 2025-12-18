package com.lz08.hrsys_ssm2.controller;

import com.lz08.hrsys_ssm2.entity.Department;
import com.lz08.hrsys_ssm2.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("dep23B")
public class DepartmentController {
    @Autowired
    DepartmentService depService;

    @GetMapping
    public List<Department> search() {
        List<Department> list = depService.search();
        return list;
    }

    @GetMapping("{id}")
    public Department search(@PathVariable Integer id) {
        Department  dep = depService.searchById(id);
        return dep;
    }

    @PostMapping
    public boolean add(@RequestBody Department dep) {
        boolean flag = depService.add(dep);
        return flag;

    }

    @PutMapping
    public boolean update(@RequestBody Department dep) {
        boolean flag = depService.update(dep);
        return flag;
    }

    @DeleteMapping("{id}")
    public boolean delete(@PathVariable Integer id) {
        boolean flag = depService.delete(id);
        return flag;
    }



}
