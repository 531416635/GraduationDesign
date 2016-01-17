package com.wit.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.FiltratePage;
import com.wit.model.Page;
import com.wit.model.ProductSample;
import com.wit.model.Products;
import com.wit.model.SecondPage;
/**
 * @author ljj
 * time: 2015/3/26
 */

public interface ProductsDao {
	    List<Products> webfindProducts(FiltratePage page);  // 商户筛选商品出售
	   
		List<Products> findAll(Page page);  //查询数据
		
		List<Products> checkList(Map<String, Object> parm);//查询需审核数据
		
		List<Products> findProducts(Integer productcateGoryId);//门户首页根据类别Id查询类别展示商品
	
		void deleteById(Integer id); 	//删除数据
		
		void changeCheck(@Param(value = "id") Integer id, 
				@Param(value = "status") Integer status);
				                       //更改审核状态
		
		void deleteByIds(String ids); //根据ID字符数组删除数据
		
		void insert(Products db); //增加数据
		
		void update(Products db); //修改数据
		
		Products findById(Integer id); //通过id查找数据
		
		Products findWebById(Integer id);//门户三级商品详情信息 
		
		int findRows(); //记录信息条数
		
		int findcheckListRows(Map<String, Object> parm);
		int checkListRows(String productName);//审核信息条数
		
		Integer webfindRows(FiltratePage page); 
		
		//精确查找
		Products findByCode(String code);

		List<Products> findProductsByCategory(@Param(value = "page") Page page,
				@Param(value = "category") String category, 
				@Param(value = "isHot") String isHot,
				@Param(value = "isHome") String isHome, 
				@Param(value = "isSub") String isSub);
		
		List<Products> findProductsByCategorys(SecondPage page); //二级界面筛选的商品
		
		int findRowsByCategorys(SecondPage page); //二级界面筛选商品总条数
		
		int findRowsByCategory(@Param(value = "category") String category, 
				@Param(value = "isHot") String isHot,
				@Param(value = "isHome") String isHome, 
				@Param(value = "isSub") String isSub); //首页到二级界面筛选商品总条数
		
		

		void spotProduct(Map<String,Object> parm);//根据id将商品加入现货特供

		List<Products> findProductspot(Integer id);//现货特供门户首页根据类别Id查询类别展示商品

		//新增商品小样  
		void insertProductSample(ProductSample productSample);
		
		//查询商品小样
		List<Map<String, Object>> selectProductSample(Map<String, Object> parm);
		//查询指定商品小样的申请时间  
		Date checkProductSample(Map<String, Integer> parm);
		//商品小样分页
		int findRowsSamples(Map<String, Object> parm);

		//团购商品显示
		List<Map<String, Object>> findGroupPurchase(Map<String, Object> parm);

		//显示现货特价商品,根据类别Id查询类别展示商品
		List<Map<String,Object>> findSpotProducts(Integer productcateGoryId);
		
		//后台根据商品名称搜索对应的商品
		List<Products> findAllByName(Map<String, Object> parm);
		
		//后台根据商品名称搜索对应的商品的总数目
		int findRowsByName(Map<String, Object> parm);
		
		//三级界面通过规格来切换商品信息
		Integer findProductByModel(@Param(value = "productName") String productName, @Param(value = "productModel") Integer productModel);

		//现货二级页面信息展示
		List<Map<String,Object>> findSecondSpotProducts(Integer cateGoryId);
		
		//现货二级页面热门推荐
		List<Map<String,Object>> findHotSpotProducts(Integer cateGoryId);
}
