package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ShoppingAddressDao;
import com.wit.model.Page;
import com.wit.model.ShoppingAddress;
import com.wit.service.ShoppingAddressService;

@Service
public class ShoppingAddressServiceImpl implements ShoppingAddressService {
	@Resource
	private ShoppingAddressDao shoppingAddressDao;

	@Override
	public ShoppingAddress findbyId(Integer id) {

		return shoppingAddressDao.findbyId(id);
	}

	@Override
	public void update(ShoppingAddress shoppingAddress) {
		shoppingAddressDao.update(shoppingAddress);

	}

	@Override
	public List<ShoppingAddress> getAll() {

		return shoppingAddressDao.getAll();
	}

	@Override
	public void delete(Integer id) {
		shoppingAddressDao.delete(id);

	}

	@Override
	public List<ShoppingAddress> getAlls(Page page) {

		return shoppingAddressDao.getAlls(page);
	}

	@Override
	public int findRows() {

		return shoppingAddressDao.findRows();
	}

	@Override
	public void deleteByIds(String ids) {
		shoppingAddressDao.deleteByIds(ids);

	}

	@Override
	public List<ShoppingAddress> findbyShoppingAddress(Integer companyId,
			String address) {
		return shoppingAddressDao.findbyShoppingAddress(companyId, address);
	}

	@Override
	public void addPurchaserAddress(ShoppingAddress shoppingAddress) {
		shoppingAddressDao.addPurchaserAddress(shoppingAddress);

	}

	@Override
	public void addSupplierAddress(ShoppingAddress shoppingAddress) {
		shoppingAddressDao.addSupplierAddress(shoppingAddress);

	}

	@Override
	public void insertPurchaserAddress(ShoppingAddress shoppingAddress) {
		shoppingAddressDao.insertPurchaserAddress(shoppingAddress);

	}

	@Override
	public void insertSupplierAddress(ShoppingAddress shoppingAddress) {
		shoppingAddressDao.insertSupplierAddress(shoppingAddress);
	}

	@Override
	public ShoppingAddress findbyShoppingAddressId(Integer id) {

		return shoppingAddressDao.findbyShoppingAddressId(id);
	}

	@Override
	public List<ShoppingAddress> getShoppingAddressByCompanyID(
			Map<String, Object> parm) {
		return shoppingAddressDao.getShoppingAddressByCompanyID(parm);
	}

	@Override
	public int getShoppingAddressRowsByCompanyID(Map<String, Object> parm) {
		
		return shoppingAddressDao.getShoppingAddressRowsByCompanyID(parm);
	}

}
