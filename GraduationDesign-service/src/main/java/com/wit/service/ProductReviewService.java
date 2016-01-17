package com.wit.service;

import java.util.List;

import com.wit.model.ProductReview;

public interface ProductReviewService {

	List<ProductReview> getAll();

	void delete(Integer id);

	void add(ProductReview ProductReview);

	ProductReview findbyId(Integer id);

	void update(ProductReview ProductReview);

	void deleteByIds(String ids);

	List<ProductReview> getReviewByProductID(Integer id);

}
