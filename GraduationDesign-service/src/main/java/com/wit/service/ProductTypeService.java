package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.ProductType;

public interface ProductTypeService {
	
	List<ProductType> webFindByCategoryId(Integer id); // 前端二级页面商品类型列表 
		
		List<ProductType>getAll(); //查询
		
		List<ProductType>getAlls(Page page); //查询
		
		List<ProductType>getproductTypeSon(Integer parentType,Integer categoryId); //根据品类和商品属性查询所有属性值
		
		void delete(Integer id); //删除数据 
		
		void deleteByIds(String ids); //根据ID字符数组删除数据
		
		void add(ProductType productType); //添加
		
		ProductType findbyId(Integer id); //根据ID查询
		
		void update(ProductType productType); //更新
		
		int findRows(); //记录信息条数 
}
