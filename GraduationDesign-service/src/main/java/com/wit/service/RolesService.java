package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.Roles;

public interface RolesService {
	 //查询角色信息
	List<Roles>  findAll(Page page);
	//删除角色
	void deleteRole(Integer id);
	//增加角色
	void addRole(Roles roles);
	//根据Id查询角色信息
	Roles findById(Integer id);
	//更新角色
	void updateRole(Roles roles);
	
	void updateRoleMenuRights(String roleID, String menuIDs);
	
	int findRows();
	
	List<Roles> findByCompanyId(Integer companyId);
	//
	int updateRoleStatus(Roles role);
	
	//查询所有状态为可用的用户角色
	List<Roles> findRoleUsed();

}
