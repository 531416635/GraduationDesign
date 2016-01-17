package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductTransferDao;
import com.wit.model.ProductTransfer;
import com.wit.service.ProductTransferService;
@Service
public class ProductTransferServiceImpl implements ProductTransferService{
	@Resource
	private ProductTransferDao productTransferDao;
	@Override
	public List<ProductTransfer> findProductTransfer() {
		return productTransferDao.findProductTransfer();
	}

	@Override
	public void deleteProductTransfer(Integer id) {
		productTransferDao.deleteProductTransfer(id);
		
	}

	@Override
	public void addProductTransfer(ProductTransfer productTransfer) {
		productTransferDao.addProductTransfer(productTransfer);
		
	}

	@Override
	public ProductTransfer findbyId(Integer id) {
		return productTransferDao.findbyId(id);
	}


	@Override
	public void updateProductTransfer(ProductTransfer productTransfer) {
		productTransferDao.updateProductTransfer(productTransfer);
		
	}

	public ProductTransferDao getProductTransferDao() {
		return productTransferDao;
	}

	public void setProductTransferDao(ProductTransferDao productTransferDao) {
		this.productTransferDao = productTransferDao;
	}

	@Override
	public List<ProductTransfer> findbycompanyProductId(Integer companyProductId) {
		
		return productTransferDao.findbycompanyProductId(companyProductId);
	}

	@Override
	public List<ProductTransfer> findbycompanyProductIds(
			Map<String, Object> maps) {
		
		return productTransferDao.findbycompanyProductIds(maps);
	}

	@Override
	public int findRows(Integer companyProductID) {
		
		return productTransferDao.findRows(companyProductID);
	}

	@Override
	public void deleteProductTransferByIds(String ids) {
		productTransferDao.deleteProductTransferByIds(ids);
		
	}
	

}
