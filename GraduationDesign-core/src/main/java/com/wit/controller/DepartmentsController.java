package com.wit.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Departments;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.DepartmentsService;

/*  部门管理            */
@Controller
@RequestMapping("users")
public class DepartmentsController extends BaseController {
	@Resource
	private DepartmentsService departmentsService;

	// 查询所有数据
	@RequestMapping("/departments")
	public String linkDepartments(Model model, Page page) {

		String json = "";
		List<Map<String, Object>> list = departmentsService.findAll(page);
		model.addAttribute("departments", list);
		int rows = departmentsService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json = JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);

		return "Manager/users/departmentsList";
	}

	// 跳转到增加页面
	@RequestMapping("/toDepartmentAdd")
	public String toDepartmentAdd(Model model) {
		List<Map<String , Object>> list = departmentsService.findCompanysId();
		model.addAttribute("CompanyName", list);
		return "Manager/users/departmentsListAdd";
	}

	// 增加数据
	@RequestMapping("/departmentAdd")
	public String DepartmentAdd(Departments db,HttpServletRequest request) {
		// 获取用户登录信息
		Users user = (Users) request.getSession().getAttribute("userInfo");
		if(user==null){
			return "redirect:main/toLogin.do";
		}
		// 获取用户ID
		int userId = user.getId();
		db.setCreateBy(userId);
		db.setStatus(0);
		departmentsService.addDepartment(db);
		return "redirect:departments.do";
	}

	// 跳转到修改页面
	@RequestMapping("/toDepartmentUpdate")
	public String toDepartmentUpdate(HttpServletRequest request, Model model) {
		String eid = request.getParameter("id");

		Map<String, Object> dbl = departmentsService.findByIds(Integer
				.parseInt(eid));
		model.addAttribute("db", dbl);
		Integer companyID=(Integer) dbl.get("CompanyID");
		List<Departments> departList = departmentsService
				.findDepartmentByCompanyId(companyID);
		System.out.println(departList);
		model.addAttribute("departList", departList);
		return "Manager/users/departmentsListUpdate";
	}

	// 修改数据
	@RequestMapping("/departmentUpdate")
	public String DepartmentUpdate(Departments db) {
		departmentsService.updateDepartment(db);
		return "redirect:departments.do";
	}

	// 删除数据
	@RequestMapping("departmentDelete")
	public String DepartmentDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if (id != null) {
			departmentsService.deleteDepartment(Integer.parseInt(id));
		}
		return "redirect:departments.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteD")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		for (int i = 0; i < item.length; i++) {
			departmentsService.deleteDepartment(Integer.parseInt(item[i]));
		}
	}

	@RequestMapping("departmentInfo")
	public String findDepartment(Integer id, HttpServletRequest request) {
		try {
			List<Departments> departments = departmentsService.findById(id);
			request.setAttribute("dm", departments);
			return "Manager/companys/departmentList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
