package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.CompanyProductPrice;



public interface CompanyProductPriceDao {

	//查询所有
	public List<CompanyProductPrice> findAll();
	
	//根据ID查找
	CompanyProductPrice findById(Integer id); 
	
	//根据companyProductID查找
	List<CompanyProductPrice> findByCompanyProductId(Integer id); 
	
	//根据companyProductID及分页查找
	List<CompanyProductPrice> findByCompanyProductIds(Map<String,Object> parm); 
		
	//根据IDs查找
	CompanyProductPrice findByIds(Map<String,Integer> parm); 
	
	//修改
	void update(CompanyProductPrice companyProductPrice);
	
	//删除
	void delete(Integer id);
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//增加
	void insert(CompanyProductPrice companyProductPrice);
	
	//记录信息条数
			int findRows(Integer id);
}
