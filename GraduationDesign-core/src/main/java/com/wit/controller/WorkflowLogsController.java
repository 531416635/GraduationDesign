package com.wit.controller;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Page;
import com.wit.model.WorkflowLogs;
import com.wit.service.WorkflowLogsService;

/**
 * 流程日志
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/WorkflowLogs")
public class WorkflowLogsController {
	@Resource
	private WorkflowLogsService workflowLogsService;
	
	@RequestMapping("/getAllWorkflowLogs")
	public String linkWorkflowLogs(Page page, Model model) {
		String json="";
		// 查询所有数据
		List<WorkflowLogs> list = workflowLogsService.getAll(page);
		model.addAttribute("dispatch", list);
		int rows = workflowLogsService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/Workflows/workflowLogsList";
	}
	
	
	

		
		
}
