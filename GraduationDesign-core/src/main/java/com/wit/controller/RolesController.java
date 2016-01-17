package com.wit.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.comm.Common;
import com.wit.model.Page;
import com.wit.model.Roles;
import com.wit.model.Users;
import com.wit.service.RolesService;

/*  角色管理                             */
@Controller
@RequestMapping("users")
public class RolesController extends
		BaseController {
	@Resource
	private RolesService rolesService;

	// 查询数据
	@RequestMapping("/roles")
	public String linkRoles(Model model, Page page) {
		String json="";
		List<Roles> list = rolesService
				.findAll(page);
		model.addAttribute("roles", list);
		int rows = rolesService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/users/rolesList";
	}

	// 跳转到增加页面
	@RequestMapping("/toRoleAdd")
	public String toRoleAdd() {
		return "Manager/users/rolesListAdd";
	}

	// 增加数据
	@RequestMapping("/roleAdd")
	public String RoleAdd(Roles db, HttpServletRequest request) {
		Users user =(Users)request.getSession().getAttribute("userInfo");
		db.setCreateTime(Common.getSqlDate());
		db.setCreateBy(user.getId());
		if(user.getUserType()==1){
			db.setCompanyID(0);
		}else{
			db.setCompanyID(user.getCompanyId());
		}
		rolesService.addRole(db);
		return "redirect:roles.do";
	}

	// 跳转到修改页面
	@RequestMapping("/toRoleUpdate")
	public String toRoleUpdate(
			HttpServletRequest request,
			Model model) {
		String eid = request.getParameter("id");
		Roles dbl = rolesService.findById(Integer
				.parseInt(eid));
		model.addAttribute("db", dbl);
		return "Manager/users/rolesListUpdate";
	}

	// 修改数据
	@RequestMapping("/roleUpdate")
	public String RoleUpdate(Roles db) {
		rolesService.updateRole(db);
		return "redirect:roles.do";
	}

	// 删除数据
	@RequestMapping("roleDelete")
	public String RoleDelete(
			HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if (id != null) {
			rolesService.deleteRole(Integer
					.parseInt(id));
		}
		return "redirect:roles.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteRo")
	public void deleteMore(
			HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		for (int i = 0; i < item.length; i++) {
			rolesService.deleteRole(Integer
					.parseInt(item[i]));
		}
	}

	// 修改权限
	@RequestMapping("/MenuRightEdit")
	public String updateRoleMenuRights(
			HttpServletRequest request,
			HttpServletResponse response) {
		String roleID = request
				.getParameter("hidRoleID");
		String[] menuID = request
				.getParameterValues("ckbMenuID");

		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < menuID.length; i++) {
			sb.append(menuID[i].trim() + ",");
		}
		String menuIDs = sb.toString();
		if (!menuIDs.isEmpty()
				&& menuIDs.endsWith(",")) {
			menuIDs = menuIDs.substring(0,
					menuIDs.length() - 1);
		}

		if (roleID != "" && menuIDs != ""
				&& roleID != null
				&& menuIDs != null) {
			rolesService.updateRoleMenuRights(
					roleID, menuIDs);
		}
		return "redirect:allocation.do?id="
				+ roleID;
	}

}
