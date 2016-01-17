package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.Companys;
import com.wit.model.Page;

/**
 * 与采购商/供应商相关的数据层访问
 * @author tangxiaoqing
 *
 */

public interface CompanysDao {
	

	//查询所有采购商信息
	List<Companys>  findBuyer(Page page);
	
	//查询所有供应商信息
	List<Companys> findSupplier(Page page);
	
	//根据公司ID查找公司
	Companys findById(Integer companyId);
	
	//根据公司ID查找公司
	Companys webfindById(Integer companyId);
	
	
	
	//根据公司ID查找公司及关联商品价位
	List<Map<String,Object>> findByIds(Integer id);
	
	
	//根据公司名称搜索供应商信息
	List<Companys> findSupplierInfo(Map<String,Object> parm);
	
	//根据公司名称搜索采购商信息
	List<Companys> findBuyerInfo(Map<String,Object> parm);
	
	//增加采购商/供应商
	void add(Companys companys);
	
	//删除采购商/供应商
	void delete(Integer id);
	
	//修改采购商/供应商信息
	void updateCompany(Companys companys);
	
	//查询采购商行数
	int findBuyerRows();
	
	//查询供应商行数
	int findSupplierRows();
	
	//搜索供应商行数
	int supplierRows(String companyName);
	
	//搜索采购商行数
	int buyerRows(String companyName);
	
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//门户后台公司信息添加
	void completeCompanyInfo(Companys companys);
	
	//门户获取判断登录时状态
	Companys findLoginStatus(Integer companyId);

	//获取所有公司（去重）
	List<Companys> findAllCompanys();
	

	
}
