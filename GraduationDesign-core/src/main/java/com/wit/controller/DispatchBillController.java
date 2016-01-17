package com.wit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.DispatchBill;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.DispatchBillService;

/**
 * 
 * @author ljj time: 2013-3-22
 * 
 */
/* 发货单管理 */
@Controller
@RequestMapping("/supplys")
public class DispatchBillController {
	@Resource
	private DispatchBillService dispatchBillService;
	String json="";
	// 查询数据
	@RequestMapping("/supply")
	public String linkSupply(HttpServletRequest request, Model model, Page page) {

		// 从数据库查询所有数据
		List<DispatchBill> list = dispatchBillService.findAll(page);
		HttpSession session = request.getSession();
		session.setAttribute("dispatch", list);
		int rows = dispatchBillService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/supplys/dispatchBillList";
	}

	// 跳转到增加页面
	@RequestMapping("/toSupplyAdd")
	public String toSupplyAdd(Model model) {
		List<Integer> orderList = dispatchBillService.findOrdersId();
		List<Integer> storageList = dispatchBillService.findStorageId();
		model.addAttribute("ordersId", orderList);
		model.addAttribute("storageIds", storageList);
		return "Manager/supplys/dispatchBillListAdd";
	}

	// 增加数据
	@RequestMapping("/supplyAdd")
	public String SupplyAdd(DispatchBill db) {
		dispatchBillService.insertData(db);
		return "redirect:supply.do";
	}

	// 跳转到修改页面
	@RequestMapping("/toSupplyUpdate")
	public String toSupplyUpdate(HttpServletRequest request, Model model) {
		String eid = request.getParameter("id");
		DispatchBill dbl = dispatchBillService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		List<Integer> orderList = dispatchBillService.findOrdersId();
		List<Integer> storageList = dispatchBillService.findStorageId();
		model.addAttribute("ordersIdU", orderList);
		model.addAttribute("storageIdsU", storageList);
		return "Manager/supplys/dispatchBillListUpdate";
	}

	// 修改数据
	@RequestMapping("/supplyUpdate")
	public String SupplyUpdate(DispatchBill db) {
		dispatchBillService.updateById(db);
		return "redirect:supply.do";
	}

	// 删除数据
	@RequestMapping("supplyDelete")
	public String SupplyDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if (id != null) {
			dispatchBillService.deleteById(Integer.parseInt(id));
		}
		return "redirect:supply.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteDis")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		for (int i = 0; i < item.length; i++) {
			dispatchBillService.deleteById(Integer.parseInt(item[i]));
		}
	}

	// 根据用户ID显示发货单信息
	@RequestMapping("dispatchBillList")
	public String dispatchBillList(Page page, HttpServletRequest request) {
		try {
			// 获取用户登录信息
			Users user = (Users) request.getSession().getAttribute("userInfo");
			// 获取用户ID
			int userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			int rows = dispatchBillService.rows(userId);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			request.setAttribute("page", page);
			return "Purchaser/dispatchBillList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
