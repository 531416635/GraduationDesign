package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.SuppliersDao;
import com.wit.model.Suppliers;
import com.wit.service.SuppliersService;

@Service
public class SuppliersServiceImpl implements SuppliersService {

	@Resource
	private SuppliersDao suppliersDao;

	@Override
	public  List<Suppliers> findAll(Map<String, Object> parm){
		
		return suppliersDao.findAll(parm);
	}
	@Override
	public  int insertSuppliers(Suppliers db) {
		
		return suppliersDao.insertSuppliers(db) ;
	}
	@Override
	public List<Suppliers> findAllByCompanyProductId(Map<String, Object> parm){
		
		return suppliersDao.findAllByCompanyProductId(parm) ;
	}
	

	@Override
	public List<Map<String, Object>> findSuppliers(Map<String, Object> parm){
		return suppliersDao.findSuppliers(parm);
	}

	@Override
	public int findSuppliersRows(Map<String, Object> parm){
		return suppliersDao.findSuppliersRows(parm);
	}
	@Override
	public void editSuppliersStatus(Map<String, Object> parm){
		suppliersDao.editSuppliersStatus(parm);
	}

	@Override
	public void delSuppliers(String ids){
		suppliersDao.delSuppliers(ids);
	}
}
