package com.lz08.hrsys_ssm2.service.impl;

import com.lz08.hrsys_ssm2.dao.EmployeeDao;
import com.lz08.hrsys_ssm2.entity.Employee;
import com.lz08.hrsys_ssm2.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    EmployeeDao empDao;


    public List<Employee> search(Employee condition) {
        List<Employee> list = empDao.search(condition);
        return list;
    }

    @Override
    public Employee searchById(int id) {
        Employee emp = empDao.searchById(id);
        return emp;

    }

    @Override
    public boolean add(Employee emp) {
        int rs = empDao.add(emp);
        return rs > 0;

    }

    @Override
    public boolean update(Employee emp) {
        int rs = empDao.update(emp);
        return rs > 0;

    }

    @Override
    public boolean delete(Integer id) {
        int rs = empDao.delete(id);
        return rs > 0;
    }

}
