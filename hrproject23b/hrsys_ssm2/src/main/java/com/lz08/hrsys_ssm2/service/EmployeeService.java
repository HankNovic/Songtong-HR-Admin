package com.lz08.hrsys_ssm2.service;


import com.lz08.hrsys_ssm2.entity.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> search(Employee condition);
    Employee searchById(int id);
    boolean add(Employee emp);
    boolean update(Employee emp);
    boolean delete(Integer id);

}
