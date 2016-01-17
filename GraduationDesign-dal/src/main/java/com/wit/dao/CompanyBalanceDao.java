package com.wit.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.wit.model.CompanyBalance;
import com.wit.model.Page;

/**
 * 与资金账户相关的数据层访问
 * @author tangxiaoqing
 *
 */
public interface CompanyBalanceDao {
	/* 删除资金账户*/
	void deleteCompanyBalance(Integer id);
	
	//查询供应商资金账户
	public List<CompanyBalance> findSupplier(Page page);
	
	//查询采购商资金账户
	public List<CompanyBalance> findBuyer(Page page);
	
	//根据ID查找
	public CompanyBalance findById(Integer id); 
	
	//修改
	void update(CompanyBalance companyBalance);

	//增加
	void insert(CompanyBalance companyBalance);
	
	//查询供应商资金账户行数
	int findSupplierRows();
	
	//查询采购商资金账户行数
	int findBuyerRows();
	
	//冻结资金账户
	void updateBalance(Integer id);
	
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//对账更新账户金额
	void renewalBalance(String ids);

	List<CompanyBalance> findByCompanyId(Integer companyId);
	
	//改变对账状态，添加账户金额，记录账户流水
	void editCompanyBalance(Map<String,Object> parm);
	//根据公司ID查询账户资金量
	BigDecimal findBalanceByCompanyId(Map<String, Object> parm);
}
