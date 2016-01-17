package com.wit.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Page;
import com.wit.model.WorkflowType;
import com.wit.service.WorkflowTypeService;



/**
 * 流程类型
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/WorkflowType")
public class WorkflowTypeController extends BaseController{
	@Resource
	private WorkflowTypeService workflowTypeService;
	
	@RequestMapping("/getAllWorkflowType")
	public String linkWorkflowType(Page page, Model model) {
		String json="";
		// 查询所有数据
		List<WorkflowType> list = workflowTypeService.getAll(page);
		model.addAttribute("dispatch", list);
		
		int rows = workflowTypeService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/Workflows/workflowTypeList";
	}
	
	// 删除一条记录
	@RequestMapping("/deleteWorkflowType")
	public String delete(WorkflowType workflowType) {
		Integer id = workflowType.getId();
		if (id != null) {
			workflowTypeService.delete(id);
		}
		return "redirect:getAllWorkflowType.do";
	}
	
	// 跳转到添加界面
	@RequestMapping("/toWorkflowTypeAdd")
	public String toAdd() {
		return "Manager/Workflows/workflowTypeListAdd";
	}
	
	// 添加
	@RequestMapping("/addWorkflowTypeList")
	public String add(WorkflowType workflowType) {
		workflowTypeService.add(workflowType);
		return "redirect:getAllWorkflowType.do";
	}
	
	// 跳转到修改界面
	@RequestMapping("/toWorkflowTypeUpdate")
	public String toUpdate(Integer id, Model model) {
		WorkflowType workflowType = workflowTypeService.findById(id);
		model.addAttribute("workflowType", workflowType);
		return "Manager/Workflows/workflowTypeListUpdate";
	}
	
	// 修改
	@RequestMapping("/updateWorkflowTypeList")
	public String update(WorkflowType workflowType) {
		workflowTypeService.update(workflowType);
		return "redirect:getAllWorkflowType.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteWorkflowType")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");

		for (int i = 0; i < item.length; i++) {
			workflowTypeService.delete(Integer.parseInt(item[i]));
		}
	}
	
	
}
