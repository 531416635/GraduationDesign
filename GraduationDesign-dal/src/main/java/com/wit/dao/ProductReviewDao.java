package com.wit.dao;

import java.util.List;

import com.wit.model.ProductReview;
/**
 * @author ljj
 * time: 2015/3/26
 */

public interface ProductReviewDao {
	//查询数据
	List<ProductReview> findAll();
	//删除数据
	void deleteById(Integer id);
	//增加数据
	void insert(ProductReview db);
	//修改数据
	void update(ProductReview db);
	//通过id查找数据
	ProductReview findById(Integer id);
	List<ProductReview> getAll();
	void deleteByIds(String ids);
	List<ProductReview> getReviewByProductID(Integer id);

}
