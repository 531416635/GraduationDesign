package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.UserManagerDao;
import com.wit.model.Users;
import com.wit.model.Page;
import com.wit.service.UserManagerService;
@Service("userManagerService")
public class UserManagerServiceImpl implements UserManagerService{
	@Resource
	private UserManagerDao userManager;

  
    @Override
   	public void insertUsers(Users db) {
    	userManager.insertUsers(db);
   	}
    
    @Override
   	public void updateUsers(Users db){
    	userManager.updateUsers(db);
   	}
    
    @Override
   	public Users findById(Integer id) {
   		return userManager.findById(id);
   	}
    
    @Override
   	public int findRows() {
   		return userManager.findRows();
   	}
    
    
    @Override
    public Users findByName(String userName){
    	return userManager.findByName(userName);
    }
    
    
    @Override
    public boolean checkLogin(
		String userName, String userPsw) {
		Users users = userManager.findByName(userName);
		if(users != null){
			if(users.getUserPsw().equals(userPsw)){
				return true;//正确
			}
		}
		return false;//错误
		}

	@Override
	public List<Users> findAllByCompanyId(Map<String, Object> maps) {
		
		return userManager.findAllByCompanyId(maps);
	}

	@Override
	public int findRowsByCompanyId(Integer companyId) {
		
		return userManager.findRowsByCompanyId(companyId);
	}

	@Override
	public void deleteCompanyUsers(String ids) {
		userManager.deleteCompanyUsers(ids);
		
	}

	@Override
	public int findRowsByCompanyIds(Map<String, Object> maps) {
		
		return userManager.findRowsByCompanyIds(maps);
	}



	@Override
	public void updateStatus(Map<String, Integer> maps) {
		userManager.updateStatus(maps);
		
	}



	@Override
	public void completeUserInfo(Users users) {
		userManager.completeUserInfo(users);
	}



	@Override
	public List<Users> webfindAllByCompanyId(Integer companyId) {
		
		return userManager.webfindAllByCompanyId(companyId);
	}



	@Override
	public List<Map<String, Object>> findSonAccountByCompanyId(
			Integer companyId, Page page) {
		return userManager.findSonAccountByCompanyId(companyId, page);
	}

	@Override
	public List<Users> webfindAllByDepartID(Map<String, Object> parm){
		return userManager.webfindAllByDepartID(parm);
	}

	@Override
	public List<Map<String, Object>> findAll(Page page) {
		return userManager.findAll(page);
	}

}
