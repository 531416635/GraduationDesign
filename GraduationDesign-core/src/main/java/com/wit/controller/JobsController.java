package com.wit.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Jobs;
import com.wit.model.Page;
import com.wit.service.JobsService;
/**
 * 
 * @author ljj
 * time:  2013-3-22   
 *
 */
/*   岗位管理     */
@Controller
@RequestMapping("/users")
public class JobsController extends BaseController{
	@Resource
	private JobsService jobsService;
	
	//查询数据
	@RequestMapping("/jobs")
	public String linkJob(HttpServletRequest request,Model model,Page page){
		String json="";
		//从数据库查询所有数据
		List<Jobs> list = jobsService.findAll(page);
		HttpSession session = request.getSession();
		session.setAttribute("jobs", list);
		 int rows = jobsService.findRows();
	     page.setRows(rows);
		 model.addAttribute("page", page);
		 json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
		return "Manager/users/jobsList";
	}
	//跳转到增加页面
	@RequestMapping("/toJobAdd")
	public String toJobAdd(Model model){
		List<Integer> list = jobsService.findDeptId();
		model.addAttribute("depart", list);
		return "Manager/users/jobsListAdd";
	}
	//增加数据
	@RequestMapping("/jobAdd")
	public String JobAdd(Jobs db){
		jobsService.insertJob(db);
		return "redirect:jobs.do";
	}
	//跳转到修改页面
	@RequestMapping("/toJobUpdate")
	public String toJobUpdate(HttpServletRequest request,Model model){
		String eid = request.getParameter("id");
		Jobs dbl = jobsService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		List<Integer> list = jobsService.findDeptId();
		model.addAttribute("departs", list);
		return "Manager/users/jobsListUpdate";
	}
	//修改页面
	@RequestMapping("/jobUpdate")
	public String JobUpdate(Jobs db){
		jobsService.updateJob(db);
		return "redirect:jobs.do";
	}
	
	//删除数据
	@RequestMapping("jobDelete")
	public String JobDelete(HttpServletRequest request){
		//通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if(id != null){
			jobsService.deleteJob(Integer.parseInt(id));
		}
		return "redirect:jobs.do";
	}
	
	//批量删除
	@RequestMapping("/allDeleteJ") 
	public void deleteMore(HttpServletRequest request, HttpServletResponse response) { 
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@"); 
		for (int i = 0; i < item.length; i++) { 
			jobsService.deleteJob(Integer.parseInt(item[i])); 
		} 
	} 
	
	//查询岗位名称
	@RequestMapping("findJobName")
	public String findJobName(Integer id,HttpServletRequest request){
		try {
			List<Jobs> jobs = jobsService.findByDeptId(id);
			request.setAttribute("jobs", jobs);
			return "Manager/companys/jobList";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	
	
}
