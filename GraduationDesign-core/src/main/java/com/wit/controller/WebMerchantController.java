package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Common;
import com.wit.model.Menus;
import com.wit.model.News;
import com.wit.model.Users;
import com.wit.service.FavoriteService;
import com.wit.service.MenusService;
import com.wit.service.NewsService;

@Controller
@RequestMapping("/merchant")
public class WebMerchantController  extends BaseController{
	@Autowired
	private MenusService menusService;
	@Autowired
	private NewsService newsService;
	@Autowired
	private FavoriteService favoriteService;
	
	@RequestMapping(value = "/getMenusListForHeader", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getMenusList(HttpServletRequest request) {
		String json = null;
		Object sessionUser=request.getSession().getAttribute("user");
		if(sessionUser!=null){
			Users user = (Users) sessionUser;
		
			List<Menus> menusList = menusService.getMenusByUser(user.getId(),
					user.getUserType(), 1, 1);
			try {
				if (menusList != null && menusList.size() > 0) {
					json = JSONArray.fromObject(menusList.toArray()).toString();
				}
			} catch (Exception e) {
				Common.setLog(e);
				return json;
			}
		}		
		return json;
	}

	@RequestMapping(value = "/getNewsListForHeader", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getNewsList(HttpServletRequest request) {
		String json = null;

		List<News> newsList = newsService.findNewsLimit(7, 0);
		try {
			if (newsList != null && newsList.size() > 0) {
				json = JSONArray.fromObject(newsList.toArray()).toString();
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@RequestMapping(value = "/getUserForHeader", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getUser(HttpServletRequest request) {
		String json = null;
		Users user = (Users) request.getSession().getAttribute("user");
		try {
			if (user != null) {
				json = JSONObject.fromObject(user).toString();
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}
	@RequestMapping(value = "DelFavorite", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String DelFavorite(HttpServletRequest request) {
		String json = "{'result':'false'}";
		String ids = request.getParameter("ids").toString();
		Object user=request.getSession().getAttribute("user");
		if(user==null)
		{
			return "1";
		}
		try {
			favoriteService.deleteByIds(ids);
			json="{'result':'true'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}
}
