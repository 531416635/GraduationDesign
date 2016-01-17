package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.RolesDao;
import com.wit.model.Page;
import com.wit.model.Roles;
import com.wit.service.RolesService;

@Service("RolesService")
public class RolesServiceImpl implements RolesService{
	@Resource
	private RolesDao Roles;
	
	    @Override
		public List<Roles> findAll(Page page) {
			return Roles.findAll(page);
		}
		
	    @Override
		public void deleteRole(Integer id) {
	    	Roles.deleteRole(id);
		}
	    
	    @Override
	   	public void addRole(Roles db) {
	       	Roles.addRole(db);
	   	}
	    
	    @Override
	   	public void updateRole(Roles db){
	       	Roles.updateRole(db);
	   	}
	    @Override
	    public int updateRoleStatus(Roles role)
	    {
	    	return Roles.updateRoleStatus(role);	    	
	    }
	    
	    @Override
	   	public Roles findById(Integer id) {
	   		return Roles.findById(id);
	   	}
	    
	    @Override
	   	public List<Roles> findByCompanyId(Integer companyId)
	   	{
	    	return Roles.findByCompanyId( companyId);
	   	}
	    
	    @Override
	   	public int findRows() {
	   		return Roles.findRows();
	   	}
	    
		@Override
		public void updateRoleMenuRights(String roleID, String menuIDs) {
			Roles.updateRoleMenuRights(roleID, menuIDs);
		}

		@Override
		public List<com.wit.model.Roles> findRoleUsed() {
			return Roles.findRoleUsed();
		}


}
