package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.UsersDao;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.UserService;

@Service("UserService")
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UsersDao dao;
	public UsersDao getDao() {
		return dao;
	}
	public void setDao(UsersDao dao) {
		this.dao = dao;
	}
	@Override
	public List<Users> findAllUsers() {
		return dao.findAllUsers();
	}
	@Override
	public void deleteUser(Integer id) {
		dao.deleteUser(id);
	}
	@Override
	public void addUser(Users users) {
		dao.addUser(users);
	}
	@Override
	public int AddMerchantUser(Users users)
	{
		return dao.AddMerchantUser(users);
	}

	@Override
	public Users findbyId(Integer userId) {
		return dao.findbyId(userId);
	}
	@Override
	public void updateUser(Users users) {
		dao.updateUser(users);
	}
	@Override
	public void updatePwd(Map<String,Object> parm) {
		dao.updatePwd(parm);
	}
	@Override
	public void updateUserPwd(Map<String,Object> parm) {
		dao.updateUserPwd(parm);
		
	}
	@Override
	public Users findUsers(String userCode) {
		return dao.findUsers(userCode);
	}
	@Override
	public void savePurchaser(Map<String, Object> parm) {
		dao.savePurchaser(parm);
	}
	@Override
	public List<Users> findSumByCompanyId(Integer companyId)
	{
		return 	dao.findSumByCompanyId(companyId);
	}
	@Override
	public void uploadAvatar(Integer userId, String userPhoto) {
		dao.uploadAvatar(userId, userPhoto);
		
	}
	@Override
	public List<Users> findByCompanyId(Integer companyId) {
		return dao.findByCompanyId(companyId);
	}
	@Override
	public int findSonAccount0(Integer companyId) {
		return dao.findSonAccount0(companyId);
	}
	@Override
	public int findSonAccount1(Integer companyId) {
		return dao.findSonAccount1(companyId);
	}
	@Override
	public int findSonAccount2(Integer companyId) {
		return dao.findSonAccount2(companyId);
	}
	@Override
	public int findSonAccount3(Integer companyId) {
		return dao.findSonAccount3(companyId);
	}
	@Override
	public Users findManagerAccountInfo(Integer companyId) {
		return dao.findManagerAccountInfo(companyId);
	}
	@Override
	public void initSonAccount(String userPsw,Integer id) {
		dao.initSonAccount(userPsw,id);		
	}
	@Override
	public int findSonAccountRowsById(Integer Id){
		return dao.findSonAccountRowsById(Id);
	}
	//userCode校验用户的唯一性
	@Override
	public Users checkUser(String userCode) {
		return dao.checkUser(userCode);
	}
	@Override
	public void updateUserRole(Integer tmpCompanyId) {
		dao.updateUserRole(tmpCompanyId);
	}
}
