package com.wit.service;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.CompanyBalanceStatement;
import com.wit.model.Page;

/**
 *资金对账单
 */
public interface CompanyBalanceStatementService {

	//根据Id查询资金对账单信息
	List<CompanyBalanceStatement> findbyCompanyId(Map<String,Object> parm);
	
	void addCompanyBalanceStatement(CompanyBalanceStatement companyBalanceStatement);
	
	List<CompanyBalanceStatement> findStatementByCompanyId(Map<String,Object> parm);//根据公司ID查询对账单（微信端）
	
	Integer findStatementRowsByCompanyId(Integer companyId);//根据公司ID查询对账单总条数（微信端）
	//资金对账单行数
	int rows(Integer companyId);
	
	//对账
	void reconciliation(Integer id,BigDecimal amount,BigDecimal discount,Integer stateType);
	
	//门户对账
	void webReconciliation(String ids);
	
	//查看一段时间账单清空
	List<CompanyBalanceStatement> findTimeAccount(CompanyBalanceStatement cbs);
	
	//未结账款
	List<CompanyBalanceStatement> findNotCheckAccount(Map<String,Object> parm);
	
	//未结欠款
	List<CompanyBalanceStatement> findNotCheckArrears(Map<String,Object> parm);
	
	//本次对账金额
	BigDecimal findReconciliationAmount(String ids);
	
	//资金对账单信息（关联订单编号显示）
	List<Map<String,Object>> accountInfo(Map<String,Object> parm);
	
	//对账单明细行数
	int accountRow(Map<String,Object> parm);
	
	//根据ID查找
	CompanyBalanceStatement findAccountInfoById(Integer id);
	// 每季度根据公司ID统计累计采购金额
 BigDecimal CountPurchaseAmount(Integer companyId ,Date date);
 //每季度根据公司ID统计累计供应金额
 BigDecimal CountSupplyAmount(Integer companyId ,Date date);
 
	//改变对账状态，添加账户金额，记录账户流水
	void editCompanyBalanceStatement(Integer id);
 
}
