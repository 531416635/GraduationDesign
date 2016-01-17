package com.wit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wit.model.ProductPic;

public interface ProductPicService {
void insertPic(ProductPic p);//插入数据
	
	ProductPic findbyId(Integer id);//根据Id查找
	
	void update (ProductPic p);//更新数据

	List<ProductPic> getProductPicByProductId(Integer id);

	void deleteById(Integer id);//根据Id删除
	
	void updateIsDefault (Map<String, Integer> parm);//根据ID更新首图，
	//根据ProductId查询首图
	String selectByProductId(Integer productId);
}
