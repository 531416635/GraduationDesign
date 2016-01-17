package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyBalanceLogDao;
import com.wit.model.CompanyBalanceLog;

import com.wit.service.CompanyBalanceLogService;

@Service("CompanyBalanceLogService")
public class CompanyBalanceLogServiceImpl implements CompanyBalanceLogService{

	@Autowired
	private CompanyBalanceLogDao dao;
	public CompanyBalanceLogDao getDao() {
		return dao;
	}
	public void setDao(CompanyBalanceLogDao dao) {
		this.dao = dao;
	}

	@Override
	public void update(CompanyBalanceLog companyBalanceLog) {
		dao.update(companyBalanceLog);
		
	}
	@Override
	public void delete(Integer id) {
		dao.delete(id);
		
	}
	@Override
	public void insert(CompanyBalanceLog companyBalanceLog) {
		dao.insert(companyBalanceLog);
		
	}

	@Override
	public List<CompanyBalanceLog> findAll() {
		return dao.findAll();
	}
	@Override
	public int rows(Integer id) {
		return dao.rows(id);
	}
	@Override
	public List<CompanyBalanceLog> findById(Map<String, Object> parm) {
		return dao.findById(parm);
	}




	
}
