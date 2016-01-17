package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.CompanyProductPriceDao;
import com.wit.model.CompanyProductPrice;
import com.wit.service.CompanyProductPriceService;
@Service
public class CompanyProductPriceServiceImpl implements CompanyProductPriceService{
	@Resource
	private CompanyProductPriceDao companyProuctPriceDao;
	@Override
	public List<CompanyProductPrice> findAll() {
		return companyProuctPriceDao.findAll();
	}


	@Override
	public CompanyProductPrice findById(Integer id) {
		return companyProuctPriceDao.findById(id);
	}

	@Override
	public void update(CompanyProductPrice companyProductPrice) {
		companyProuctPriceDao.update(companyProductPrice);
		
	}

	@Override
	public void delete(Integer id) {
		companyProuctPriceDao.delete(id);
		
	}

	@Override
	public void insert(CompanyProductPrice companyProductPrice) {
		companyProuctPriceDao.insert(companyProductPrice);	
	}

	@Override
	public CompanyProductPrice findByIds(Map<String, Integer> parm) {
		return companyProuctPriceDao.findByIds(parm);
	}

	@Override
	public List<CompanyProductPrice> findByCompanyProductId(Integer id) {
		return companyProuctPriceDao.findByCompanyProductId(id);
	}

	@Override
	public List<CompanyProductPrice> findByCompanyProductIds(Map<String,Object> parm) {
		
		return companyProuctPriceDao.findByCompanyProductIds(parm);
	}


	@Override
	public int findRows(Integer id) {

		return companyProuctPriceDao.findRows(id);
	}


	@Override
	public void deleteByIds(String ids) {
		companyProuctPriceDao.deleteByIds(ids);
		
	}

}
