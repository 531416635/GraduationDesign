package com.wit.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyBalanceDao;
import com.wit.model.CompanyBalance;
import com.wit.model.Page;
import com.wit.service.CompanyBalanceService;


@Service("CompanyBalanceService")
public class CompanyBalanceServiceImpl implements CompanyBalanceService{

	@Autowired
	private CompanyBalanceDao dao;
	
	public CompanyBalanceDao getDao() {
		return dao;
	}
	public void setDao(CompanyBalanceDao dao) {
		this.dao = dao;
	}
	@Override
	public void deleteCompanyBalance(Integer id) {
		dao.deleteCompanyBalance(id);
		
	}
	@Override
	public List<CompanyBalance> findSupplier(Page page) {
		return dao.findSupplier(page);
	}
	@Override
	public CompanyBalance findById(Integer Id) {
		return dao.findById(Id);
	}
	@Override
	public List<CompanyBalance> findByCompanyId(Integer companyId) {
		return dao.findByCompanyId(companyId);
	}
	@Override
	public void update(CompanyBalance companyBalance) {
		dao.update(companyBalance);
	}
	@Override
	public void insert(CompanyBalance companyBalance) {
		dao.insert(companyBalance);
	}
	@Override
	public List<CompanyBalance> findBuyer(Page page) {
		return dao.findBuyer(page);
	}
	@Override
	public int findSupplierRows() {
		return dao.findSupplierRows();
	}
	@Override
	public int findBuyerRows() {
		return dao.findBuyerRows();
	}
	@Override
	public void updateBalance(Integer id) {
		dao.updateBalance(id);
	}
	@Override
	public void deleteByIds(String ids) {
		dao.deleteByIds(ids);
		
	}
	@Override
	public void renewalBalance(String ids) {
		dao.renewalBalance(ids);
		
	}
	@Override
	public void editCompanyBalance(Map<String,Object> parm) {
		dao.editCompanyBalance(parm);
	}
	@Override
	public BigDecimal findBalanceByCompanyId(Map<String, Object> parm) {
		return dao.findBalanceByCompanyId(parm);
	}

	
	
}
