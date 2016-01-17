package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductTypeDao;
import com.wit.model.Page;
import com.wit.model.ProductType;
import com.wit.service.ProductTypeService;
@Service
public class ProductTypeServiceImpl implements ProductTypeService {
	@Resource
	private ProductTypeDao productTypedao;
	@Override
	public List<ProductType> getAll() {
		
		return productTypedao.getAll();
	}

	@Override
	public void delete(Integer id) {
		productTypedao.delete(id);
		
	}

	@Override
	public void add(ProductType productType) {
		productTypedao.add(productType);
		
	}

	@Override
	public ProductType findbyId(Integer id) {
		
		return productTypedao.findbyId(id);
	}

	@Override
	public void update(ProductType productType) {
		productTypedao.update(productType);
		
	}

	@Override
	public List<ProductType> getAlls(Page page) {
		
		return productTypedao.getAlls(page);
	}

	@Override
	public int findRows() {
	
		return productTypedao.findRows();
	}

	@Override
	public void deleteByIds(String ids) {
		productTypedao.deleteByIds(ids);
		
	}

	@Override
	public List<ProductType> webFindByCategoryId(Integer id) {
		
		return productTypedao.webFindByCategoryId(id);
	}

	@Override
	public List<ProductType> getproductTypeSon(Integer parentType,Integer categoryId) {
		
		return productTypedao.getproductTypeSon(parentType, categoryId);
	}

}
