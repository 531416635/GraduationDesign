package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.AuthenticationManagerDao;
import com.wit.model.AuthenticationManager;
import com.wit.service.AuthenticationManagerService;
@Service("AuthenticationManagerService")
public class AuthenticationManagerServiceImpl implements AuthenticationManagerService{

	@Autowired
	AuthenticationManagerDao dao;
	public AuthenticationManagerDao getDao() {
		return dao;
	}
	public void setDao(AuthenticationManagerDao dao) {
		this.dao = dao;
	}
	
	@Override
	public List<AuthenticationManager> findAll() {
		return dao.findAll();
	}

	@Override
	public AuthenticationManager findById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public void update(AuthenticationManager authenticationManager) {
		dao.update(authenticationManager);
	}

	@Override
	public void delete(Integer id) {
		dao.delete(id);
	}

	@Override
	public void insert(AuthenticationManager authenticationManager) {
		dao.insert(authenticationManager);
	}
	@Override
	public List<AuthenticationManager> findByCompanyId(Map<String,Object> parm) {
		return dao.findByCompanyId(parm);
	}
	@Override
	public int rows(Integer companyId) {
		return dao.rows(companyId);
	}
	@Override
	public void deleteByIds(String ids) {
		dao.deleteByIds(ids);
	}
	@Override
	public void merchantAuthentication(Integer tmpCompanyId) {
		dao.merchantAuthentication(tmpCompanyId);
	}

}
