package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyProductPicDao;
import com.wit.model.CompanyProductPic;
import com.wit.service.CompanyProductPicService;

@Service
public class CompanyProductPicServiceImpl implements CompanyProductPicService {
	@Autowired
	private CompanyProductPicDao dao;

	@Override
	public void insertPic(CompanyProductPic p) {
		dao.insertPic(p);
	}

	@Override
	public CompanyProductPic findbyId(Integer id) {

		return dao.findbyId(id);
	}

	@Override
	public void update(CompanyProductPic p) {
		dao.update(p);

	}

	// 根据商品ID查询相应的公司资质
	@Override
	public List<CompanyProductPic> findCompanyProductPicByProductId(Map<String, Integer> parm) {
		return dao.findCompanyProductPicByProductId(parm);
	}
	
	// 根据companyProductsId查询相应的公司资质
		@Override
		public List<CompanyProductPic> findCompanyProductPicByCompanyId(Integer id) {
			return dao.findCompanyProductPicByCompanyId(id);
		}

}
