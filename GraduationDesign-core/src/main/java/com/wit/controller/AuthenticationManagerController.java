package com.wit.controller;

/**
 * 与认证管理相关的控制
 * @author tangxiaoqing
 */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.AuthenticationManager;
import com.wit.model.Companys;
import com.wit.model.Page;
import com.wit.service.AuthenticationManagerService;
import com.wit.service.CompanysService;

@Controller
public class AuthenticationManagerController extends BaseController {
	@Autowired
	private CompanysService companysService;

	@Autowired
	private AuthenticationManagerService authenticationManagerService;

	// 显示供应商认证基本信息
	@RequestMapping("supplierAuthentication")
	public String supplierAuthentication(Page page, HttpServletRequest request) {
		try {
			List<Companys> companys = companysService.findSupplier(page);
			request.setAttribute("companys", companys);
			int rows = companysService.findSupplierRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/supplierAuthenticationList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示采购商认证基本信息
	@RequestMapping("buyerAuthentication")
	public String buyerAuthentication(Page page, HttpServletRequest request) {
		String json="";
		try {
			List<Companys> companys = companysService.findBuyer(page);
			request.setAttribute("companys", companys);
			int rows = companysService.findBuyerRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Manager/companys/buyerAuthenticationList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示供应商认证资料
	@RequestMapping("supplierAuthenticationInfo")
	public String supplierAuthenticationInfo(Integer companyId,Page page, HttpServletRequest request) {
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("page", page);
			List<AuthenticationManager> au = authenticationManagerService
					.findByCompanyId(parm);
			request.setAttribute("au",au);
			request.setAttribute("companyId", companyId);
			System.out.println(companyId);
			int rows = authenticationManagerService.rows(companyId);
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/supplierAuthenticationInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	// 显示采购商认证资料
		@RequestMapping("buyerAuthenticationInfo")
		public String buyerAuthenticationInfo(Integer companyId,Page page, HttpServletRequest request) {
			try {
				Map<String,Object> parm = new HashMap<>();
				parm.put("companyId", companyId);
				parm.put("page", page);
				System.out.println(companyId);
				List<AuthenticationManager> au = authenticationManagerService
						.findByCompanyId(parm);
				System.out.println(au);
				request.setAttribute("au",au);
				request.setAttribute("companyId", companyId);
				int rows = authenticationManagerService.rows(companyId);
				page.setRows(rows);
				request.setAttribute("page", page);
				System.out.println(companyId);
				return "Manager/companys/buyerAuthenticationInfo";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("InfoMessage",
						"信息载入失败！具体异常信息：" + e.getMessage());
				return "error";
			}
		}

	// 跳转到添加供应商认证信息页面
	@RequestMapping("toAddSupplierAuthentication")
	public String toAddSupplierAuthentication(HttpServletRequest request,Integer companyId) {
		try {
			System.out.println(companyId);
			request.setAttribute("companyId", companyId);
			return "Manager/companys/addSupplierAuthentication";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	//跳转到添加采购商认证信息页面
	@RequestMapping("toAddBuyerAuthentication")
	public String toAddBuyerAuthentication(HttpServletRequest request,Integer companyId) {
		try {
			request.setAttribute("companyId", companyId);
			System.out.println(companyId);
			return "Manager/companys/addBuyerAuthentication";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 添加供应商认证信息
	@RequestMapping("addSupplierAuthentication")
	public String addSupplierAuthentication(
			AuthenticationManager authenticationManager,
			HttpServletRequest request) {
		try {
			authenticationManagerService.insert(authenticationManager);
			int companyId = authenticationManager.getCompanyId();
			System.out.println(companyId);
			return "redirect:supplierAuthenticationInfo.do?companyId="+companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 添加采购商认证信息
	@RequestMapping("addBuyerAuthentication")
	public String addBuyerAuthentication(
			AuthenticationManager authenticationManager,
			HttpServletRequest request) {
		try {
			authenticationManagerService.insert(authenticationManager);
			System.out.println(authenticationManager.getCompanyId());
			return "redirect:buyerAuthenticationInfo.do?companyId="+authenticationManager.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改供应商认证信息页面
	@RequestMapping("toUpdateSupplierAuthentication")
	public String toUpdateSupplierAuthentication(Integer id,
			HttpServletRequest request) {
		System.out.println(id);
		try {
			AuthenticationManager authenticationManager = authenticationManagerService
					.findById(id);
			System.out.println(authenticationManager);
			request.setAttribute("supplier", authenticationManager);
			return "Manager/companys/updateSupplierAuthentication";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改采购商认证信息页面
	@RequestMapping("toUpdateBuyerAuthentication")
	public String toUpdateBuyerAuthentication(Integer id,
			HttpServletRequest request) {
		try {
			AuthenticationManager authenticationManager = authenticationManagerService
					.findById(id);
			request.setAttribute("buyer", authenticationManager);
			return "Manager/companys/updateBuyerAuthentication";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改供应商认证信息
	@RequestMapping("updateSupplierAuthentication")
	public String updateSupplierAuthentication(
			AuthenticationManager authenticationManager,
			HttpServletRequest request) {
		try {
			authenticationManagerService.update(authenticationManager);
			return "redirect:supplierAuthenticationInfo.do?companyId="+authenticationManager.getCompanyId()
			;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改采购商认证信息
	@RequestMapping("updateBuyerAuthentication")
	public String updateBuyerAuthentication(
			AuthenticationManager authenticationManager,
			HttpServletRequest request) {
		try {
			authenticationManagerService.update(authenticationManager);
			System.out.println(authenticationManager.getCompanyId());
			return "redirect:buyerAuthenticationInfo.do?companyId="+authenticationManager.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除供应商认证信息
	@RequestMapping("deleteSupplierAuthentication")
	public String deleteSupplierAuthentication(Integer id,AuthenticationManager authenticationManager,
			HttpServletRequest request) {
		try {
			authenticationManagerService.delete(id);
			return "redirect:supplierAuthenticationInfo.do?companyId="+authenticationManager.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除采购商认证信息
	@RequestMapping("deleteBuyerAuthentication")
	public String deleteBuyerAuthentication(Integer id,AuthenticationManager authenticationManager,
			HttpServletRequest request) {
		try {
			authenticationManagerService.delete(id);
			return "redirect:buyerAuthenticationInfo.do?companyId="+authenticationManager.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 批量删除
	@RequestMapping("/deleteAuthenticationInfo")
	public void allDelete(HttpServletRequest request, HttpServletResponse response) { 
		try {
		String sid = request.getParameter("Uid");
		authenticationManagerService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());		
		}
	} 
	
	//商户认证
	@RequestMapping("merchantAuthentication")
	public String merchantAuthentication(Integer tmpCompanyId,HttpServletRequest request){
		try {
			//修改状态为认证，同时自己生成资金账户，改用户状态为可用
			authenticationManagerService.merchantAuthentication(tmpCompanyId);
			return "redirect:buyerAuthentication.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		
	}
}
