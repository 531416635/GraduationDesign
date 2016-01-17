package com.wit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyBankAccountDao;
import com.wit.model.CompanyBankAccount;
import com.wit.model.Page;
import com.wit.service.CompanyBankAccountService;

@Service
public class CompanyBankAccountServiceImpl implements CompanyBankAccountService{

	@Autowired
	private CompanyBankAccountDao dao;
	public CompanyBankAccountDao getDao() {
		return dao;
	}
	public void setDao(CompanyBankAccountDao dao) {
		this.dao = dao;
	}
	@Override
	public List<CompanyBankAccount> findSupplierBankAccount(Page page) {
		return dao.findSupplierBankAccount(page);
	}
	@Override
	public CompanyBankAccount findById(Integer id) {
		return dao.findById(id);
	}
	@Override
	public void deleteCompanyBankAccount(Integer companyId) {
		dao.deleteCompanyBankAccount(companyId);
		
	}
	@Override
	public void addBankAccount(CompanyBankAccount companyBankAccount) {
		dao.addBankAccount(companyBankAccount);
		
	}
	@Override
	public void updateCompanyBankAccount(CompanyBankAccount companyBankAccount) {
		dao.updateCompanyBankAccount(companyBankAccount);
		
	}
	@Override
	public List<CompanyBankAccount> findBuyerBankAccount(Page page) {
		return dao.findBuyerBankAccount(page);
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
	public List<CompanyBankAccount> findByCompanyId(Integer companyId) {
		return dao.findByCompanyId(companyId);
	}
	
}
