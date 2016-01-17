package com.wit.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.ShoppingCartDao;
import com.wit.model.ShoppingCart;
import com.wit.service.ShoppingCartService;

@Service("ShoppingCartService")
public class ShoppingCartServiceImpl implements ShoppingCartService{

	@Autowired
	private ShoppingCartDao dao;

	@Override
	public List<ShoppingCart> findByUserId(Integer userId) {
		return dao.findByUserId(userId);
	}

	@Override
	public int findProductNum(Integer UserId) {
		return dao.findProductNum(UserId);
	}

	@Override
	public List<ShoppingCart> findByCompanyId(Integer companyId) {
		return dao.findByCompanyId(companyId);
	}
	
	@Override
	public void AddShoppingCart(ShoppingCart shoppingCart){
		 dao.insert(shoppingCart);
	}

	@Override
	public List<Map<String, Object>> findShopCartInfo(Map<String, Object> parm) {
		return dao.findShopCartInfo(parm);
	}

	@Override
	public int rows(Integer userId) {
		return dao.rows(userId);
	}

	@Override
	public List<Map<String, Object>> findDepartmentShopCarInfo(Map<String,Object> parm) {
		return dao.findDepartmentShopCarInfo(parm);
	}

	@Override
	public void updateShoppingCartStatus(Integer shoppingCartId,BigDecimal productQuantity) {
		dao.updateShoppingCartStatus(shoppingCartId,productQuantity);
	}
	@Override
	public int findShopCartInfoRows(Map<String, Object> parm)
	{
		return dao.findShopCartInfoRows(parm);
		
	}
	@Override
	public List<Map<String, Object>> findShopCartCompany(Map<String, Object> parm){
		return dao.findShopCartCompany(parm);
		
	}

	@Override
	public int findShopCartCompanyRows(Map<String, Object> parm){
		return dao.findShopCartCompanyRows(parm);
		
	}
	@Override
	public List<Map<String, Object>> findShopCartCompanyItem(Map<String, Object> parm){
		return dao.findShopCartCompanyItem(parm);
		
	}

	@Override
	public int findShopCartCompanyItemRows(Map<String, Object> parm){
		return dao.findShopCartCompanyItemRows(parm);
		
	}

	@Override
	public ShoppingCart findById(Integer shoppingCartId) {
		return dao.findById(shoppingCartId);
	}
	
	@Override
	public List<ShoppingCart> findByUserIdLimit(Map<String, Object> parm){
		return dao.findByUserIdLimit(parm);
	}
	
	@Override
	public void editShoppingCartStatus(String ids, int status){
		 dao.editShoppingCartStatus(ids,status);
	}
	//现货购物车查询
	@Override
	public List<Map<String, Object>> findSpotShopCartInfo(
			Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return  dao.findSpotShopCartInfo(parm);
	}
	//现货购物车查询
	@Override
	public int findSpotShopCartInfoRows(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return  dao.findSpotShopCartInfoRows(parm);
	}
}
