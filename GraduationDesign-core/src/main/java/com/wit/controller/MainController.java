package com.wit.controller;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.comm.Common;
import com.wit.model.Dictionarys;
import com.wit.model.Menus;
import com.wit.model.Users;
import com.wit.service.DictionaryService;
import com.wit.service.MenusService;
import com.wit.service.UserManagerService;

@Controller
@RequestMapping("/main")
public class MainController {
	@Resource
	private UserManagerService userManagerService;
	@Autowired
	private MenusService menusService;
	
	@Autowired
	private DictionaryService dictionaryService;

	@RequestMapping("/toLogin")
	public String toLogin(HttpServletRequest request) {
		List<Dictionarys> pageInfo = dictionaryService.getDicsByDicType(3);
		for(Dictionarys d:pageInfo){
			if(d.getDicCode().equals("Copyright")){
				request.setAttribute("Copyright", d);
				break;
			}
		}
		return "main/login";
	}
	@RequestMapping("/toError")
	public String toError(HttpServletRequest request) {		
		return "error";
	}

	@RequestMapping("/toMain")
	public String checkLogin(HttpServletRequest request) {
		String userName = request.getParameter("userName");
		String userPsw = request.getParameter("userPsw");

		if(userName==null || userPsw==null)
		{
			request.setAttribute("msg", "请填写用户名密码");
			return "redirect:toLogin.do";
		}
		
		// 用户名和密码正确

		Users user = userManagerService.findByName(userName);

		if (user != null) {
			String userPswMd5 = Common.md5(userPsw);
			if (user.getUserPsw().equals(userPswMd5) == false) {
				/* if (user.getUserPsw().equals(userPsw) == false) { */
				request.setAttribute("msg", "该用户名密码错误");
				return "main/login";
			}

			Integer status = user.getStatus();
			switch (status) {
			case 0:
				request.setAttribute("msg", "账户未认证");
				break;
			case 1:
				request.setAttribute("msg", "");
				request.getSession().setAttribute("userInfo", user);
				return "main/main";
			case 2:
				request.setAttribute("msg", "账户冻结");
				break;
			case 3:
				request.setAttribute("msg", "账户已删除");
				break;
			default:
				request.setAttribute("msg", "账户无法使用");
				break;
			}
		} else {
			request.setAttribute("msg", "该用户名不存在");
			return "main/login";
		}
		return "main/login";
	}

	@RequestMapping("/linkTop")
	public String linkTop(HttpServletRequest request) {
		// 获取登录User的用户名
		Users user = (Users) request.getSession().getAttribute("userInfo");
		request.setAttribute("userName", user.getUserName());
		return "main/top";
	}

	@RequestMapping("/linkLeft")
	public String linkLeft(HttpServletRequest request) {

		// 根据用户信息获取其权限菜单列表
		Users user = (Users) request.getSession().getAttribute("userInfo");

		if (user != null && user.getId() != 0) {
			/*
			 * Integer userID = user.getId(); String
			 * userType=user.getUserType();
			 */
			try {
				List<Menus> menusList = menusService.getMenusByUser(
						user.getId(), user.getUserType(), 1, 1);
				if (menusList != null) {
					request.setAttribute("menusList", menusList);
					//request.getSession().setAttribute("menusList", menusList);
				}
			} catch (Exception ex) {

			}
		}
		return "main/left";
	}

	@RequestMapping("/linkRight")
	public String linkRight() {
		return "main/right";
	}

}
