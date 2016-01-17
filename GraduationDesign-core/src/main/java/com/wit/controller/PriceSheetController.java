package com.wit.controller;

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

import com.wit.model.Page;
import com.wit.model.PriceSheet;
import com.wit.model.Users;
import com.wit.service.PriceSheetService;

/**
 * 报价单控制器
 * 
 * @author lj
 * 
 */
@Controller
@RequestMapping("/main")
public class PriceSheetController extends BaseController {
	@Resource
	private PriceSheetService priceSheetService;

	@RequestMapping("/PriceSheet")
	public String linkPriceSheet(Page page, Model model) {
		String json="";
		try {
		// 查询所有数据
		List<PriceSheet> list = priceSheetService.getAll(page);
		model.addAttribute("dispatch", list);
		int rows = priceSheetService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/supplys/PriceSheetList";
		
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 删除一条记录
	@RequestMapping("/deletePriceSheet")
	public String delete(PriceSheet priceSheet) {
		Integer id = priceSheet.getId();
		if (id != null) {
			priceSheetService.delete(id);
		}
		return "redirect:PriceSheet.do";
	}

	// 跳转到添加界面
	@RequestMapping("/toPriceSheetListAdd")
	public String toAdd() {
		return "Manager/supplys/PriceSheetListAdd";
	}

	// 添加
	@RequestMapping("/addPriceSheetList")
	public String add(PriceSheet priceSheet) {
		System.out.println("123");
		priceSheetService.add(priceSheet);
		return "redirect:PriceSheet.do";
	}

	// 跳转到修改界面
	@RequestMapping("/toPriceSheetListUpdate")
	public String toUpdate(Integer id, Model model) {
		PriceSheet priceSheet = priceSheetService.findById(id);
		System.out.println(priceSheet);
		model.addAttribute("priceSheet", priceSheet);
		return "Manager/supplys/PriceSheetListUpdate";
	}

	// 修改
	@RequestMapping("/updatePriceSheetList")
	public String update(PriceSheet priceSheet) {
		System.out.println("123");
		priceSheetService.update(priceSheet);
		System.out.println("456");
		return "redirect:PriceSheet.do";
	}

	// 批量删除
	@RequestMapping("/allDeletePriceSheet")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		System.out.println("123");
		for (int i = 0; i < item.length; i++) {
			priceSheetService.delete(Integer.parseInt(item[i]));
		}
	}

	// 列表分页显示询价单的数据
	@RequestMapping("priceSheetList")
	public String priceSheetList(Page page, HttpServletRequest request) {
		try {
			// 获取登录User的信息
			Users user = (Users) request.getSession().getAttribute("userInfo");
			// 获取用户ID
			int userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<PriceSheet> priceSheet = priceSheetService.findAll(parm);
			request.setAttribute("priceSheet", priceSheet);
			request.setAttribute("userId", userId);
			int rows = priceSheetService.rows(userId);
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Purchaser/priceSheetList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
