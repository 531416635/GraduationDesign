package com.wit.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductPicDao;
import com.wit.model.ProductPic;
import com.wit.service.ProductPicService;
@Service
public class ProductPicServiceImpl implements ProductPicService {
	
	@Resource
	private ProductPicDao dao;
	
	@Override
	public void insertPic(ProductPic p) {
		dao.insertPic(p);
		
	}

	@Override
	public List<ProductPic> getProductPicByProductId(Integer id) {
		
		return dao.getProductPicByProductId(id);
	}
	
	@Override
	public ProductPic findbyId(Integer id) {
		
		return dao.findbyId(id);
	}

	@Override
	public void update(ProductPic p) {
		dao.update(p);	
	}
	@Override
	public void deleteById(Integer id){
		 dao.deleteById(id);
	}
	
	@Override
	public void updateIsDefault(Map<String, Integer> parm){
		dao.updateIsDefault(parm);
	}
	//根据ProductId查询首图
	@Override
	public String selectByProductId(Integer productId) {
		// TODO Auto-generated method stub
		return dao.selectByProductId(productId);
	}
}
