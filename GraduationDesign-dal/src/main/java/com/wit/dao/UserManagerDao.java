package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.Users;

/**
 * 
 * @author ljj
 *
 */
public interface UserManagerDao {
	//查看所有用户信息
	List<Map<String,Object>> findAll(Page page);
	
	
	//根据ID查找
	Users findById(Integer id); 
	
	
	//更新
	void updateUsers(Users users);
	
	
	//删除
	void deleteCompanyUsers(String ids);
	
	//增加
	void insertUsers(Users users);
	
	
	int findRows();
	
	//根据公司Id查看所有用户信息
	List<Users> findAllByCompanyId(Map<String,Object> maps);
	//前台公司Id查看所有用户信息
	List<Users> webfindAllByCompanyId(Integer companyId);
	//根据公司Id
	int findRowsByCompanyId(Integer companyId);
	
	int findRowsByCompanyIds(Map<String,Object> maps);
	
	//根据用户名返回用户信息
	Users findByName(String userName);
	// 修改状态
	void updateStatus(Map<String,Integer> maps);
	
	//完善门户用户信息
	void completeUserInfo(Users users);
	
	//子账户列表
	List<Map<String,Object>> findSonAccountByCompanyId(@Param(value="companyId") Integer companyId,@Param(value="page") Page page);

	List<Users> webfindAllByDepartID(Map<String, Object> parm);

}
