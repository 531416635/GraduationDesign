package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyBalance;

import com.wit.model.Page;
import com.wit.service.CompanyBalanceService;


/**
 * 与公司资金账户相关的控制
 * 
 * @author tangxiaoqing
 * 
 */
@Controller
public class CompanyBalanceController {

	@Autowired
	private CompanyBalanceService companyBalanceService;
	@Autowired
	
	

	public CompanyBalanceService getCompanyBalanceService() {
		return companyBalanceService;
	}

	public void setCompanyBalanceService(
			CompanyBalanceService companyBalanceService) {
		this.companyBalanceService = companyBalanceService;
	}

	// 供应商资金账户信息列表
	@RequestMapping("findSupplierBalance")
	public String findCompanyBalance(Page page, HttpServletRequest request) {
		try {
			List<CompanyBalance> companyBalance = companyBalanceService.findSupplier(page);
			request.setAttribute("companyBalance", companyBalance);
			int rows = companyBalanceService.findSupplierRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/supplierBalanceList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 采购商资金账户信息列表
	@RequestMapping("findBuyerBalance")
	public String findBuyerBalance(Page page, HttpServletRequest request) {
		String json="";
		try {
			List<CompanyBalance> companyBalance = companyBalanceService
					.findBuyer(page);
			request.setAttribute("companyBalance", companyBalance);
			int rows = companyBalanceService.findBuyerRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Manager/companys/buyerBalanceList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到添加供应商资金账户页面
	@RequestMapping("toInsertSupplierBalance")
	public String toInsertSupplierBalance(HttpServletRequest request) {
		try {
			return "Manager/companys/addSupplierBalance";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到添加采购商资金账户页面
	@RequestMapping("toInsertBuyerBalance")
	public String toInsertBuyerBalance(HttpServletRequest request ,Model model) {
		try {
			
			return "Manager/companys/addBuyerBalance";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 增加供应商资金账户
	@RequestMapping("insertSupplierBalance")
	public String insertCompanyBalance(CompanyBalance companyBalance,
			HttpServletRequest request) {
		try {
			companyBalanceService.insert(companyBalance);
			return "redirect:findSupplierBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 增加采购商资金账户
	@RequestMapping("insertBuyerBalance")
	public String insertBuyerBalance(CompanyBalance companyBalance,
			HttpServletRequest request) {
		try {
			companyBalanceService.insert(companyBalance);
			return "redirect:findBuyerBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除供应商资金账户
	@RequestMapping("deleteSupplierBalance")
	public String deleteCompanyBalance(Integer id, HttpServletRequest request) {
		try {
			companyBalanceService.deleteCompanyBalance(id);
			return "redirect:findSupplierBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除采购商资金账户
	@RequestMapping("deleteBuyerBalance")
	public String deleteBuyerBalance(Integer id, HttpServletRequest request) {
		try {
			companyBalanceService.deleteCompanyBalance(id);
			return "redirect:findBuyerBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改供应商资金账户页面
	@RequestMapping("toUpdateSupplierBalance")
	public String toUpdateSupplierBalance(Integer id, HttpServletRequest request) {
		try {
			CompanyBalance companyBalance = companyBalanceService.findById(id);
			request.setAttribute("cb", companyBalance);
			return "Manager/companys/updateSupplierBalance";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改采购商资金账户页面
	@RequestMapping("toUpdateBuyerBalance")
	public String toUpdateBuyerBalance(Integer id, HttpServletRequest request) {
		try {
			CompanyBalance companyBalance = companyBalanceService.findById(id);
			request.setAttribute("cb", companyBalance);
			return "Manager/companys/updateBuyerBalance";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改供应商资金账户
	@RequestMapping("updateSupplierBalance")
	public String updateSupplierBalance(CompanyBalance companyBalance,
			HttpServletRequest request) {
		try {
			companyBalanceService.update(companyBalance);
			return "redirect:findSupplierBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改采购商资金账户
	@RequestMapping("updateBuyerBalance")
	public String updateBuyerBalance(CompanyBalance companyBalance,
			HttpServletRequest request) {
		try {
			companyBalanceService.update(companyBalance);
			return "redirect:findBuyerBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 批量删除
	@RequestMapping("/allDeleteBalance")
	public void allDeleteBalance(HttpServletRequest request, HttpServletResponse response) { 
		try {
		String sid = request.getParameter("Uid");
		companyBalanceService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	} 

	// 根据公司ID查询资金账户
	@RequestMapping("findBalanceById")
	public String findBalanceById(Integer id, HttpServletRequest request) {
		try {
			CompanyBalance companyBalance = companyBalanceService.findById(id);
			request.setAttribute("c", companyBalance);
			return "Manager/companys/companyBalanceInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 冻结采购商资金账户
	@RequestMapping("frozenBuyerBalance")
	public String frozenBuyerBalance(Integer id, HttpServletRequest request) {
		try {
			companyBalanceService.updateBalance(id);
			return "redirect:findBuyerBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 冻结供应商资金账户
	@RequestMapping("frozenSupplierBalance")
	public String frozenSupplierBalance(Integer id, HttpServletRequest request) {
		try {
			companyBalanceService.updateBalance(id);
			return "redirect:findSupplierBalance.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
