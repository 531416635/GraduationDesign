package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyBankAccount;
import com.wit.model.Page;
import com.wit.service.CompanyBankAccountService;

/**
 * 与供应商银行账号相关的控制
 * 
 * @author tangxiaoqing
 * 
 */
@Controller
public class CompanyBankAccountController extends BaseController {

	@Autowired
	private CompanyBankAccountService companyBankAccountService;

	// 显示供应商银行账户信息
	@RequestMapping("findSupplierBankAccount")
	public String findSupplierBankAccount(Page page, HttpServletRequest request) {
		try {
			List<CompanyBankAccount> companyBankAccount = companyBankAccountService
					.findSupplierBankAccount(page);
			request.setAttribute("companyBankAccount", companyBankAccount);
			int rows = companyBankAccountService.findSupplierRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/supplierBankAccountList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示采购商银行账户信息
	@RequestMapping("findBuyerBankAccount")
	public String findBuyerBankAccount(Page page, HttpServletRequest request) {
		String json="";
		try {
			List<CompanyBankAccount> companyBankAccount = companyBankAccountService
					.findBuyerBankAccount(page);
			request.setAttribute("companyBankAccount", companyBankAccount);
			int rows = companyBankAccountService.findBuyerRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Manager/companys/buyerBankAccountList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转添加供应商银行账户页面
	@RequestMapping("toAddSupplierBankAccount")
	public String toAddSupplierBankAccount(HttpServletRequest request) {
		try {
			return "Manager/companys/addSupplierBankAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转添加采购商银行账户页面
	@RequestMapping("toAddBuyerBankAccount")
	public String toAddBuyerBankAccount(HttpServletRequest request) {
		try {
			return "Manager/companys/addBuyerBankAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

/*	// 增加供应商银行账户
	@RequestMapping("addSupplierBankAccount")
	public String AddCompanyBankAccount(CompanyBankAccount companyBankAccount,
			HttpServletRequest request) {
		try {
			companyBankAccountService
					.savaCompanyBankAccount(companyBankAccount);
			return "redirect:findSupplierBankAccount.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
*/
/*	// 增加采购商银行账户
	@RequestMapping("addBuyerBankAccount")
	public String addBuyerBankAccount(CompanyBankAccount companyBankAccount,
			HttpServletRequest request) {
		try {
			companyBankAccountService
					.savaCompanyBankAccount(companyBankAccount);
			return "redirect:findBuyerBankAccount.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
*/
	// 删除供应商银行账户
	@RequestMapping("deleteSupplierBankAccount")
	public String deleteCompanyBankAccount(Integer id,
			HttpServletRequest request) {
		try {
			companyBankAccountService.deleteCompanyBankAccount(id);
			return "redirect:findSupplierBankAccount.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除采购商银行账户
	@RequestMapping("deleteBuyerBankAccount")
	public String deleteBuyerBankAccount(Integer id, HttpServletRequest request) {
		try {
			companyBankAccountService.deleteCompanyBankAccount(id);
			return "redirect:findBuyerBankAccount.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改供应商银行信息页面
	@RequestMapping("toUpdateSupplierBankAccount")
	public String toUpdateSupplierBankAccount(Integer id,
			HttpServletRequest request) {
		try {
			CompanyBankAccount companyBankAccount = companyBankAccountService
					.findById(id);
			request.setAttribute("cc", companyBankAccount);
			return "Manager/companys/updateSupplierBankAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改采购商银行信息页面
	@RequestMapping("toUpdateBuyerBankAccount")
	public String toUpdateBuyerBankAccount(Integer id,
			HttpServletRequest request) {
		try {
			CompanyBankAccount companyBankAccount = companyBankAccountService
					.findById(id);
			request.setAttribute("cc", companyBankAccount);
			return "Manager/companys/updateBuyerBankAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改供应商银行账户
	@RequestMapping("updateSupplierBankAccount")
	public String updateSupplierBankAccount(
			CompanyBankAccount companyBankAccount, HttpServletRequest request) {
		try {
			companyBankAccountService
					.updateCompanyBankAccount(companyBankAccount);
			return "redirect:findSupplierBankAccount.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改采购商银行账户
	@RequestMapping("updateBuyerBankAccount")
	public String updateBuyerBankAccount(CompanyBankAccount companyBankAccount,
			HttpServletRequest request) {
		try {
			companyBankAccountService
					.updateCompanyBankAccount(companyBankAccount);
			return "redirect:findBuyerBankAccount.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 批量删除
	@RequestMapping("/allDeleteBankAccount")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		for (int i = 0; i < item.length; i++) {
			companyBankAccountService.deleteCompanyBankAccount(Integer
					.parseInt(item[i]));
		}
	}
	

}
