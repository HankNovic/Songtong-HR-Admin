package com.lz08.hrsys_ssm2.dao;



import com.lz08.hrsys_ssm2.entity.Employee;

import java.util.List;

public interface EmployeeDao {
//    List<Employee> search();
////    根据ID查询员工
//    Employee searchById(int id);
////    根据条件查询
//    List<Employee> searchByCondition(String gender,int age);
//
////    动态语句
//    List<Employee> search1(Employee employee);
//
//    int add(Employee employee);

    //  多条件查询
    List<Employee> search(Employee condition);
    //根据ID查询
    Employee searchById(int id);
    //    新增员工
    int add(Employee emp);
    //  删除员工
    int delete(int id);
    //    更新员工
    int update(Employee emp);
    //    更新部门
    int updateByDep(int depId);

}
