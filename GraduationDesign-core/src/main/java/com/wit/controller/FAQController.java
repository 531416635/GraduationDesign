package com.wit.controller;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.FAQ;
import com.wit.model.Page;
import com.wit.model.QuestionType;
import com.wit.model.Users;
import com.wit.service.FAQService;
import com.wit.service.QuestionTypeService;

@Controller
@RequestMapping("/FAQ")
public class FAQController {
	@Resource
	private FAQService faqService;
	@Autowired
    private QuestionTypeService questionTypeService;
	// 跳转到增加页面
	@RequestMapping("/toFAQAdd")
	public String toSupplyAdd(HttpServletRequest request,Model model) {
		Users user = (Users) request.getSession().getAttribute("userInfo");
		List<QuestionType> questionType=questionTypeService.getAll();
		model.addAttribute("questionType", questionType);
		model.addAttribute("user", user);
		return "Manager/FAQ/FAQAdd";
	}

	// 增加数据
	@RequestMapping("/FAQAdd")
	public String SupplyAdd(FAQ db) {
		faqService.insertData(db);
		return "redirect:FAQList.do";
	}

	// 跳转到修改页面
	@RequestMapping("/toFAQUpdate")
	public String toSupplyUpdate(HttpServletRequest request, Model model) {
		String eid = request.getParameter("id");
		List<QuestionType> questionType=questionTypeService.getAll();
		FAQ dbl = faqService.findById(Integer.parseInt(eid));
		model.addAttribute("FAQ", dbl);
		model.addAttribute("questionType", questionType);
		return "Manager/FAQ/FAQUpdate";
	}

	// 修改数据
	@RequestMapping("/FAQUpdate")
	public String SupplyUpdate(FAQ db) {
		faqService.updateById(db);
		return "redirect:FAQList.do";
	}

	// 删除数据
	@RequestMapping("FAQDelete")
	public String SupplyDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if (id != null) {
			faqService.deleteById(Integer.parseInt(id));
		}
		return "redirect:FAQList.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteIds")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");

		faqService.deleteByIds(sid);

	}

	//后台列表展示
	@RequestMapping("FAQList")
	public String FAQList(Page page, HttpServletRequest request) {
		String json="";
		try {
			List<FAQ> FAQ = faqService.findAll(page);
			List<QuestionType> questionType=questionTypeService.getAll();
			int rows = faqService.findRows();
			page.setRows(rows);
			request.setAttribute("FAQ", FAQ);
			request.setAttribute("questionType", questionType);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Manager/FAQ/FAQList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//后台详情展示
	@RequestMapping("FAQInfo")
	public String FAQInfo(Page page, HttpServletRequest request) {
		String id=request.getParameter("id");
		try {
			List<QuestionType> questionType=questionTypeService.getAll();
			FAQ dbl = faqService.findById(Integer.parseInt(id));
			request.setAttribute("FAQ", dbl);
			request.setAttribute("questionType", questionType);
			return "Manager/FAQ/FAQInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
