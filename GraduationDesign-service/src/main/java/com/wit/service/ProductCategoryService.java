package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductType;
import com.wit.model.Products;

/**
 * @author ljj time: 2015/3/26
 */

public interface ProductCategoryService {

	List<ProductCategory> getAllSSS(); 	//系统查询
	
	List<ProductCategory> getAllSSs(Integer id); 	//系统连级
	
	String getWebStandard(Integer productId); //门户商品上下架管理显示规格
	
	String getCategoryByCompanyId(Integer companyId);// 根据公司Id查询规格 
	
	List<ProductCategory> getAllSss(Integer id); 	//系统连级
	
	List<ProductCategory> findProductCategoryByParentID(Integer id);
	
	List<ProductCategory> getProductCategorys(Integer productCategoryId);
	
	List<ProductCategory> getChildrens(int id);//获取子品类 
	
	
	/* …………………………………………………………分界线…………………………………………………………………………………………  */
	// 分页查询所有商品品类
	List<ProductCategory> findProductCategory(Page page);
	
	ProductCategory findWebProductCategory(Integer id); //前台二级页子品类类别筛选列表
	// 查询所有商品品类
	List<ProductCategory> findProductCategory();
	//查询
	List<ProductCategory> getWebAll();
	//前台二级页面查询品类
	ProductCategory findWebbyId (Integer id);
	//二级页面推荐商品查询
	List<Products> findSecondProducts(Integer id);
	//二级页面热销商品查询
	List<Products> findHotProducts(Integer id);
	
	List<ProductType> webFindProductTypes(Integer productCategoryId); //内部关联查询商品类型
	
	List<Products> findWebProductList(Integer productCategoryId,Integer productBrandId,String productType); //二级页面商品筛选列表
	// 删除商品品类
	void deleteProductCategory(Integer id);

	// 根据ID字符数组删除数据
	void deleteByIds(String ids);

	// 增加商品品类
	Integer addProductCategory(ProductCategory productCategory);

	// 根据Id查询商品品类
	ProductCategory findbyId(Integer id);

	// 更新商品品类
	void updateProductCategory(ProductCategory productCategory);

	int findRows();
	//根据商品品类读取字段
	List<ProductCategory> getCateGoryByIds(String ids);

	List<ProductCategory> findProductCategorysSun(String cateGoryId);

	List<ProductCategory> getWebAllSun();
	//查询顶级父类
	List<Integer> findSuperParent();
	
	//现货查询子类
	List<ProductCategory> findByCateGoryId(Integer cateGoryId);

}
