package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanysDao;
import com.wit.model.Companys;
import com.wit.model.Page;
import com.wit.service.CompanysService;

@Service("CompanysService")
public class CompanysServiceImpl implements CompanysService{
	@Autowired
	private CompanysDao companysDao;
	
	public CompanysDao getCompanysDao() {
		return companysDao;
	}
	
	public void setCompanysDao(CompanysDao companysDao) {
		this.companysDao = companysDao;
	}
	

	@Override
	public List<Companys> findSupplier(Page page) {
		return companysDao.findSupplier(page);
	}

	@Override
	public Companys findById(Integer companyId) {
		return companysDao.findById(companyId);
	}

	@Override
	public void add(Companys companys) {
		companysDao.add(companys);
	}

	@Override
	public void delete(Integer id) {
		companysDao.delete(id);
	}

	@Override
	public void updateCompany(Companys companys) {
		companysDao.updateCompany(companys);
	}

	@Override
	public List<Companys> findBuyer(Page page) {
		return companysDao.findBuyer(page);
	}

	@Override
	public int findBuyerRows() {
		return companysDao.findBuyerRows();
	}

	@Override
	public int findSupplierRows() {
		return companysDao.findSupplierRows();
	}

	@Override
	public List<Map<String, Object>> findByIds(Integer id) {
		return companysDao.findByIds(id);
	}

	@Override
	public List<Companys> findSupplierInfo(Map<String, Object> parm) {
		return companysDao.findSupplierInfo(parm);
	}

	@Override
	public List<Companys> findBuyerInfo(Map<String, Object> parm) {
		return companysDao.findBuyerInfo(parm);
	}

	@Override
	public int supplierRows(String companyName) {
		return companysDao.supplierRows(companyName);
	}

	@Override
	public int buyerRows(String companyName) {
		return companysDao.buyerRows(companyName);
	}

	@Override
	public void deleteByIds(String ids) {
		companysDao.deleteByIds(ids);
	}

	@Override
	public void completeCompanyInfo(Companys companys) {
		companysDao.completeCompanyInfo(companys);
	}

	@Override
	public Companys webfindById(Integer companyId) {
		
		return companysDao.webfindById(companyId);
	}

	@Override
	public Companys findLoginStatus(Integer companyId) {
		return companysDao.findLoginStatus(companyId);
	}

	@Override
	public List<Companys> findAllCompanys() {
		// TODO Auto-generated method stub
		return companysDao.findAllCompanys();
	}

	

}
