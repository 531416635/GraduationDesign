package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.CompanyProductPic;
import com.wit.model.CompanyProducts;
import com.wit.model.Page;

public interface CompanyProductPicService {
	void insertPic(CompanyProductPic p);// 插入数据

	CompanyProductPic findbyId(Integer id);// 根据Id查找

	void update(CompanyProductPic p);// 更新数据

	// 根据商品ID查询相应的公司资质
	List<CompanyProductPic> findCompanyProductPicByProductId(Map<String, Integer> parm);
	
	// 根据companyProductsId查询相应的公司资质
		List<CompanyProductPic> findCompanyProductPicByCompanyId(Integer id);
}
