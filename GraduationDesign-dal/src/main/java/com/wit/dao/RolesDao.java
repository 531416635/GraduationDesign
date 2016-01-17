package com.wit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.Roles;

public interface RolesDao {
	    //查询所有角色信息
		List<Roles>  findAll(Page page);
		//删除角色信息
		void deleteRole(Integer id);
		//增加角色
		void addRole(Roles roles);
		//根据Id查询角色信息
		Roles findById(Integer id);
		//根据公司Id获取角色
		List<com.wit.model.Roles> findByCompanyId(Integer companyId);
		//更新角色
		void updateRole(Roles roles);
		
		//
		void updateRoleMenuRights(@Param(value = "roleID") String roleID,
				@Param(value = "menuIDs") String menuIDs);
		
		int findRows();
		//
		int updateRoleStatus(Roles role);
		
		//查询所有状态为可用的用户角色
		List<Roles> findRoleUsed();
		
}
