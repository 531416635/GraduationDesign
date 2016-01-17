package com.wit.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Invoice;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.InvoiceService;

/**
 * 
 * @author ljj time: 2013-3-22
 * 
 */
/* 供应商后台和采购商后台----> 发票管理 */
@Controller
@RequestMapping("/supplys")
public class InvoiceController extends BaseController {
	@Resource
	private InvoiceService invoiceService;

/*	// 查询数据
	@RequestMapping("/invoice")
	public String linkInvoice(HttpServletRequest request, Model model, Page page) {

		// 从数据库查询所有数据
		List<Invoice> list =null;// invoiceService.findAll(page);
		HttpSession session = request.getSession();
		session.setAttribute("invoices", list);
		int rows = invoiceService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		return "supplys/invoiceList";
	}*/

/*	// 跳转到增加页面
	@RequestMapping("/toInvoiceAdd")
	public String toInvoiceAdd(Model model) {
		return "supplys/invoiceListAdd";
	}

	// 增加数据
	@RequestMapping("/invoiceAdd")
	public String InvoiceAdd(Invoice db) {
		invoiceService.insert(db);
		return "redirect:invoice.do";
	}*/

	// 跳转到修改数据
	@RequestMapping("/toInvoiceUpdate")
	public String toInvoiceUpdate(HttpServletRequest request, Model model) {
		String eid = request.getParameter("id");
		Invoice dbl = invoiceService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		return "supplys/invoiceListUpdate";
	}

	// 修改数据
	@RequestMapping("/invoiceUpdate")
	public String InvoiceUpdate(Invoice db) {
		invoiceService.update(db);
		return "redirect:invoice.do";
	}

	// 删除数据
	@RequestMapping("invoiceDelete")
	public String InvoiceDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if (id != null) {
			invoiceService.deleteById(Integer.parseInt(id));
		}
		return "redirect:invoice.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteInvoice")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		for (int i = 0; i < item.length; i++) {
			invoiceService.deleteById(Integer.parseInt(item[i]));
		}
	}

	// 显示发票列表
	@RequestMapping("invoiceList")
	public String invoiceList(Page page, HttpServletRequest request) {
		String json="";
		try {
			// 获取用户登录信息
			Users user = (Users) request.getSession().getAttribute("userInfo");
			// 获取用户ID
			int userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<Map<String,Object>> invoice = invoiceService.findAll(page);
			int rows = invoiceService.rows();
			page.setRows(rows);
			request.setAttribute("invoice", invoice);
			request.setAttribute("userId", userId);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Purchaser/invoiceList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//到申请发票页面
	@RequestMapping("toInvoiceAdd")
	public String toInvoiceAdd(BigDecimal tmpSettledAmount,Integer tmpCompanyId,Integer tmpStatementId,HttpServletRequest request){
		try {
			List<Invoice> invoice = invoiceService.findByCompanyId(tmpCompanyId);
			request.setAttribute("invoice", invoice);
			request.setAttribute("tmpSettledAmount", tmpSettledAmount);
			request.setAttribute("tmpCompanyId", tmpCompanyId);
			request.setAttribute("tmpStatementId", tmpStatementId);
			return "Manager/supplys/invoiceListAdd";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	//平台向供应商申请发票
	@RequestMapping("invoiceAdd")
	public String invoiceAdd(Integer tmpInvoiceType,String tmpInvoiceTitle,BigDecimal tmpAmount,String tmpCompanyId,Integer tmpStatementId,HttpServletRequest request){
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("tmpInvoiceType",tmpInvoiceType);
			parm.put("tmpInvoiceTitle",java.net.URLDecoder.decode(tmpInvoiceTitle,"UTF-8"));
			parm.put("tmpAmount",tmpAmount);
			parm.put("tmpCompanyId",tmpCompanyId);
			parm.put("tmpStatementId",tmpStatementId);
			invoiceService.buyerInvoiceApply(parm);
			return "redirect:../findCompanyBalanceStatement.do?companyId="+tmpCompanyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//平台向采购商寄出发票
	@RequestMapping("purchaserInvoiceSend")
	public String purchaserInvoiceSend(Integer tmpStatementId,Integer companyId,HttpServletRequest request){
		try {
			invoiceService.updateInvoiceStatus(tmpStatementId);
			return "redirect:../findCompanyBalanceStatement.do?companyId="+companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//平台签收供应商寄出的发票
	@RequestMapping("invoiceSign")
	public String invoiceSign(Integer tmpStatementId,Integer companyId,HttpServletRequest request){
		try {
			invoiceService.signInvoice(tmpStatementId);
			return "redirect:../findCompanyBalanceStatement.do?companyId="+companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//系统后台添加发票抬头
	@RequestMapping("sysAddTitle")
	public String sysAddTitle(HttpServletRequest request,Integer companyId,String title){
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("invoiceTitle", java.net.URLDecoder.decode(title,"UTF-8"));
			invoiceService.addTitle(parm);
			return "redirect:/findCompanyBalanceStatement.do?companyId="+companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
