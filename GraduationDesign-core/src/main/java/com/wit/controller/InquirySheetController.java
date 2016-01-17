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

import com.wit.model.InquirySheet;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.InquirySheetService;

/**
 * 询价单控制器
 * 
 * @author lj
 * 
 */
@Controller
@RequestMapping("/main")
public class InquirySheetController extends BaseController {
	@Resource
	private InquirySheetService inquirySheetService;

	// 从数据库查询所有数据
	@RequestMapping("/inquiry")
	public String linkInquiry(Page page, Model model) {
		String json="";
		try {
			
			System.out.println("^^^^^^^^^^^^^^^^^^开始^^^^^^^^^^^^^^^^^^^");
			List<InquirySheet> list = inquirySheetService.getAll(page);
			model.addAttribute("dispatch", list);
			int rows = inquirySheetService.findRows();
			page.setRows(rows);
			model.addAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/supplys/InquiryList";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 通过获取ID来删除一条数据
	@RequestMapping("/deleteInquirySheet")
	public String delete(InquirySheet inquirySheet) {
		try {
			Integer id = inquirySheet.getId();
			if (id != null) {
				inquirySheetService.delete(id);
			}
			// 重定向
			return "redirect:inquiry.do";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 跳转到添加界面
	@RequestMapping("/toInquiryListAdd")
	public String toAdd(HttpServletRequest request) {
		try {
			return "Manager/supplys/InquiryListAdd";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 添加
	@RequestMapping("/addInquiryList")
	public String add(InquirySheet inquirySheet) {
		try {
			System.out.println("123");
			inquirySheetService.add(inquirySheet);
			return "redirect:inquiry.do";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 跳转到修改界面
	@RequestMapping("/toInquiryListUpdate")
	public String toUpdate(Integer id, Model model) {
		try {
			InquirySheet inquirySheet = inquirySheetService.findById(id);
			System.out.println(inquirySheet);
			model.addAttribute("inquirySheet", inquirySheet);
			return "Manager/supplys/InquiryListUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 修改
	@RequestMapping("/updateInquiryList")
	public String update(InquirySheet inquirySheet) {
		try {
			inquirySheetService.update(inquirySheet);
			return "redirect:inquiry.do";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 批量删除
	@RequestMapping("/allDeleteInquiry")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			String[] item = sid.split("@");
			for (int i = 0; i < item.length; i++) {
				inquirySheetService.delete(Integer.parseInt(item[i]));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//列表分页显示询价单的数据
	@RequestMapping("/inquirySheetList")
	public String InquirySheetList(Page page,HttpServletRequest request){
		try {
			//获取登录User的信息
			Users user = (Users) request.getSession().getAttribute("userInfo");
			//获取用户ID
			int userId = user.getId();
			Map<String,Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<InquirySheet> inquirySheet = inquirySheetService.findAll(parm);
			request.setAttribute("inquirySheet", inquirySheet);
			request.setAttribute("userId", userId);
			int rows = inquirySheetService.rows(userId);
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Purchaser/inquirySheetList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}











