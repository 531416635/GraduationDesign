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
import com.wit.model.Workflows;
import com.wit.service.WorkflowsService;
/**
 * 用户流程
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/Workflows")
public class WorkflowsController {
	@Resource
	private WorkflowsService workflowsService;

	@RequestMapping("/getAllWorkflows")
	public String linkWorkflows(Page page, Model model) {
		String json="";
		// 查询所有数据
		List<Workflows> list = workflowsService.getAll(page);
		model.addAttribute("dispatch", list);
		int rows = workflowsService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/Workflows/workflowsList";
	}

	// 删除一条记录
	@RequestMapping("/deleteWorkflows")
	public String delete(Workflows workflows) {
		Integer id = workflows.getId();
		if (id != null) {
			workflowsService.delete(id);
		}
		return "redirect:getAllWorkflows.do";
	}

	// 跳转到添加界面
	@RequestMapping("/toWorkflowsAdd")
	public String toAdd() {
		return "Manager/Workflows/workflowsListAdd";
	}

	// 添加
	@RequestMapping("/addWorkflowsList")
	public String add(Workflows workflows) {
		workflowsService.add(workflows);
		return "redirect:getAllWorkflows.do";
	}

	// 跳转到修改界面
	@RequestMapping("/toWorkflowsUpdate")
	public String toUpdate(Integer id, Model model) {
		Workflows workflows = workflowsService.findById(id);
		model.addAttribute("workflows", workflows);
		return "Manager/Workflows/workflowsListUpdate";
	}

	// 修改
	@RequestMapping("/updateWorkflowsList")
	public String update(Workflows workflows) {
		workflowsService.update(workflows);
		return "redirect:getAllWorkflows.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteWorkflows")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");

		for (int i = 0; i < item.length; i++) {
			workflowsService.delete(Integer.parseInt(item[i]));
		}
	}
}
