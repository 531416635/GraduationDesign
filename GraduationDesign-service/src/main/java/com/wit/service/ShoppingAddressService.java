package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Page;
import com.wit.model.ShoppingAddress;

public interface ShoppingAddressService {
	 	//查询
		List<ShoppingAddress> getAll();
		 //根据分页查询
		List<ShoppingAddress> getAlls(Page page);
		//删除数据
		void delete(Integer id);
		//根据ID字符数组删除数据
		void deleteByIds(String ids);

		//根据ID查询
		ShoppingAddress findbyId (Integer id);
		//更新
		void update(ShoppingAddress shoppingAddress);
		//记录信息条数
		int findRows();
		//根据公司ID查询
		List<ShoppingAddress> findbyShoppingAddress (Integer companyId, String address);
		//-根据地址Id查询
		ShoppingAddress findbyShoppingAddressId(Integer id);
		//添加配送地址
		void addPurchaserAddress(ShoppingAddress shoppingAddress);
		
		//添加供应地域
		void addSupplierAddress(ShoppingAddress shoppingAddress);
		
		void insertPurchaserAddress(ShoppingAddress shoppingAddress); //添加配送地址

		void insertSupplierAddress(ShoppingAddress shoppingAddress); //添加供应地域
		List<ShoppingAddress> getShoppingAddressByCompanyID(
				Map<String, Object> parm);
		int getShoppingAddressRowsByCompanyID(Map<String, Object> parm);
}
