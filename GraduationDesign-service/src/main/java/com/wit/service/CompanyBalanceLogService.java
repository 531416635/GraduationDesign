package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.CompanyBalanceLog;

public interface CompanyBalanceLogService {

	// 查询所有
	public List<CompanyBalanceLog> findAll();

	// 根据ID查找
	List<CompanyBalanceLog> findById(Map<String,Object> parm);

	// 修改
	void update(CompanyBalanceLog companyBalanceLog);

	// 删除
	void delete(Integer id);

	// 增加
	void insert(CompanyBalanceLog companyBalanceLog);
	
	//查询行数
	int rows(Integer id);
	
}
