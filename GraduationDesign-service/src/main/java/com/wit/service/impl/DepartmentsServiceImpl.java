package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.DepartmentsDao;
import com.wit.model.Departments;
import com.wit.model.Page;
import com.wit.service.DepartmentsService;

@Service("DepartmentsService")
public class DepartmentsServiceImpl implements DepartmentsService{
	@Resource
	private DepartmentsDao departments;
	
	    @Override
		public List<Map<String, Object>> findAll(Page page) {
			return departments.findAll(page);
		}
		
	    @Override
		public void deleteDepartment(Integer id) {
	    	departments.deleteDepartment(id);
		}
	    
	    @Override
	   	public void addDepartment(Departments db) {
	       	departments.addDepartment(db);
	   	}
	    
	    @Override
	   	public void updateDepartment(Departments db){
	       	departments.updateDepartment(db);
	   	}
	    
	    @Override
	   	public void updateDepartmentName(Departments db){
	       	departments.updateDepartmentName(db);
	   	}
	    
	    @Override
	   	public Map<String, Object> findByIds(Integer id) {
	   		return departments.findByIds(id);
	   	}
	    
	    @Override
	   	public int findRows() {
	   		return departments.findRows();
	   	}
	    
	    @Override
		public List<Departments> findById(Integer id) {
			return departments.findById(id);
		}
	    
	    @Override
		public List<Map<String, Object>> findCompanysId() {
			return departments.findCompanysId();
		}

		@Override
		public List<Departments> findDepartmentByCompanyId(Integer companyId) {
			return departments.findDepartmentByCompanyId(companyId);
		}

}
