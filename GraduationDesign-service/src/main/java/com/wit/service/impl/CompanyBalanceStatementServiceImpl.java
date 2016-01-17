package com.wit.service.impl;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyBalanceStatementDao;
import com.wit.model.CompanyBalanceStatement;
import com.wit.model.Page;
import com.wit.service.CompanyBalanceStatementService;

@Service("CompanyBalanceStatementService")
public class CompanyBalanceStatementServiceImpl implements CompanyBalanceStatementService{

	@Autowired
	private CompanyBalanceStatementDao dao;

	/*@Override
	public List<CompanyBalanceStatement> findbyCompanyId(Map<String,Object> parm) {
		return dao.findbyCompanyId(parm);
	}*/

	@Override
	public int rows(Integer companyId) {
		return dao.rows(companyId);
	}



	@Override
	public List<CompanyBalanceStatement> findTimeAccount(
			CompanyBalanceStatement cbs) {
		return dao.findTimeAccount(cbs);
	}

	@Override
	public void reconciliation(Integer id,BigDecimal amount,BigDecimal discount,Integer stateType) {
		dao.reconciliation(id,amount,discount,stateType);
		
	}

	@Override
	public void webReconciliation(String ids) {
		dao.webReconciliation(ids);
		
	}

	@Override
	public List<CompanyBalanceStatement> findNotCheckAccount(
			Map<String, Object> parm) {
		return dao.findNotCheckAccount(parm);
	}

	@Override
	public List<CompanyBalanceStatement> findNotCheckArrears(
			Map<String, Object> parm) {
		return dao.findNotCheckArrears(parm);
	}

	@Override
	public BigDecimal findReconciliationAmount(String ids) {
		return dao.findReconciliationAmount(ids);
	}

	@Override
	public List<Map<String, Object>> accountInfo(Map<String,Object> parm) {
		return dao.accountInfo(parm);
	}

	@Override
	public void addCompanyBalanceStatement(
			CompanyBalanceStatement companyBalanceStatement) {
		dao.addCompanyBalanceStatement(companyBalanceStatement);
	}

	@Override
	public int accountRow(Map<String,Object> parm) {
		return dao.accountRow(parm);
	}

	@Override
	public CompanyBalanceStatement findAccountInfoById(Integer id) {
		return dao.findAccountInfoById(id);
	}

	@Override
	public BigDecimal CountPurchaseAmount(Integer companyId, Date date) {
	    return dao.CountPurchaseAmount(companyId, date);
	}

	@Override
	public BigDecimal CountSupplyAmount(Integer companyId, Date date) {
		
		return dao.CountSupplyAmount(companyId, date);
	}

	@Override
	public void editCompanyBalanceStatement(Integer id) {
		dao.editCompanyBalanceStatement(id);
	}

	@Override
	public List<CompanyBalanceStatement> findStatementByCompanyId(
			Map<String, Object> parm) {
		
		return dao.findStatementByCompanyId(parm);
	}

	@Override
	public Integer findStatementRowsByCompanyId(Integer companyId) {
		
		return dao.findStatementRowsByCompanyId(companyId);
	}



	@Override
	public List<CompanyBalanceStatement> findbyCompanyId(
			Map<String, Object> parm) {
		
		return dao.findByCompanyId(parm);
	}



}
