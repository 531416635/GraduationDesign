package com.wit.dao;

import java.util.List;

import com.wit.model.News;
import com.wit.model.RoleRights;

public interface RoleRightsDao {
	    //查询角色权限信息
		List<RoleRights>  findRoleRights();
		//删除角色权限信息
		void deleteRoleRight(Integer id);
		//增加角色权限公告
		void addRoleRight(RoleRights roleRight);
		//根据Id查询角色权限信息
		News findbyId(Integer id);
		//更新角色权限
		void updateRoleRight(RoleRights roleRight);
}
