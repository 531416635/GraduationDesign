package com.wit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Menus;
import com.wit.model.Page;
import com.wit.model.Rights;
import com.wit.model.Roles;
import com.wit.service.MenusService;
import com.wit.service.RightsService;
import com.wit.service.RolesService;

@Controller
@RequestMapping("users")
public class RightsController extends BaseController {
	@Resource
	private RightsService rightsService;
	@Resource
	private RolesService rolesService;
	@Resource
	private MenusService menusService;

	@RequestMapping("/rights")
	public String linkRights(Model model, Page page) {
		String json="";
		List<Rights> list = rightsService.findAll(page);
		model.addAttribute("rights", list);
		int rows = rightsService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/users/rightsList";
	}

	@RequestMapping("/toRightAdd")
	public String toRightAdd(Model model, Page page) {
		List<Menus> list = menusService.findAll();
		model.addAttribute("menus", list);
		return "Manager/users/rightsListAdd";
	}

	// 增加页面
	@RequestMapping("/rightAdd")
	public String RightAdd(Rights db) {
		rightsService.addRight(db);
		return "redirect:rights.do";
	}

	@RequestMapping("/allocation")
	public String linkRolesRights(HttpServletRequest request) {
		String eid = request.getParameter("id");
		Roles role = rolesService.findById(Integer.parseInt(eid));
		request.setAttribute("roles", role);
		/*
		 * List<Rights> rights = rightsService.allocationRight(Integer
		 * .parseInt(eid)); request.setAttribute("allocationList", rights);
		 */
		List<Menus> menuLists = menusService.findAll();

		String rightID = String.format(",%s,", role.getRightID());
		if (rightID != null && !rightID.isEmpty()) {
			List<Menus> menuList = new ArrayList<Menus>();
			for (int i = 0; i < menuLists.size(); i++) {
				Menus menu = menuLists.get(i);
				String menuId = String.format(",%s,", menu.getId());
				boolean ischecked = rightID.contains(menuId);
				menu.setIsChecked(ischecked);
				menuList.add(menu);
			}
			request.setAttribute("menuLists", menuList);
		} else {
			request.setAttribute("menuLists", menuLists);
		}
		return "Manager/users/allocationList";
	}

	@RequestMapping("/toRightUpdate")
	public String toRightUpdate(HttpServletRequest request, Model model) {
		String eid = request.getParameter("id");
		Rights dbl = rightsService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		List<Integer> list = rightsService.findMenusId();
		model.addAttribute("menusIdsU", list);
		return "Manager/users/rightsListUpdate";
	}

	// 修改页面
	@RequestMapping("/rightUpdate")
	public String RightUpdate(Rights db) {
		rightsService.updateRight(db);
		return "redirect:rights.do";
	}

	// 删除数据
	@RequestMapping("rightDelete")
	public String RightDelete(HttpServletRequest request) {
		// 通过获取ID来删除一条数据
		String id = request.getParameter("id");
		if (id != null) {
			rightsService.deleteRight(Integer.parseInt(id));
		}
		return "redirect:rights.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteR")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		for (int i = 0; i < item.length; i++) {
			rightsService.deleteRight(Integer.parseInt(item[i]));
		}
	}
}
