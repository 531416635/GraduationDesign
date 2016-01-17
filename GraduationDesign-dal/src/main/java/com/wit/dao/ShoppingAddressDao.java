
package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.ShoppingAddress;

/**
 * 配送地址
 * @author lj
 *
 */
public interface ShoppingAddressDao {
	 //查询
	List<ShoppingAddress> getAll();
	 //根据分页查询
	List<ShoppingAddress> getAlls(Page page);
	//删除数据
	void delete(Integer id);
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//添加配送地址
	void addPurchaserAddress(ShoppingAddress shoppingAddress);
	
	void insertPurchaserAddress(ShoppingAddress shoppingAddress); //添加配送地址

	void insertSupplierAddress(ShoppingAddress shoppingAddress); //添加供应地域
	
	//添加供应地域
	void addSupplierAddress(ShoppingAddress shoppingAddress);
	
	//根据ID查询
	ShoppingAddress findbyId (Integer id);
	//更新
	void update(ShoppingAddress shoppingAddress);
	//记录信息条数
	int findRows();
	
	//根据公司ID,地址查询
	List<ShoppingAddress> findbyShoppingAddress (@Param(value = "companyId")Integer companyId, @Param(value = "address")String address);
	//-根据地址Id查询
	ShoppingAddress findbyShoppingAddressId(Integer id);
	
	List<ShoppingAddress> getShoppingAddressByCompanyID(Map<String, Object> parm);
	int getShoppingAddressRowsByCompanyID(Map<String, Object> parm);
}

