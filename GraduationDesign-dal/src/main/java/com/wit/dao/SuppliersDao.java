package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.Suppliers;

public interface SuppliersDao {

	public List<Suppliers> findAll(Map<String, Object> parm);

	public int insertSuppliers(Suppliers db);

	public List<Suppliers> findAllByCompanyProductId(Map<String, Object> parm);

	List<Map<String, Object>> findSuppliers(Map<String, Object> parm);

	int findSuppliersRows(Map<String, Object> parm);

	void editSuppliersStatus(Map<String, Object> parm);

	void delSuppliers(String ids);
}
