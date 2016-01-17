package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.CompanyProductPic;

public interface CompanyProductPicDao {

	void insertPic(CompanyProductPic p);// 插入数据

	CompanyProductPic findbyId(Integer id);// 根据Id查找

	void update(CompanyProductPic p);// 更新数据

	// 根据商品ID查询相应的公司资质
	List<CompanyProductPic> findCompanyProductPicByProductId(Map<String, Integer> parm);
	
	// 根据companyProductsId查询
	List<CompanyProductPic> findCompanyProductPicByCompanyId(Integer id);

}
