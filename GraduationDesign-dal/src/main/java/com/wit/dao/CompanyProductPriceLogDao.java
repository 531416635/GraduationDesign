package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.CompanyProductPriceLog;




public interface CompanyProductPriceLogDao {

	//查询所有
	public List<CompanyProductPriceLog> findAllByCompanyProductId(Integer id);
	
	//查询所有
	public List<CompanyProductPriceLog> findAllByCompanyId(Map<String,Object> maps);
	
	//根据id查找
	public CompanyProductPriceLog findById(int id); 
	
	//修改
	void update(CompanyProductPriceLog companyProductPriceLog);
	
	//删除
	void delete(Integer id);
	
	//增加
	void insert(CompanyProductPriceLog companyProductPriceLog);
	
	int findRows(Integer productId);
}
