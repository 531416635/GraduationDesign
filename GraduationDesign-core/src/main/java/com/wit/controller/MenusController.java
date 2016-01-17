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
import com.wit.model.Menus;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.MenusService;

/**
 * 菜单管理控制器
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/main")
public class MenusController extends BaseController {
	@Resource
	private MenusService menusService;

	/*
	 * 根据所属平台patform，查找每个平台的数据 patform分别为管理端，采购商，供应商
	 * 
	 * @param page
	 * 
	 * @param model
	 * 
	 * @param request
	 * 
	 * @return
	 */
	@RequestMapping("/manegerMenus")
	public String manegerMenus(Page page, Model model,
			HttpServletRequest request) {
		return getMenusList(page, model, request, Common.UserType.Manager
				.getIndexString().toString());
	}

	@RequestMapping("/SearchMenu")
	public String SearchMenu(Page page, Model model, HttpServletRequest request) {
		String strPatform = request.getParameter("hidPatform");
		return getMenusList(page, model, request, strPatform.toString());
	}

	@RequestMapping("/purchaserMenus")
	public String purchaserMenus(Page page, Model model,
			HttpServletRequest request) {
		return getMenusList(page, model, request, Common.UserType.Merchant
				.getIndexString().toString());
	}

	@RequestMapping("/supplierMenus")
	public String supplierMenus(Page page, Model model,
			HttpServletRequest request) {
		return getMenusList(page, model, request, Common.UserType.Merchant
				.getIndexString().toString());
	}

	public String getMenusList(Page page, Model model,
			HttpServletRequest request, String patform) {
		String json="";
		String strMenuName = request.getParameter("txtMenuName");
		if (strMenuName != null && !strMenuName.isEmpty()) {
			strMenuName=Common.getDecoding(strMenuName);
		}
		List<Menus> list = menusService.getAll(page, patform, strMenuName);
		request.setAttribute("dispatch", list);
		request.setAttribute("patform", patform);
		request.setAttribute("menuName", strMenuName);
		if (patform == null) {
			page.setRows(menusService.findRows());
		} else {
			page.setRows(menusService.findRow(patform, strMenuName));
		}
		json=JSONObject.fromObject(page).toString();
		request.setAttribute("json", json);
		request.setAttribute("page", page);
		return "Manager/menus/MenusList";
	}

	// 删除一条记录
	@RequestMapping("/deleteMenus")
	public String delete(Menus menus) {
		Integer id = menus.getId();
		if (id != null) {
			menusService.delete(id);
		}
		return getMenusList(menus.getMenuType());
	}

	// 跳转到添加界面
	@RequestMapping("/toMenusAdd")
	public String toAdd(Model model) {
		List<Menus> list = menusService.getAllMenu();
		/*
		 * for(Menus m: list){
		 * System.out.println(m.getParentMenu()+" "+m.getMenuName()); }
		 */
		model.addAttribute("menusLists", list);
		return "Manager/menus/MenusListAdd";
	}

	// 添加
	@RequestMapping("/addMenusList")
	public String add(Menus menu, Model model, HttpServletRequest request) {

		Users user = (Users) request.getSession().getAttribute("userInfo");

		menu.setCreateBy(user.getId());
		//menu.setCreateTime(Common.getSqlDate());
		menu.setStatus(0);
		if (!menu.getMenuName().isEmpty()) {
			menusService.add(menu);
		} else {
			model.addAttribute("msg", "输入的菜单名称不能为空");
		}

		return getMenusList(menu.getMenuType());
	}

	private String getMenusList(int menuType) {
		String menuString = "";
		switch (menuType) {
		case 1:
			menuString = "redirect:manegerMenus.do";
			break;
		case 2:
			menuString = "redirect:purchaserMenus.do";
			break;
		case 3:
			menuString = "redirect:supplierMenus.do";
			break;
		}
		return menuString;
	}

	// 跳转到修改界面
	@RequestMapping("/toMenusListUpdate")
	public String toUpdate(Integer id, Model model, Page page,
			HttpServletRequest request) {
		Menus menus = menusService.findById(id);
		List<Menus> list = menusService.getAllMenu();
		model.addAttribute("menusLists", list);
		model.addAttribute("menus", menus);
		return "Manager/menus/MenusListUpdate";
	}

	// 修改，功能有问题,前台显示修改了，修改和添加功能有问题
	@RequestMapping("/updateMenusList")
	public String update(Menus menus, HttpServletRequest request) {
		menusService.update(menus);
		int patform = Integer.parseInt(request.getParameter("patform"));
		System.out.println(patform);
		if (patform == 1) {
			return "redirect:manegerMenus.do";
		} else if (patform == 2) {
			return "redirect:purchaserMenus.do";
		} else {
			return "redirect:supplierMenus.do";
		}

	}

	// 批量删除
	@RequestMapping("/allDeleteMenus")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		menusService.deleteByIDs(sid);
		/*
		 * String[] item = sid.split("@"); System.out.println("123"); for (int i
		 * = 0; i < item.length; i++) {
		 * menusService.delete(Integer.parseInt(item[i])); }
		 */
	}
}
