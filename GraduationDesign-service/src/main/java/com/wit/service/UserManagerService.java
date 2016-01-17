package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Page;
import com.wit.model.Users;

public interface UserManagerService {
	//查看所有用户信息
	List<Map<String,Object>> findAll(Page page);
		
		//根据ID查找
		Users findById(Integer id); 
		
		//更新
		void updateUsers(Users users);
		//批量逻辑删除
		void deleteCompanyUsers(String ids);
		
		//增加
		void insertUsers(Users users);
		
		
		
		int findRows();
		
		//检查登陆
        boolean checkLogin(String userName,String userPsw);
        //根据用户名返回用户信息
		Users findByName(String userName);
		// 修改状态
		void updateStatus(Map<String,Integer> maps);
		//查看所有用户信息
		List<Users> findAllByCompanyId(Map<String,Object> maps);
		//前台公司Id查看所有用户信息
		List<Users> webfindAllByCompanyId(Integer companyId);
		//根据公司Id
		int findRowsByCompanyId(Integer companyId);
		
		int findRowsByCompanyIds(Map<String,Object> maps);

		//完善门户用户信息
		void completeUserInfo(Users users);
		
		List<Map<String,Object>> findSonAccountByCompanyId(Integer companyId,Page page);

		List<Users> webfindAllByDepartID(Map<String, Object> parm);
		
}
