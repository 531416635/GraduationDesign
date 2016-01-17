package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Page;
import com.wit.model.Users;

public interface UserService {

	//查询所有用户信息
	List<Users>  findAllUsers();
	//删除用户信息
	void deleteUser(Integer id);
	//增加用户信息
	void addUser(Users users);
	//根据用户Id查询用户信息
	Users findbyId(Integer userId);
	//更新用户信息
	void updateUser(Users users);
	
	//修改密码
	void updatePwd(Map<String,Object> parm);
	
	//修改门户用户密码
	void updateUserPwd(Map<String,Object> parm);
	
	//门户商户注册
	void savePurchaser(Map<String,Object> parm);
	
	//查询门户用户
	Users findUsers(String userCode);
	
	int AddMerchantUser(Users merchantUser);
	
	List<Users> findSumByCompanyId(Integer companyId);
	
	void uploadAvatar(Integer userId,String userPhoto);
	
	//查询子账户信息
	List<Users> findByCompanyId(Integer companyId);
	
	//查询子账户条数状态为0
	int findSonAccount0(Integer companyId);
	
	//查询子账户条数状态为1
	int findSonAccount1(Integer companyId);
			
	//查询子账户条数状态为2
	int findSonAccount2(Integer companyId);
			
	//查询子账户条数状态为3
	int findSonAccount3(Integer companyId);
	
	//查询管理账户信息
	Users findManagerAccountInfo(Integer companyId);
	
	//初始化子账户密码
	void initSonAccount(String userPsw,Integer id);
	//查询子账户数量
	int findSonAccountRowsById(Integer Id);
	
	//userCode校验用户的唯一性
	Users checkUser(String userCode);
	
	//根据公司类型修改用户角色
	void updateUserRole(Integer tmpCompanyId);
}
