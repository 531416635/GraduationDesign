package com.wit.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ProductCategoryDao;

import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductType;
import com.wit.model.Products;

import com.wit.service.ProductCategoryService;

@Service
public class ProductCategoryServiceImpl implements ProductCategoryService {

	@Resource
	private ProductCategoryDao productCategoryDao;

	@Override
	public List<ProductCategory> findProductCategory(Page page) {
		return productCategoryDao.getAll(page);
	}

	@Override
	public void deleteProductCategory(Integer id) {
		productCategoryDao.delete(id);

	}

	public List<ProductCategory> getProductCategory(Integer productCategoryId,
			List<ProductCategory> productCategorys) {
		List<ProductCategory> tmp = new ArrayList<ProductCategory>();
		if (productCategorys != null && productCategorys.size() > 0) {
			for (ProductCategory p : productCategorys) {				
				if (p.getParentCateGory() != null
						&& p.getParentCateGory().equals(productCategoryId)) {
					tmp.add(p);

					List<ProductCategory> pcs = getProductCategory(p.getId(),
							productCategorys);
					if (pcs != null && pcs.size() > 0) {
						for (ProductCategory pc : pcs) {
							tmp.add(pc);
						}
					}
				}
			}
		}

		return tmp;
	}

	@Override
	public List<ProductCategory> getProductCategorys(Integer productCategoryId) {
		List<ProductCategory> productCategorys = findProductCategory();// findProductCategoryByParentID(productCategoryId);
		if (productCategorys != null && productCategorys.size() > 0) {
			List<ProductCategory> tmp =getProductCategory(productCategoryId, productCategorys);
			//添加自己
			/*tmp.add(findbyId(productCategoryId));*/
			return tmp;
		}
		return productCategorys;
	}

	@Override
	public Integer addProductCategory(ProductCategory productCategory) {
		 return productCategoryDao.add(productCategory);
	}

	@Override
	public ProductCategory findbyId(Integer id) {
		return productCategoryDao.findbyId(id);
	}

	@Override
	public void updateProductCategory(ProductCategory productCategory) {
		productCategoryDao.update(productCategory);

	}

	@Override
	public int findRows() {
		return productCategoryDao.findRows();
	}

	@Override
	public List<ProductCategory> findProductCategory() {

		return productCategoryDao.getAlls();
	}

	@Override
	public void deleteByIds(String ids) {
		productCategoryDao.deleteByIds(ids);

	}

	@Override
	public List<ProductCategory> getWebAll() {

		return productCategoryDao.getWebAll();
	}

	@Override
	public List<ProductCategory> getWebAllSun() {
		
		return productCategoryDao.getWebAllSun();
	}
	
	@Override
	public ProductCategory findWebbyId(Integer id) {

		return productCategoryDao.findWebbyId(id);
	}

	@Override
	public List<Products> findSecondProducts(Integer id) {

		return productCategoryDao.findSecondProducts(id);
	}

	@Override
	public List<Products> findHotProducts(Integer id) {

		return productCategoryDao.findHotProducts(id);
	}

	@Override
	public ProductCategory findWebProductCategory(Integer id) {

		return productCategoryDao.findWebProductCategory(id);
	}

	@Override
	public List<Products> findWebProductList(Integer productCategoryId,
			Integer productBrandId, String productType) {

		return productCategoryDao.findWebProductList(productCategoryId,
				productBrandId, productType);
	}

	@Override
	public List<ProductType> webFindProductTypes(Integer productCategoryId) {

		return productCategoryDao.webFindProductTypes(productCategoryId);
	}

	@Override
	public List<ProductCategory> getAllSSS() {

		return productCategoryDao.getAllSSS();
	}

	@Override
	public List<ProductCategory> getAllSSs(Integer id) {

		return productCategoryDao.getAllSSs(id);
	}

	@Override
	public List<ProductCategory> getAllSss(Integer id) {

		return productCategoryDao.getAllSss(id);
	}

	@Override
	public List<ProductCategory> findProductCategoryByParentID(Integer id) {
		return productCategoryDao.findProductCategorys(id);
	}
	
	//根据商品品类读取字段
	@Override
	public 	List<ProductCategory> getCateGoryByIds(String ids)
	{
		return productCategoryDao.getCateGoryByIds(ids);
	}

	@Override
	public String getCategoryByCompanyId(Integer companyId) {
		return productCategoryDao.getCategoryByCompanyId(companyId);
	}

	@Override
	public String getWebStandard(Integer productId) {
		
		return productCategoryDao.getWebStandard(productId);
	}
/*	@Override
	public List<ProductCategory> getChildrens(int id) {
	
		return productCategoryDao.getChildrens(id);
	}*/

	@Override
	public List<ProductCategory> findProductCategorysSun(String cateGoryId) {
		
		return productCategoryDao.findProductCategorysSun(cateGoryId);
	}

	@Override
	public List<ProductCategory> getChildrens(int id) {
		
		return productCategoryDao.getChildrens(id);
	}
	//查询顶级父类
	@Override
	public List<Integer> findSuperParent() {
		
		return productCategoryDao.findSuperParent();
	}

	@Override
	public List<ProductCategory> findByCateGoryId(Integer cateGoryId) {
		return productCategoryDao.findByCateGoryId(cateGoryId);
	}
	
	
}
