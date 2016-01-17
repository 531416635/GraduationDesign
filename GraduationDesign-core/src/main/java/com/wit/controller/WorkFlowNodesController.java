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
import com.wit.model.WorkflowNodes;
import com.wit.service.WorkFlowNodesService;
/**
 * 流程节点
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/WorkFlowNodes")
public class WorkFlowNodesController {
	@Resource
	private WorkFlowNodesService workFlowNodesService;

	@RequestMapping("/getAllWorkFlowNodes")
	public String linkWorkflows(Page page, Model model) {
		String json="";
		// 查询所有数据
		List<WorkflowNodes> list = workFlowNodesService.getAll(page);
		model.addAttribute("dispatch", list);
		int rows = workFlowNodesService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/Workflows/workFlowNodesList";
	}

	// 删除一条记录
	@RequestMapping("/deleteWorkFlowNodes")
	public String delete(WorkflowNodes workFlowNodes) {
		Integer id = workFlowNodes.getId();
		if (id != null) {
			workFlowNodesService.delete(id);
		}
		return "redirect:getAllWorkFlowNodes.do";
	}

	// 跳转到添加界面
	@RequestMapping("/toWorkFlowNodesAdd")
	public String toAdd() {
		return "Manager/Workflows/workFlowNodesListAdd";
	}

	// 添加
	@RequestMapping("/addWorkFlowNodesList")
	public String add(WorkflowNodes workFlowNodes) {
		workFlowNodesService.add(workFlowNodes);
		return "redirect:getAllWorkFlowNodes.do";
	}

	// 跳转到修改界面
	@RequestMapping("/toWorkFlowNodesUpdate")
	public String toUpdate(Integer id, Model model) {
		WorkflowNodes workFlowNodes = workFlowNodesService.findById(id);
		model.addAttribute("workFlowNodes", workFlowNodes);
		return "Manager/Workflows/workFlowNodesListUpdate";
	}

	// 修改
	@RequestMapping("/updateWorkFlowNodesList")
	public String update(WorkflowNodes workFlowNodes) {
		workFlowNodesService.update(workFlowNodes);
		return "redirect:getAllWorkFlowNodes.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteWorkFlowNodes")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");

		for (int i = 0; i < item.length; i++) {
			workFlowNodesService.delete(Integer.parseInt(item[i]));
		}
	}
}
