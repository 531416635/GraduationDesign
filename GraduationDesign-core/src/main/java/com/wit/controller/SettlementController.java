package com.wit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyBalance;
import com.wit.model.CompanyBalanceStatement;
import com.wit.model.Companys;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.CompanyBalanceService;
import com.wit.service.CompanyBalanceStatementService;
import com.wit.service.CompanysService;
import com.wit.service.SettlementService;
import com.wit.service.UserService;

@Controller
public class SettlementController {

	@Autowired
	private SettlementService settlementService;

	@Autowired
	private CompanysService companysService;

	@Autowired
	private UserService userService;

	@Autowired
	private CompanyBalanceService companyBalanceService;

	@Autowired
	private CompanyBalanceStatementService companyBalanceStatementService;

	public SettlementService getSettlementService() {
		return settlementService;
	}

	public void setSettlementService(SettlementService settlementService) {
		this.settlementService = settlementService;
	}

	// 账户管理
	@RequestMapping("accountManagement")
	public String accountManagement(Page page,HttpServletRequest request) {
		try {
			// 获取登录User的信息
			Users user = (Users) request.getSession().getAttribute("userInfo");

			// 获取用户ID
			int userId = user.getId();

			// 根据用户ID获取公司ID
			Users users = userService.findbyId(userId);
			int companyId = users.getCompanyId();

			// 根据公司ID查询公司信息
			Companys companys = companysService.findById(companyId);
			request.setAttribute("companys", companys);

			// 根据公司ID显示当前金额
			CompanyBalance companyBalance = companyBalanceService
					.findById(companyId);
			System.out.println(companyBalance);
			request.setAttribute("companyBalance", companyBalance);

			// 每月账期交易详细情况
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("page", page);
			List<CompanyBalanceStatement> companyBalanceStatement = companyBalanceStatementService
					.findbyCompanyId(parm);
			request.setAttribute("cbs", companyBalanceStatement);
			return "Supplier/accountManagement";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

/*	// 对账
		@RequestMapping("duizhang")
		public String duizhang(CompanyBalanceStatement cbs,HttpServletRequest request) {
			try {
				companyBalanceStatementService.reconciliation(cbs);
				return "redirect:accountManagement.do?companyId="+cbs.getCompanyId();
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("InfoMessage",
						"信息载入失败！具体异常信息：" + e.getMessage());
				return "error";
			}
		}*/
}
