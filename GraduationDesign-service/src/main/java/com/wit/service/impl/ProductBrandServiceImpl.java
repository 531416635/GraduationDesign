package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductBrandDao;
import com.wit.model.Page;
import com.wit.model.ProductBrand;
import com.wit.service.ProductBrandService;
@Service
public class ProductBrandServiceImpl implements ProductBrandService{

	@Resource
	private ProductBrandDao dao;
	
	@Override
	public List<ProductBrand> getIndexAll() {
		return dao.getIndexAll();
	}

	@Override
	public List<ProductBrand> getAll() {
		
		return dao.getAll();
	}

	@Override
	public List<ProductBrand> findByCateGoryId(Integer cateGoryId) {
		return dao.findByCateGoryId(cateGoryId);
	}

	@Override
	public ProductBrand findById(Integer id) {
		
		return dao.findById(id);
	}

	@Override
	public List<ProductBrand> findAll(Page page) {
		
		return dao.findAll(page);
	}

	@Override
	public Integer findAllRows(Page page) {
		
		return dao.findAllRows(page);
	}

	@Override
	public void update(ProductBrand productBrand) {
		dao.update(productBrand);		
	}

	@Override
	public void delete(Integer id) {
		dao.delete(id);		
	}

	@Override
	public void insert(ProductBrand productBrand) {
	dao.insert(productBrand);	
	}

}
