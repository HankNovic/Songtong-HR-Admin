package com.lz08.hrsys_ssm.dao;

import com.lz08.hrsys_ssm.entity.Employee;

import java.util.List;

public interface EmployeeDao {
    List<Employee> search();
//    根据ID查询员工
    Employee searchById(int id);
}
