package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductReviewDao;
import com.wit.model.ProductReview;
import com.wit.service.ProductReviewService;
@Service
public class ProductReviewServiceImpl implements ProductReviewService {
	@Resource
	private ProductReviewDao  productReviewdao;
	@Override
	public List<ProductReview> getAll() {
		
		return productReviewdao.getAll();
	}

	@Override
	public void delete(Integer id) {
		productReviewdao.deleteById(id);
		
	}

	@Override
	public void add(ProductReview ProductReview) {
		productReviewdao.insert(ProductReview);
		
	}

	@Override
	public ProductReview findbyId(Integer id) {
		
		return productReviewdao.findById(id);
	}

	@Override
	public void update(ProductReview ProductReview) {
		productReviewdao.update(ProductReview);
		
	}



	@Override
	public void deleteByIds(String ids) {
		productReviewdao.deleteByIds(ids);
		
	}

	@Override
	public List<ProductReview> getReviewByProductID(Integer id)
	{
		return productReviewdao.getReviewByProductID(id);
		
	}

}
