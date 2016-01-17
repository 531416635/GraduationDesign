package com.wit.dao;

import java.util.List;

import com.wit.model.CompanyBankAccount;
import com.wit.model.Page;

/**
 * 与银行账号相关数据层访问
 * 
 * @author tangxiaoqing
 * 
 */
public interface CompanyBankAccountDao {
	/* 查询所有供应商银行账户信息 */
	List<CompanyBankAccount> findSupplierBankAccount(Page page);

	/* 查询采购商银行账户信息 */
	List<CompanyBankAccount> findBuyerBankAccount(Page page);

	/* 根据id查找银行账号 */
	CompanyBankAccount findById(Integer id);

	/* 删除银行账户信息 */
	void deleteCompanyBankAccount(Integer companyId);

	/* 添加银行账号 */
	void addBankAccount(CompanyBankAccount companyBankAccount);

	/* 修改银行账号 */
	void updateCompanyBankAccount(CompanyBankAccount companyBankAccount);

	// 查询供应商银行账户行数
	int findSupplierRows();

	// 查询采购商银行账户行数
	int findBuyerRows();
	
	//根据公司ID查找银行账号信息
	List<CompanyBankAccount> findByCompanyId(Integer companyId);
}
