package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.CompanyContracts;

public interface CompanyContractService {

	/*供应商合同表所有*/
	List<CompanyContracts> findCompanyContracts();
	
	/*根据公司id查询合同表*/
	List<CompanyContracts> findByCompanyId(Integer companyId);
	
	/*删除合同*/
	void deleteCompanyContracts(Integer companyId);
	
	/*修改合同*/
	void updateCompanyContracts(CompanyContracts companyContracts);
	
	//增加
	void insert(CompanyContracts companyContracts);
	
	//根据ID查找
	CompanyContracts findById(Integer id);
	/*根据公司id分页查询合同表*/
	List<CompanyContracts> findByCompanyIds(Map<String,Object> parm);
	
	int findRows(Integer companyId);
	
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//根据公司id获取合同信息
		List<CompanyContracts> checkCompanyContractsByCompanyId(Integer companyId);
	
	//修改合同状态
	void updateContractStatus(Integer id); 
}
