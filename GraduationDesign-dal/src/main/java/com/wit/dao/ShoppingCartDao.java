package com.wit.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized.Parameters;

import com.wit.model.ShoppingCart;
/**
 * @author ljj
 * time: 2015/3/26
 */

public interface ShoppingCartDao {
	    //查询数据
		List<ShoppingCart> findAll();
		//删除数据
		void deleteById(Integer id);
		//增加数据
		void insert(ShoppingCart db);
		//修改数据
		void update(ShoppingCart db);
		//通过id查找数据
		ShoppingCart findById(Integer shoppingCartId);
		
		//通过用户id查找数据
		List<ShoppingCart> findByUserId(Integer userId);
		
		//通过用户ID查询商品数量
		int findProductNum(Integer UserId);
		
		//通过公司ID查找进货单信息
		List<ShoppingCart> findByCompanyId(Integer companyId);
		
		//展示询价购物车信息
		List<Map<String,Object>> findShopCartInfo(Map<String,Object> parm);
		
		//询价购物车行数
		int rows(Integer userId);
		
		//查看本部门购物车情况
		List<Map<String,Object>> findDepartmentShopCarInfo(Map<String,Object> parm);
		
		//逻辑删除购物车数据
		void updateShoppingCartStatus(@Param(value="shoppingCartId")Integer shoppingCartId,@Param(value="productQuantity")BigDecimal productQuantity);
		
		//查询购物车信息条数
		int findShopCartInfoRows(Map<String, Object> parm);
		
		List<Map<String, Object>> findShopCartCompany(Map<String, Object> parm);
		
		int findShopCartCompanyRows(Map<String, Object> parm);
		
		List<Map<String, Object>> findShopCartCompanyItem(
				Map<String, Object> parm);
		int findShopCartCompanyItemRows(Map<String, Object> parm);
		
		void editShoppingCartStatus(@Param(value="ids") String ids, @Param(value="status") int status);
		
		List<ShoppingCart> findByUserIdLimit(Map<String, Object> parm);
		//现货购物车查询
		List<Map<String, Object>> findSpotShopCartInfo(Map<String, Object> parm);
		//现货购物车查询
		int findSpotShopCartInfoRows(Map<String, Object> parm);

}
