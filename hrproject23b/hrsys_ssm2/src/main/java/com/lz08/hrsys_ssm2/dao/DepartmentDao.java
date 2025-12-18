package com.lz08.hrsys_ssm2.dao;

import com.lz08.hrsys_ssm2.entity.Department;

import java.util.List;

public interface DepartmentDao {
    //    查询所有部门
    public List<Department> search();
    //    根据ID查询哪个部门
    public  Department searchById(int id);
    //    新增部门
    public int add(Department dep);
    //    更新部门
    public int update(Department dep);
    //    删除部门
    public int delete(int id);


}
