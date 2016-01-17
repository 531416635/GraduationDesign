
package com.wit.dao;

import java.util.List;

import com.wit.model.ProductSample;

/**
 * 商品小样
 * @author lj
 *
 */
public interface ProductSampleDao {
	//查询
	List<ProductSample> getAll();
	//删除数据
	void delete(Integer id);
	//添加
	void add(ProductSample productSample);
	//更新
	void update(ProductSample productSample);
	
	
}

