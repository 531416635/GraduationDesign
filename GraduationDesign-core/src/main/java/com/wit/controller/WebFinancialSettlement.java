package com.wit.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Common;
import com.wit.model.CompanyBalanceLog;
import com.wit.model.CompanyBankAccount;
import com.wit.model.Invoice;
import com.wit.model.Page;
import com.wit.model.Settlement;
import com.wit.model.Users;
import com.wit.service.CompanyBalanceLogService;
import com.wit.service.CompanyBalanceService;
import com.wit.service.CompanyBankAccountService;
import com.wit.service.InvoiceService;
import com.wit.service.SettlementService;

/**
 * 财务结算、发票相关等控制器
 * 
 * @author tangxiaoqing
 * 
 */
@Controller
@RequestMapping("/merchant")
public class WebFinancialSettlement {

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private SettlementService settlementService;

	@Autowired
	private CompanyBankAccountService companyBankAccountService;
	
	@Autowired
	private CompanyBalanceService companyBalanceService;
	
	@Autowired
	private CompanyBalanceLogService companyBalanceLogService;

	/*
	 * 应付款项 申请发票、确认结算
	 */
	// 申请发票
	@RequestMapping(value = "applyInvoice", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String applyInvoice(Invoice db, HttpServletRequest request) {
		String json = "{'result':'false'}";
		// 获取用户登录信息
		Users user = (Users) request.getSession().getAttribute("user");
		Integer companyId = user.getCompanyId();
		// 获取用户支付的金额
		String amount = request.getParameter("amount");
		// 获取用户输入的发票抬头
		String invoiceTitle = request.getParameter("invoiceTitle");
		// 获取用户输入的银行账号
		String bankAccount = request.getParameter("bankAccount");
		// 存入银行账户信息
		CompanyBankAccount cba = new CompanyBankAccount();
		cba.setCompanyId(companyId);
		cba.setBankAccount(bankAccount);
		companyBankAccountService.addBankAccount(cba);
		try {
			// 存入结算单
			Settlement settlement = new Settlement();
			settlement.setSettleAmount(BigDecimal.valueOf(Double
					.valueOf(amount)));
			/*
			 * 点击申请发票时 存入结算单的数据是有发票的 结算单中 IsInvoice 0 代表没有发票 1代表有发票
			 */
			settlement.setIsInvoice(1);
			/*
			 * 结算状态为 初始 0 发起结算 1 结算完成 2
			 */
			settlement.setStatus(0);
			settlement.setBankAccountId(cba.getId());
			settlementService.addSettlement(settlement);
			String jsonobject = JSONObject.fromObject(settlement).toString();

			// 存入发票
			//db.setSettlementId(settlement.getSettlementId());
			db.setAmount(BigDecimal.valueOf(Double.valueOf(amount)));
			db.setInvoiceTitle(invoiceTitle);
			db.setCompanyId(companyId);
			invoiceService.insert(db);
			// json =
			// "{"+'\"'+"result"+'\"'+":"+true+","+'\"'+"settlement"+'\"'+":"+jsonobject+"}";
			json = "{'result':'true','settlement':'" + jsonobject + "'}";
			System.out.println(json);
		} catch (Exception e) {
			Common.setLog(e);
			return "error";
		}
		return json;
	}

	// 确认结算
	@RequestMapping("confirmSettlement")
	public String confirmSettlement(Integer tmpCompanyId,String tmpCurrency,BigDecimal tmpAmount,Integer settleType,String bankAccount,HttpServletRequest request) {
		try {
			//将结算信息插入结算单
			Users user = (Users)request.getSession().getAttribute("user");
			Settlement settlement = new Settlement();
			settlement.setCurrency(java.net.URLDecoder.decode(tmpCurrency,"UTF-8"));
			settlement.setSettleAmount(tmpAmount);
			settlement.setSettleBy(user.getId());
			settlement.setSettleType(settleType);
			settlement.setCompanyId(tmpCompanyId);
			settlement.setBankAccount(java.net.URLDecoder.decode(bankAccount,"UTF-8"));
			settlementService.addSettlement(settlement);
			//修改账户金额，记录账户流水
			Map<String,Object> parm = new HashMap<>();
			parm.put("tmpCompanyId", tmpCompanyId);
			parm.put("tmpCurrency",java.net.URLDecoder.decode(tmpCurrency,"UTF-8"));
			parm.put("tmpAmount", tmpAmount);
			companyBalanceService.editCompanyBalance(parm);
			return "redirect:statement.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 将发票抬头存入数据库
	@RequestMapping(value = "insertInvoiceTitle", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String insertInvoiceTitle(Invoice invoice, HttpServletRequest request) {
		String json = "{'result':'false'}";
		Users user = (Users) request.getSession().getAttribute("user");
		try {
			// 获取用户输入的发票抬头
			String invoiceTitle = request.getParameter("invoiceTitle");
			invoice.setInvoiceTitle(invoiceTitle);
			invoice.setCompanyId(user.getCompanyId());
			invoiceService.insert(invoice);
		} catch (Exception e) {
			Common.setLog(e);
			return "error";
		}
		return json;
	}

	// 将银行账号存入数据库
	@RequestMapping(value = "newAccount", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String newAccount(CompanyBankAccount companyBankAccount, HttpServletRequest request) {
		String json = "{'result':'false'}";
		Users user = (Users) request.getSession().getAttribute("user");
		try {
			// 获取用户输入的银行账号
			String bankAccount = request.getParameter("bankAccount");
			companyBankAccount.setBankAccount(bankAccount);
			companyBankAccount.setCompanyId(user.getCompanyId());
			companyBankAccountService.addBankAccount(companyBankAccount);
		} catch (Exception e) {
			Common.setLog(e);
			return "error";
		}
		return json;
	}
	
	//到发票申请页面
	@RequestMapping("toApplyForInvoice")
	public String toApplyForInvoice(Integer statementId,HttpServletRequest request){
		try {
			Users user = (Users)request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			List<Invoice> invoice = invoiceService.findByCompanyId(companyId);
			request.setAttribute("invoice", invoice);
			request.setAttribute("companyId", companyId);
			request.setAttribute("statementId", statementId);
			return "merchant/applyForInvoice";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	
	//采购商向平台申请发票
	@RequestMapping("applyForInvoice")
	public String applyForInvoice(Integer tmpInvoiceType,String tmpInvoiceTitle,BigDecimal tmpAmount,Integer tmpCompanyId,Integer tmpStatementId,HttpServletRequest request){
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("tmpInvoiceType", tmpInvoiceType);
			parm.put("tmpInvoiceTitle",java.net.URLDecoder.decode(tmpInvoiceTitle,"UTF-8"));
			parm.put("tmpAmount", tmpAmount);
			parm.put("tmpCompanyId", tmpCompanyId);
			parm.put("tmpStatementId", tmpStatementId);
			invoiceService.buyerInvoiceApply(parm);
			return "redirect:financeInfo.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	//采购商发票签收
	@RequestMapping("buyerInvoiceSign")
	public String buyerInvoiceSign(Integer tmpStatementId,HttpServletRequest request){
		try {
			invoiceService.signInvoice(tmpStatementId);
			return "redirect:financeInfo.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//供应商向平台寄出发票
	@RequestMapping("invoiceSendOut")
	public String invoiceSendOut(Integer tmpStatementId,HttpServletRequest request){
		try {
			invoiceService.updateInvoiceStatus(tmpStatementId);
			return "redirect:financeInfo.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//查看发票
	@RequestMapping("seeInvoice")
	public String seeInvoice(Integer statementId,HttpServletRequest request){
		try {
			Invoice invoice = invoiceService.findById(statementId);
			request.setAttribute("ic", invoice);
			return "merchant/applyForInvoice";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//公司资金账户流水
	@RequestMapping("accountWater")
	public String accountWater(Page page,HttpServletRequest request){
		String json = "";
		try {
			Users user = (Users)request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			Map<String,Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("Page", page);
			List<CompanyBalanceLog> companyBalanceLog = companyBalanceLogService.findById(parm);
			request.setAttribute("companyBalanceLog", companyBalanceLog);
			int rows = companyBalanceLogService.rows(companyId);
			page.setRows(rows);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "merchant/companyBalanceLog";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	
	//门户网站添加发票抬头
	@RequestMapping("addTitle")
	public String addTitle(HttpServletRequest request,Integer companyId,String title){
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("invoiceTitle", java.net.URLDecoder.decode(title,"UTF-8"));
			invoiceService.addTitle(parm);
			return "redirect:financeInfo.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
}
