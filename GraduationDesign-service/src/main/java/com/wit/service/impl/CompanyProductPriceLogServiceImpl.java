package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyProductPriceLogDao;
import com.wit.model.CompanyProductPriceLog;
import com.wit.service.CompanyProductPriceLogService;
@Service
public class CompanyProductPriceLogServiceImpl implements CompanyProductPriceLogService{
	@Autowired
	private CompanyProductPriceLogDao dao;
	

	@Override
	public CompanyProductPriceLog findById(int id) {
		
		return dao.findById(id);
	}

	@Override
	public void update(CompanyProductPriceLog companyProductPriceLog) {
		dao.update(companyProductPriceLog);
	}

	@Override
	public void delete(Integer id) {
		dao.delete(id);
		
	}

	@Override
	public void insert(CompanyProductPriceLog companyProductPriceLog) {
		dao.insert(companyProductPriceLog);
		
	}

	@Override
	public List<CompanyProductPriceLog> findAllByCompanyProductId(Integer id) {
		
		return dao.findAllByCompanyProductId(id);
	}

	@Override
	public List<CompanyProductPriceLog> findAllByCompanyId(
			Map<String, Object> maps) {
		
		return dao.findAllByCompanyId(maps);
	}

	@Override
	public int findRows(Integer productId) {

		return dao.findRows(productId);
	}


}
