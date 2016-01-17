package com.wit.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductCategoryDao;
import com.wit.dao.ProductsDao;
import com.wit.model.FiltratePage;
import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductSample;
import com.wit.model.Products;
import com.wit.model.SecondPage;
import com.wit.service.ProductsService;

@Service
public class ProductsServiceImpl implements ProductsService {

	@Resource
	private ProductsDao productsDao;

	@Resource
	private ProductCategoryDao findProductCategoryDao;

	@Override
	public List<Products> findAll(Page page) {
		return productsDao.findAll(page);
	}

	@Override
	public void deleteById(Integer id) {
		productsDao.deleteById(id);

	}

	@Override
	public void insert(Products db) {
		productsDao.insert(db);

	}

	@Override
	public void update(Products db) {
		productsDao.update(db);

	}

	@Override
	public Products findById(Integer id) {
		return productsDao.findById(id);
	}
	
	
	@Override
	public  void changeCheck(Integer id , Integer status){
		 productsDao.changeCheck(id , status );
	}

	@Override
	public ProductCategory findProductcategory(Integer id) {
		return findProductCategoryDao.findbyId(id);
	}

	@Override
	public int findRows() {
		return productsDao.findRows();
	}

	@Override
	public void deleteByIds(String ids) {
		productsDao.deleteByIds(ids);

	}

	@Override
	public Products findWebById(Integer id) {

		return productsDao.findWebById(id);
	}

	@Override
	public Products findByCode(String code) {
		return productsDao.findByCode(code);
	}

	@Override
	public List<Products> findProducts(Integer productcateGoryId) {

		return productsDao.findProducts(productcateGoryId);
	}

	@Override
	public List<Products> findProductsByCategory(Page page,String category, String isHot,
			String isHome, String isSub) {
		return productsDao.findProductsByCategory(page,category, isHot, isHome,
				isSub);
	}

	@Override
	public List<Products> webfindProducts(FiltratePage page) {
		
		return productsDao.webfindProducts(page);
	}

	@Override
	public Integer webfindRows(FiltratePage page) {
		
		return productsDao.webfindRows(page);
	}

	@Override
	public List<Products> findProductsByCategorys(SecondPage page) {
	
		return productsDao.findProductsByCategorys(page);
	}

	@Override
	public int findRowsByCategorys(SecondPage page) {
	
		return productsDao.findRowsByCategorys(page);
	}

	@Override
	public int findRowsByCategory(String category, String isHot, String isHome,
			String isSub) {
		
		return productsDao.findRowsByCategory(category, isHot, isHome, isSub);
	}
	
	@Override
	public int checkListRows(String productName){
		return productsDao.checkListRows(productName);
	}
	
	@Override
	public int findcheckListRows(Map<String,Object> parm){
		return productsDao.findcheckListRows(parm);
	}

	@Override
	public List<Products> checkList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void spotProduct(Map<String,Object> parm) {
		// TODO Auto-generated method stub		
		 productsDao.spotProduct(parm);
		
	}
	
	@Override
	public  List<Products>  findProductspot(Integer id){
		return productsDao.findProductspot(id);
	}

	
	//新增商品小样  
	@Override
	public void insertProductSample(ProductSample ProductSample) {
		// TODO Auto-generated method stub
		productsDao.insertProductSample(ProductSample);
	}
	
	//查询商品小样  
	@Override
	public List<Map<String, Object>> selectProductSample(Map<String, Object> parm){
		return	productsDao.selectProductSample(parm);
				
			}
	
	//查询指定商品小样的申请时间  
	@Override
	public	Date checkProductSample(Map<String, Integer> parm){
		return productsDao.checkProductSample(parm);
	}
	
	//商品小样分页
	@Override
	public	int findRowsSamples(Map<String, Object> parm){
		return productsDao.findRowsSamples(parm);
	}
	
	
	//团购商品显示
	@Override
	public List<Map<String, Object>> findGroupPurchase(Map<String, Object> parm){
		return	productsDao.findGroupPurchase(parm);
				
			}

	@Override
	public List<Map<String,Object>> findSpotProducts(Integer productcateGoryId) {
		return productsDao.findSpotProducts(productcateGoryId);
	}
	//后台根据商品名称搜索对应的商品
	@Override
	public List<Products> findAllByName(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return productsDao.findAllByName(parm);
	}
	//后台根据商品名称搜索对应的商品的总数目
	@Override
	public int findRowsByName(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return productsDao.findRowsByName(parm);
	}

	@Override
	public Integer findProductByModel(String productName, Integer productModel) {	
		return productsDao.findProductByModel(productName, productModel);
	}

	@Override
	public List<Map<String, Object>> findSecondSpotProducts(Integer cateGoryId) {
		return productsDao.findSecondSpotProducts(cateGoryId);
	}

	@Override
	public List<Map<String, Object>> findHotSpotProducts(Integer cateGoryId) {
		return productsDao.findHotSpotProducts(cateGoryId);
	}

	@Override
	public List<Products> checkList(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return productsDao.checkList(parm);
	}	
}
