package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.Users;

public interface UsersDao {
		//查询所有新闻信息
		List<Users>  findAllUsers();
		//删除新闻信息
		void deleteUser(Integer id);
		//增加新闻公告
		void addUser(Users users);
		//根据Id查询新闻公告信息
		Users findbyId(Integer userId);
		//修改用户信息
		void updateUser(Users users);
		
		//修改密码
		void updatePwd(Map<String,Object> parm);
		
		//修改门户用户密码
		void updateUserPwd(Map<String,Object> parm);
		
		//门户商户注册
		void savePurchaser(Map<String,Object> parm);
		
		//查询门户用户
		Users findUsers(String userCode);
		//建立商户用户
		int AddMerchantUser(Users users);
		//获取该商户所以得用户数
		List<Users> findSumByCompanyId(Integer companyId);
		
		//上传用户头像
		void uploadAvatar(@Param(value="userId") Integer userId,@Param(value="userPhoto") String userPhoto);
		
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
		void initSonAccount(@Param(value="userPsw") String userPsw,@Param(value="id") Integer id);
		//查询子账户数量
		int findSonAccountRowsById(Integer Id);
		
		//userCode校验用户的唯一性
		Users checkUser(String userCode);
		
		//根据公司类型修改用户角色
		void updateUserRole(Integer tmpCompanyId);
}
