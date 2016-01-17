package com.wit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Common;
import com.wit.model.Companys;
import com.wit.model.Page;
import com.wit.model.Roles;
import com.wit.model.Users;
import com.wit.service.CompanysService;
import com.wit.service.RolesService;
import com.wit.service.UserManagerService;
import com.wit.service.UserService;

/**
 * 
 * @author ljj time: 2013-3-22
 * 
 */

/* 用户管理 */
@Controller
@RequestMapping("/users")
public class UserManagerController extends BaseController {
	@Resource
	private UserManagerService userManagerService;
	@Resource
	private RolesService rolesService;

	@Autowired
	private UserService userService;
	@Autowired
	private CompanysService companysService;

	// 查询数据
	@RequestMapping("/userManager")
	public String linkUserManager(Model model, Page page) {
		String json="";
		// 从数据库查询所有数据
		List<Map<String,Object>> list = userManagerService.findAll(page);
		model.addAttribute("userManagers", list);
	
		
		int rows = userManagerService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/users/userManagerList";
	}

	// 通过ID查找详细信息
	@RequestMapping("/toUserManagerAll")
	public String toUserManagerAll(Model model, HttpServletRequest request) {
		String eid = request.getParameter("id");
		Users dbl = userManagerService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		return "Manager/users/userManagerListAll";
	}

	// 通过ID查找详细信息
	@RequestMapping("/toUserManagerAll1")
	public String toUserManagerAll1(Model model, HttpServletRequest request) {
		String eid = request.getParameter("id");
		Users dbl = userManagerService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		return "Purchaser/companyUserInfo";

	}

	// 通过ID查找详细信息
	@RequestMapping("/toUserManagerAll2")
	public String toUserManagerAll2(Model model, HttpServletRequest request) {
		String eid = request.getParameter("id");
		Users dbl = userManagerService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		return "Supplier/companyUserInfo";
	}

	// 跳转到增加页面
	@RequestMapping("/toUserManagerAdd")
	public String toUserManagerAdd(Model model) {
		List<Roles> list = rolesService.findRoleUsed();
		model.addAttribute("roles", list);
		return "Manager/users/userManagerListAdd";
	}

	// 增加数据
	@RequestMapping("/userManagerAdd")
	public String UserManagerAdd(Users db) {
		String userPswMd5 =Common.md5(db.getUserPsw());
		db.setUserPsw(userPswMd5);
		userManagerService.insertUsers(db);
		return "redirect:userManager.do";
	}

	// 进入company子账户列表页面
	@RequestMapping("/toCompanyUserList")
	public String toCompanyUserList(HttpServletRequest request, Page page) {
		Users user = (Users) request.getSession().getAttribute("userInfo");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("companyId", user.getCompanyId());
		map.put("page", page);
		List<Users> list = userManagerService.findAllByCompanyId(map);
		request.setAttribute("userManagers", list);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("companyId", user.getCompanyId());
		List<String> statuss = new ArrayList<String>();
		statuss.add("0");
		statuss.add("1");
		statuss.add("2");
		maps.put("statuss", statuss);
		int rows = userManagerService.findRowsByCompanyIds(maps);
		page.setRows(rows);
		System.out.println(page);
		request.setAttribute("page", page);
		return "Purchaser/companyUserList";
	}

	// 进入company子账户列表页面
	@RequestMapping("/toCompanyUserLists")
	public String toCompanyUserLists(HttpServletRequest request, Page page) {
		Users user = (Users) request.getSession().getAttribute("userInfo");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("companyId", user.getCompanyId());
		map.put("page", page);
		List<Users> list = userManagerService.findAllByCompanyId(map);
		request.setAttribute("userManagers", list);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("companyId", user.getCompanyId());
		List<String> statuss = new ArrayList<String>();
		statuss.add("0");
		statuss.add("1");
		statuss.add("2");
		maps.put("statuss", statuss);
		int rows = userManagerService.findRowsByCompanyIds(maps);
		page.setRows(rows);
		System.out.println(page);
		request.setAttribute("page", page);
		return "Supplier/companyUserList";
	}

	// 跳转到company新增加子账户页面
	@RequestMapping("/toCompanyAddUser")
	public String tocompanyAddUser(HttpServletRequest request, Page page) {
		return "Purchaser/companyAddUser";

	}

	// 跳转到company新增加子账户页面
	@RequestMapping("/toCompanyAddUsers")
	public String toCompanyAddUsers(HttpServletRequest request, Page page) {
		return "Supplier/companyAddUser";
	}

	// company新增加子账户
	@RequestMapping("/companyAddUser")
	@ResponseBody
	public String companyAddUser(Users db, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("userInfo");
			String userPswMd5 = Common.md5(db.getUserPsw()); // com.wit.sign.MD5.sign(db.getUserPsw(),"tuancan",
																// "UTF-8");
			db.setRoleId(user.getRoleId());
			db.setStatus(1);
			db.setUserType(user.getUserType());
			db.setCompanyId(user.getCompanyId());
			db.setUserPsw(userPswMd5);
			userManagerService.insertUsers(db);
			return "true";
			/* return "redirect:toCompanyUserList.do"; */
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// company新增加子账户
	@RequestMapping("/companyAddUsers")
	@ResponseBody
	public String companyAddUsers(Users db, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("userInfo");
			String userPswMd5 = Common.md5(db.getUserPsw());
			db.setRoleId(user.getRoleId());
			db.setStatus(1);
			db.setUserType(user.getUserType());
			db.setCompanyId(user.getCompanyId());
			db.setUserPsw(userPswMd5);
			userManagerService.insertUsers(db);
			return "true";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// company用户删除
	@RequestMapping("/deleteCompanyUser")
	public String deleteCompanyUser(Integer id, Model model) {
		Map<String, Integer> maps = new HashMap<String, Integer>();
		maps.put("userId", id);
		maps.put("status", 3);
		userManagerService.updateStatus(maps);
		return "redirect:toCompanyUserList.do";
	}

	// company用户删除
	@RequestMapping("/deleteCompanyUsers")
	public String deleteCompanyUsers(Integer id, Model model) {
		Map<String, Integer> maps = new HashMap<String, Integer>();
		maps.put("userId", id);
		maps.put("status", 3);
		userManagerService.updateStatus(maps);
		return "redirect:toCompanyUserLists.do";
	}

	// 批量删除company子用户
	@RequestMapping("/deleteCompanyUsers1")
	public void deleteCompanyUsers1(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		userManagerService.deleteCompanyUsers(sid);
	}

	// 批量删除company子用户
	@RequestMapping("/deleteCompanyUsers2")
	public void deleteCompanyUsers2(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		userManagerService.deleteCompanyUsers(sid);
	}

	// 跳转到修改页面
	@RequestMapping("/toUserManagerUpdate")
	public String toUserManagerUpdate(HttpServletRequest request, Model model,
			Page page) {
		String eid = request.getParameter("id");
		Users dbl = userManagerService.findById(Integer.parseInt(eid));
		Integer rid = dbl.getRoleId();
		Roles rs = rolesService.findById(rid);
		List<Roles> list = rolesService.findRoleUsed();
		List<Map<String,Object>> lists = userManagerService.findAll(page);
		
		
		//查询所有公司
		List<Companys> companys =companysService.findAllCompanys();
		model.addAttribute("companys", companys);
		
		
		model.addAttribute("users", lists);
		model.addAttribute("db", dbl);
		System.out.println(dbl);
		model.addAttribute("roles", rs);
		model.addAttribute("roleListss", list);
		return "Manager/users/userManagerListUpdate";
	}

	// 跳转到修改页面
	@RequestMapping("/toUserManagerUpdate1")
	public String toUserManagerUpdate1(HttpServletRequest request, Model model,
			Page page) {
		try {
			String eid = request.getParameter("id");
			Users dbl = userManagerService.findById(Integer.parseInt(eid));
			Integer rid = dbl.getRoleId();
			Roles rs = rolesService.findById(rid);
			List<Roles> list = rolesService.findAll(page);
			List<Map<String,Object>> lists = userManagerService.findAll(page);
			model.addAttribute("users", lists);
			model.addAttribute("db", dbl);
			model.addAttribute("roles", rs);
			model.addAttribute("roleListss", list);
			return "Purchaser/companyUserUpdate";

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 跳转到修改页面
	@RequestMapping("/toUserManagerUpdate2")
	public String toUserManagerUpdate2(HttpServletRequest request, Model model,
			Page page) {
		String eid = request.getParameter("id");
		Users dbl = userManagerService.findById(Integer.parseInt(eid));
		Integer rid = dbl.getRoleId();
		Roles rs = rolesService.findById(rid);
		List<Roles> list = rolesService.findAll(page);
		List<Map<String,Object>> lists = userManagerService.findAll(page);
		model.addAttribute("users", lists);
		model.addAttribute("db", dbl);
		model.addAttribute("roles", rs);
		model.addAttribute("roleListss", list);
		return "Supplier/companyUserUpdate";
	}

	// 修改数据
	@RequestMapping("/userManagerUpdate")
	public String UserManagerUpdate(Users db) {
	Companys companys =companysService.findById(db.getCompanyId());
	db.setUserUnits(companys.getCompanyName());
		userManagerService.updateUsers(db);
		return "redirect:userManager.do";
	}

	// 修改数据
	@RequestMapping("/userManagerUpdate1")
	@ResponseBody
	public String userManagerUpdate1(HttpServletRequest request, Users db) {
		try {
			userManagerService.updateUsers(db);

			/* return "redirect:toCompanyUserList.do"; */
			return "true";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 修改数据
	@RequestMapping("/userManagerUpdate2")
	@ResponseBody
	public String userManagerUpdate2(HttpServletRequest request, Users db) {
		try {
			userManagerService.updateUsers(db);
			/* return "redirect:toCompanyUserLists.do"; */
			return "true";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	@RequestMapping("/userManagerFreeze")
	public String UserManagerFreeze(HttpServletRequest request) {
		String userId = request.getParameter("id");
		Map<String, Integer> maps = new HashMap<String, Integer>();
		maps.put("userId", Integer.parseInt(userId));
		maps.put("status", 2);
		userManagerService.updateStatus(maps);
		return "redirect:userManager.do";
	}

	// 删除数据
	@RequestMapping("userManagerDelete")
	public String UserManagerDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String userId = request.getParameter("id");
		Map<String, Integer> maps = new HashMap<String, Integer>();
		maps.put("userId", Integer.parseInt(userId));
		maps.put("status", 3);
		userManagerService.updateStatus(maps);
		return "redirect:userManager.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteUm")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		userManagerService.deleteCompanyUsers(sid);
	}

	// 跳转修改密码页面
	@RequestMapping("toUpdatePwd")
	public String toUpdatePwd(HttpServletRequest request) {
		try {
			return "updatePwd";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 密码修改
	@RequestMapping("updatePwd")
	@ResponseBody
	public String updatePwd(HttpServletRequest request) {
		try {
			// 获取用户登录信息
			Users users = (Users) request.getSession().getAttribute("userInfo");
			// System.out.println(users.getUserPsw());
			// 获取用户ID
			int id = users.getId();
			// 获取页面设置的新密码
			String userPsw = request.getParameter("newPwd");
			// 获取用户输入的原密码
			String oldPwd = request.getParameter("oldPwd");
			// 获取用户输入的确认密码
			String pwdConfirm = request.getParameter("newPwdConfirm");
			if (oldPwd == null || oldPwd == "") {
				// 原始密码不能为空
				return "nullError";
				// 原始密码加密与数据库密码比较
			} else if (users.getUserPsw().equals(Common.md5(oldPwd)) == false) {
				// 原始密码不正确
				return "pwdError";
			} else if (userPsw == null || userPsw == "") {
				// 新密码不能为空
				return "null2Error";
			} else if (pwdConfirm == null || pwdConfirm == "") {
				// 确认密码不能为空
				return "null3Error";
			} else if (userPsw.equals(pwdConfirm) == false) {
				// 两次输入的密码不一致
				return "confirmError";
			} else {
				Map<String, Object> parm = new HashMap<>();
				parm.put("id", id);
				parm.put("userPsw", Common.md5(userPsw));
				// 将加密后的新密码和用户id传给配置文件
				userService.updatePwd(parm);
				// 修改密码成功
				return "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
