package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Departments;
import com.wit.model.Page;

public interface DepartmentsService {
	//查询部门信息
			List<Map<String, Object>>  findAll(Page page);
			//删除部门信息
			void deleteDepartment(Integer id);
			//增加部门公告
			void addDepartment(Departments departments);
			//部门ID关联查询部门  
			Map<String, Object> findByIds(Integer id);
			//通过ID查找部门信息
			List<Departments> findById(Integer id); 
			//更新部门公告
			void updateDepartment(Departments departments);
			//查找公司所有ID
			List<Map<String, Object>> findCompanysId();
			
			int findRows();
			//查询公司的所有部门
			List<Departments> findDepartmentByCompanyId(Integer companyId);

			void updateDepartmentName(Departments dbl);

}
