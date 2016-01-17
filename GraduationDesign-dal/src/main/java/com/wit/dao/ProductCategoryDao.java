package com.wit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductType;
import com.wit.model.Products;

/**
 * 商品品类
 * 
 * @author Administrator
 * 
 */

public interface ProductCategoryDao {

	List<ProductCategory> getAllSSS(); // 系统查询

	String getWebStandard(Integer productId); // 门户商品上下架管理显示规格

	List<ProductCategory> getAllSSs(Integer id); // 系统连级

	List<ProductCategory> getAllSss(Integer id); // 系统连级

	List<ProductCategory> findProductCategorys(Integer id);

	
	String getCategoryByCompanyId(Integer companyId);// 根据公司Id查询规格
	
	List<ProductCategory> getChildrens(int id);//获取子品类 

	/* …………………………………………………………分界线………………………………………………………………………………………… */

	List<ProductCategory> getAll(Page page); // 查询

	List<ProductCategory> getWebAll(); // 查询

	List<ProductCategory> getAlls(); // 查询

	List<ProductType> webFindProductTypes(Integer productCategoryId); // 内部关联查询商品类型

	void delete(Integer id); // 删除数据

	ProductCategory findWebProductCategory(Integer id); // 前台二级页子品类类别筛选列表

	List<Products> findSecondProducts(Integer id); // 二级页面推荐商品查询

	List<Products> findHotProducts(Integer id); // 二级页面热销商品查询

	List<Products> findWebProductList(
			@Param(value = "productCategoryId") Integer productCategoryId,
			@Param(value = "productBrandId") Integer productBrandId,
			@Param(value = "productType") String productType); // 二级页面商品筛选列表

	void deleteByIds(String ids); // 根据ID字符数组删除数据

	Integer add(ProductCategory productCategory); // 添加

	ProductCategory findbyId(Integer id); // 根据ID查询

	ProductCategory findWebbyId(Integer id); // 前台二级页面查询品类

	void update(ProductCategory productCategory); // 更新

	int findRows();

	List<ProductCategory> getCateGoryByIds(String ids);

	List<ProductCategory> findProductCategorysSun(String cateGoryId);

	List<ProductCategory> getWebAllSun();
	//查询顶级父类
	List<Integer> findSuperParent();
	
	//现货查询子类
	List<ProductCategory> findByCateGoryId(Integer cateGoryId);
	

}
