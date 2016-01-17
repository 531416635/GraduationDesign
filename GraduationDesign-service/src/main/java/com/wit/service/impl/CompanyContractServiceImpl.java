package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyContractsDao;
import com.wit.model.CompanyContracts;
import com.wit.service.CompanyContractService;

@Service("CompanyContractService")
public class CompanyContractServiceImpl implements CompanyContractService{

	@Autowired
	private CompanyContractsDao dao;
	public CompanyContractsDao getDao() {
		return dao;
	}
	public void setDao(CompanyContractsDao dao) {
		this.dao = dao;
	}
	@Override
	public List<CompanyContracts> findCompanyContracts() {
		return dao.findCompanyContracts();
	}

	@Override
	public void deleteCompanyContracts(Integer companyId) {
		dao.deleteCompanyContracts(companyId);
		
	}
	@Override
	public void updateCompanyContracts(CompanyContracts companyContracts) {
		dao.updateCompanyContracts(companyContracts);
		
	}
	@Override
	public void insert(CompanyContracts companyContracts) {
		dao.insert(companyContracts);
		
	}
	@Override
	public List<CompanyContracts> findByCompanyId(Integer companyId) {
		return dao.findByCompanyId(companyId);
	}
	@Override
	public CompanyContracts findById(Integer id) {
		return dao.findById(id);
	}
	@Override
	public List<CompanyContracts> findByCompanyIds(Map<String, Object> parm) {
		
		return dao.findByCompanyIds(parm);
	}
	@Override
	public int findRows(Integer companyId) {
	
		return dao.findRows(companyId);
	}
	@Override
	public void deleteByIds(String ids) {
		dao.deleteByIds(ids);
	}
	@Override
	public void updateContractStatus(Integer id) {
		dao.updateContractStatus(id);
	}
	@Override
	public List<CompanyContracts> checkCompanyContractsByCompanyId(
			Integer companyId) {	
		return dao.checkCompanyContractsByCompanyId(companyId);
	}
	
}
