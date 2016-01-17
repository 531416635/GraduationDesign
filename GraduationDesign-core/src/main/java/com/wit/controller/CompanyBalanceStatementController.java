package com.wit.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyBalanceStatement;
import com.wit.model.Page;
import com.wit.service.CompanyBalanceStatementService;

/**
 * 资金对账单控制器
 * 
 * @author tangxiaoqing
 * 
 */
@Controller
public class CompanyBalanceStatementController {

	@Autowired
	private CompanyBalanceStatementService companyBalanceStatementService;

	// 根据公司ID查询资金对账单信息
	@RequestMapping("findCompanyBalanceStatement")
	public String findCompanyBalanceStatement(Integer companyId, Page page,
			HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("page", page);
			List<CompanyBalanceStatement> companyBalanceStatement = companyBalanceStatementService
					.findbyCompanyId(parm);
			request.setAttribute("cbs", companyBalanceStatement);
			request.setAttribute("companyId", companyId);
			int rows = companyBalanceStatementService.rows(companyId);
//			System.out.println("对账的记录数为："+rows);
			page.setRows(rows);
			request.setAttribute("page", page);
			request.setAttribute("companyId", companyId);
			return "Manager/companys/companyBalanceStatementInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 对账
	@RequestMapping("balanceOfAccount")
	public String balanceOfAccount(Integer id,BigDecimal amount,BigDecimal discount,Integer companyId,Integer stateType,HttpServletRequest request) {
		try {
			companyBalanceStatementService.reconciliation(id,amount,discount,stateType);
			return "redirect:findCompanyBalanceStatement.do?companyId="+companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
