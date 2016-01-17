package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.CompanyProductsDao;
import com.wit.model.CompanyProducts;
import com.wit.model.Page;
import com.wit.service.CompanyProductsService;
@Service
public class CompanyProductsServiceImpl implements CompanyProductsService {
	
	@Resource
	private CompanyProductsDao companyProductsDao;

	@Override
	public List<CompanyProducts> findCompanyProducts(Page page) {
		return companyProductsDao.findCompanyProducts(page);
	}

	@Override
	public void deleteCompanyProduct(Integer id) {
		companyProductsDao.deleteCompanyProduct(id);
		
	}

	@Override
	public void addCompanyProduct(CompanyProducts companyProduct) {
		companyProductsDao.addCompanyProduct(companyProduct);
		
	}

	@Override
	public CompanyProducts findbyId(Integer id) {
		return companyProductsDao.findbyId(id);
	}

	@Override
	public void updateCompanyProducts(CompanyProducts companyProduct) {
		companyProductsDao.updateCompanyProducts(companyProduct);		
	}

	@Override
	public int findRows() {
		return  companyProductsDao.findRows();
	}

	@Override
	public void deleteCompanyProductByIds(String ids) {
		companyProductsDao.deleteCompanyProductByIds(ids);
		
	}

	@Override
	public List<CompanyProducts> findCompanyProductsbyCompanyId(
			Map<String, Object> maps) {
		
		return companyProductsDao.findCompanyProductsbyCompanyId(maps);
	}

	@Override
	public int findRowsbyCompanyId(Integer companyId) {
		
		return companyProductsDao.findRowsbyCompanyId(companyId);
	}

	@Override
	public CompanyProducts findbyIds(Integer id) {
		return companyProductsDao.findbyIds(id);
	}

	@Override
	public List<Map<String, Object>> findProductsbyCompanyId(Map<String, Object> parm) {
		
		return companyProductsDao.findProductsbyCompanyId(parm);
	}
	@Override
	public int findProductsbyCompanyIdRows(Map<String, Object> parm) {
		
		return companyProductsDao.findProductsbyCompanyIdRows(parm);
	}
	@Override
	public void changeCompanyProductStatus(Map<String, Object> parm) {
		companyProductsDao.changeCompanyProductStatus(parm);	
	}

	@Override
	public List<CompanyProducts> findCompanyProductsbyCompanyIdProdcuts(
			Map<String, Object> maps) {	
		return companyProductsDao.findCompanyProductsbyCompanyIdProdcuts(maps);
	}

	@Override
	public List<CompanyProducts> findsupplyCheckList(Page page) {
		
		return companyProductsDao.findsupplyCheckList(page);
	}

	@Override
	public int findsupplyCheckListRows() {
		
		return companyProductsDao.findsupplyCheckListRows();
	}

	@Override
	public void changeCheck(Integer id, Integer status) {
		companyProductsDao.changeCheck(id, status);		
	}
	@Override
	public void changeCheckProduct(Integer id, Integer status) {
		companyProductsDao.changeCheckProduct(id, status);		
	}
	@Override
	public CompanyProducts findProductInfoById(Integer id) {
		
		return companyProductsDao.findProductInfoById(id) ;
	}

	@Override
	public void updateProductInfo(CompanyProducts companyproduct) {
		companyProductsDao.updateProductInfo(companyproduct);
		
	}
	
	//根据公司ID和商品ID查询IsSample
	@Override
	public int findProductSample(Map<String, Integer> par){
		return companyProductsDao.findProductSample(par);
		
	}

	@Override
	public Integer findbyProductId(int productId) {
		// TODO Auto-generated method stub
		return companyProductsDao.findbyProductId(productId);
	}

	@Override
	public List<CompanyProducts> webfindProductPicbyCompanyId(
			Map<String, Object> parm) {
		
		return companyProductsDao.webfindProductPicbyCompanyId(parm);
	}

	@Override
	public int webfindProductPicbyCompanyIdRows(Map<String, Object> parm) {
		
		return companyProductsDao.webfindProductPicbyCompanyIdRows(parm);
	}

	@Override
	public List<Map<String, Object>> productSupply(Map<String, Object> parm) {
		return companyProductsDao.productSupply(parm);
	}

	
}
