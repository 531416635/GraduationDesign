package com.wit.controller;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Page;
import com.wit.model.SystemLogs;
import com.wit.service.SystemLogsService;

/**
 * 系统日志
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/main")
public class SystemLogsController extends BaseController{
	@Resource
	private SystemLogsService systemLogsService;
	
	@RequestMapping("/SystemLogs")
	public String linkOrders(Page page,Model model){
		try{String json="";
		//查询所有数据
		List<SystemLogs> list = systemLogsService.getAll(page);
		model.addAttribute("dispatch",list);
		int rows = systemLogsService.findRows();
		page.setRows(rows);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return"Manager/systemLogs/SystemLogsList";
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		
		
	}
	
}
