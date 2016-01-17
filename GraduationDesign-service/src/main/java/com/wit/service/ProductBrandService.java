package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.ProductBrand;

public interface ProductBrandService {

	List<ProductBrand> getIndexAll(); //首页查询推查询列表
	
	List<ProductBrand> getAll(); //系统后台添加查询列表
	
	//现货二级页面品牌显示
	List<ProductBrand> findByCateGoryId(Integer cateGoryId);
	

		ProductBrand findById(Integer id);
		
		List<ProductBrand> findAll(Page page);
		
		Integer findAllRows(Page page);
		
		void update(ProductBrand productBrand);
		
		void delete(Integer id);
		
		void insert(ProductBrand productBrand);
}
