package com.wit.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Common;
import com.wit.model.Departments;
import com.wit.model.Jobs;
import com.wit.model.Menus;
import com.wit.model.Roles;
import com.wit.model.Users;
import com.wit.service.DepartmentsService;
import com.wit.service.JobsService;
import com.wit.service.MenusService;
import com.wit.service.RolesService;
import com.wit.service.UserService;

/*  部门管理            */
@Controller
@RequestMapping("/merchant")
public class WebDepartmentsController extends BaseController {
	@Resource
	private DepartmentsService departmentsService;
	@Resource
	private JobsService jobsService;
	@Resource
	private RolesService rolesService;
	@Resource
	private UserService userService;
	@Resource
	private MenusService menusService;

	// 增加一个公司的部门
	@RequestMapping("companyDepartmentAdd")
	public String companyDepartmentAdd(HttpServletRequest request,
			Departments db) {
		try {
			Users users = (Users) request.getSession().getAttribute("user");
			Integer companyId = users.getCompanyId();
			String companyName = users.getCompanyName();
			db.setCompanyName(companyName);
			db.setCompanyId(companyId);
			db.setStatus(0);
			db.setCreateAt(new Date());
			db.setCreateBy(users.getId());
			departmentsService.addDepartment(db);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "redirect:buildSonAccount.do";
	}

	@RequestMapping(value = "/companyDepartmentDelete", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyDepartmentDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("departId");
		if (id != null && id.isEmpty() == false) {
			departmentsService.deleteDepartment(Integer.parseInt(id));
			return "true";
		}
		return "false";
		// return null;
	}

	// 修改公司的部门名称
	@RequestMapping(value = "/companyDepartmentUpdate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyDepartmentUpdate(HttpServletRequest request) {
		String departId = request.getParameter("departId");
		String departName = request.getParameter("departName");
		if (departId != null && departId.isEmpty() == false) {
			Departments dbl = new Departments();
			dbl.setId(Integer.parseInt(departId));
			dbl.setDepartmentName(departName);
			departmentsService.updateDepartmentName(dbl);
			return "true";
		}
		return "false";
	}

	// 修改数据
	@RequestMapping(value = "/selectJobs", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String selectJobs(HttpServletRequest request) {
		String json = "";
		String departId = request.getParameter("departId");
		if (departId != null && departId.isEmpty() == false) {
			List<Jobs> jobs = jobsService.findByDeptId(Integer
					.valueOf(departId));
			if (jobs != null && jobs.size() > 0) {
				json = JSONArray.fromObject(jobs).toString();
				return json;
			}
		}
		return json;
	}

	// 增加一个公司的部门
	@RequestMapping(value = "/companyJobAdd", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyJobAdd(HttpServletRequest request) {
		try {
			Object users = request.getSession().getAttribute("user");
			if (users == null) {
				return "3";
			}
			String departId = request.getParameter("departId");
			if (departId == null || departId.isEmpty()) {
				return "2";
			}
			String jobName = request.getParameter("jobName");
			Jobs job = new Jobs();
			job.setDepartmentId(Integer.valueOf(departId));
			job.setJobName(jobName);
			job.setStatus(0);
			job.setCreateAt(new Date());
			job.setCreateBy(((Users) users).getId());
			jobsService.insertJob(job);
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "0";
	}

	@RequestMapping(value = "/companyJobDelete", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyJobDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("jobId");
		if (id != null && id.isEmpty() == false) {
			jobsService.deleteJob(Integer.parseInt(id));
			return "true";
		}
		return "false";
		// return null;
	}

	// 修改公司的部门名称
	@RequestMapping(value = "/companyJobUpdate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyJobUpdate(HttpServletRequest request) {
		String jobId = request.getParameter("jobId");
		String jobName = request.getParameter("jobName");
		if (jobId != null && jobId.isEmpty() == false) {
			Jobs dbl = new Jobs();
			dbl.setId(Integer.parseInt(jobId));
			dbl.setJobName(jobName);
			jobsService.updateJobName(dbl);
			return "true";
		}
		return "false";
	}

	@RequestMapping(value = "/companyAddRole", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyAddRole(HttpServletRequest request) {
		try {
			Object objUsers = request.getSession().getAttribute("user");
			if (objUsers == null) {
				return "3";
			}
			Users user = (Users) objUsers;
			String roleName = request.getParameter("roleName");
			Roles role = new Roles();
			role.setCompanyID(user.getCompanyId());
			role.setRoleName(roleName);
			role.setStatus(0);
			role.setCreateTime(new Date());
			role.setCreateBy(user.getId());
			rolesService.addRole(role);
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "0";
	}

	@RequestMapping(value = "/companyEditRole", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyEditRole(HttpServletRequest request) {
		try {
			Object objUsers = request.getSession().getAttribute("user");
			if (objUsers == null) {
				return "3";
			}
			Users user = (Users) objUsers;
			String id = request.getParameter("roleid");
			String status = request.getParameter("roleStatus");
			if (id != null && id.isEmpty() == false) {
				Roles role = new Roles();
				role.setId(Integer.valueOf(id));
				role.setStatus(Integer.valueOf(status));
				rolesService.updateRoleStatus(role);
				return "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "0";
	}

	@RequestMapping(value = "/companyAddMerchantUser", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyAddMerchantUser(HttpServletRequest request) {
		try {
			Object objUsers = request.getSession().getAttribute("user");
			if (objUsers == null) {
				return "3";
			}
			Users user = (Users) objUsers;
			String userCode = request.getParameter("userCode");
			String userName = request.getParameter("userName");
			String userPsw = request.getParameter("userPsw");
			String departmentId = request.getParameter("depart");
			String jobsId = request.getParameter("jobs");
			String roleId = request.getParameter("roleId");
			if (userCode != null && userCode.isEmpty() == false) {
				Users merchantUser = new Users();
				merchantUser.setCompanyId(user.getCompanyId());
				merchantUser.setUserCode(userCode);
				merchantUser.setUserName(userName);
				merchantUser.setUserPsw(Common.md5(userPsw));
				merchantUser.setDepartmentId(Integer.valueOf(departmentId));
				merchantUser.setJobsId(Integer.valueOf(jobsId));
				merchantUser.setRoleId(Integer.valueOf(roleId));
				merchantUser.setRegTime(new Date());
				merchantUser.setStatus(1);
				merchantUser.setUserType(2);
				merchantUser.setParentID(user.getId());
				userService.AddMerchantUser(merchantUser);
				return "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "0";
	}

	@RequestMapping(value = "/getRoleRight", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getRoleRight(HttpServletRequest request) {
		String json = "0";
		try {
			Object objUsers = request.getSession().getAttribute("user");
			if (objUsers == null) {
				return "3";
			}
			Users user = (Users) objUsers;
			String id = request.getParameter("roleId");
			if (id != null && id.isEmpty() == false) {
				List<Menus> listMenu= menusService.getMenusByUser(user.getId(), user.getUserType(), 0, 1);
				//JSONArray data=JSONArray.fromObject(listMenu);
				json=JSONArray.fromObject(listMenu).toString();
				return json;
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return json;
	}
	
	@RequestMapping(value = "/companyEditRoleRight", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String companyEditRoleRight(HttpServletRequest request) {
		String json = "0";
		try {
			Object objUsers = request.getSession().getAttribute("user");
			if (objUsers == null) {
				return "3";
			}
			//Users user = (Users) objUsers;
			String id = request.getParameter("roleId");
			String rightId = request.getParameter("rightId");
			if (id != null && id.isEmpty() == false) {
				rolesService.updateRoleMenuRights(id, rightId);
				json="1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return json;
	}
}
