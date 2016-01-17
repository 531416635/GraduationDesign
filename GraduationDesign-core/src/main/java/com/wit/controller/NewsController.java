package com.wit.controller;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.model.News;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.NewsService;
import com.wit.comm.CacheManager;
import com.wit.comm.Common;
/**
 * 新闻公告Controller
 * @author chenqiulong
 *
 */
@Controller
@RequestMapping("/news")
public class NewsController extends	BaseController{
	@Autowired
	private NewsService newsService;
/**
 * 新闻公告列表
 * @param newType
 * @param model  
 * @return
 */
@RequestMapping("/newsList")
public String newsList(Page page,HttpServletRequest request){
	String json="";
	try {
	
		Map<String,Object> maps = new HashMap<String,Object>();
		Integer newType =1;
		maps.put("page", page);
		maps.put("newType", newType);
		List<News> news = newsService.findNews(maps);
		request.setAttribute("news",news);
		int rows = newsService.findRows(newType);
		page.setRows(rows);
		//request.setAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		request.setAttribute("json", json);
			return "Manager/news/newsList1";
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
@RequestMapping("/noticeList")
public String noticeList(Page page,Model model){
	String json="";
	try {
		Map<String,Object> maps = new HashMap<String,Object>();
		Integer newType =2;
		maps.put("page", page);
		maps.put("newType", newType);
		List<News> news = newsService.findNews(maps);
		model.addAttribute("news",news);
		int rows = newsService.findRows(newType);
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
			return "Manager/news/newsList2";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
	/**
	 * 新闻删除
	 * @param id
	 * @return
	 */
@RequestMapping("/deleteNew")
public String deleteNew(News news,Model model){
	try {
	Integer id=news.getId();
	newsService.deleteNew(id);
	CacheManager.clearAll();
		return "redirect:newsList.do";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
/**
 * 公告删除
 * @param id
 * @return
 */
@RequestMapping("/deleteNotice")
public String deleteNotice(News news,Model model){
try {
Integer id=news.getId();
newsService.deleteNew(id);
CacheManager.clearAll();
	return "redirect:noticeList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
}
/**
 * 进入新闻公告添加页
 * @param news
 * @return
 */
@RequestMapping("/toAddNew")
public String toAddNew(Integer newType,Model model ){
	try {
	model.addAttribute("newType",newType);
		return "Manager/news/newsAdd";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
/**
 * 进入新闻公告添加页
 * @param news
 * @return
 */
@RequestMapping("/toAddNotice")
public String toAddNotice(Integer newType,Model model ){
	try {
	model.addAttribute("newType",newType);
		return "Manager/news/newsAdd";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
/**
 * 增加新闻
 * @param news
 * @return
 */
@RequestMapping("/addNew")
@ResponseBody
public String addNew(News news,HttpServletRequest request){
	try {
		System.out.println("news"+news);
		Users user = (Users)request.getSession().getAttribute("userInfo");
		//news.setReleaseTime(Common.getSqlDate());
		news.setPublishers(user.getUserName());
		String title = request.getParameter("title");
		String content2 = request.getParameter("content2");
		String releaseAging = request.getParameter("releaseAging2");
		DateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date timeDate = (Date) dateFormat.parse(releaseAging);//util类型
		java.sql.Timestamp dateTime = new java.sql.Timestamp(timeDate.getTime());
		
		String newType = request.getParameter("newType");
		news.setTitle(title);
		news.setContent(content2);
		news.setNewType(Integer.valueOf(newType));
		news.setReleaseAging(dateTime);
		newsService.addNew(news);
		CacheManager.clearAll();
		if(news.getId()!=null){
			return "true";	
		}else{
			return "error";
		}
		
		/*return "redirect:newsList.do";*/
} catch (Exception e) {
	e.printStackTrace();
	return "error";
}
		
	}
/**
 * 增加公告
 * @param news
 * @return
 */
@RequestMapping("/addNotice")
@ResponseBody
public String addNotice(News news,HttpServletRequest request){
	try {
		Users user = (Users)request.getSession().getAttribute("userInfo");
		//news.setReleaseTime(Common.getSqlDate());
		news.setPublishers(user.getUserName());
		String title = request.getParameter("title");
		String content2 = request.getParameter("content2");
		String releaseAging = request.getParameter("releaseAging2");
		DateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date timeDate = (Date) dateFormat.parse(releaseAging);//util类型
		java.sql.Timestamp dateTime = new java.sql.Timestamp(timeDate.getTime());
		
		String newType = request.getParameter("newType");
		news.setTitle(title);
		news.setContent(content2);
		news.setNewType(Integer.valueOf(newType));
		news.setReleaseAging(dateTime);
	newsService.addNew(news);
	CacheManager.clearAll();
	if(news.getId()!=null){
		return "true";
	}else{
		return "error";
	}
		/*return "redirect:noticeList.do";*/
} catch (Exception e) {
	e.printStackTrace();
	request.setAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
		
	}
/**
 * 进入new更新页面
 * @param newType
 * @param model
 * @return
 */
@RequestMapping("/toUpdateNew")
public String toUpdateNew(Integer id,Model model ){
	try {
	 News news = newsService.findbyId(id);
	model.addAttribute("news",news);
		return "Manager/news/newsUpdate";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
/**
 * 进入notice更新页面
 * @param newType
 * @param model
 * @return
 */
@RequestMapping("/toUpdateNotice")
public String toUpdateNotice(Integer id,Model model ){
	try {
	 News news = newsService.findbyId(id);
	model.addAttribute("news",news);
		return "Manager/news/newsUpdate";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
/**
 * 更新新闻
 * @param news
 * @return
 */
@RequestMapping("/updateNew")
@ResponseBody
public String updateNew(News news,HttpServletRequest request){
	try {
		Users user = (Users)request.getSession().getAttribute("userInfo");
		//news.setReleaseTime(Common.getSqlDate());
		String title = request.getParameter("title");
		String content2 = request.getParameter("content2");
		String releaseAging = request.getParameter("releaseAging2");
		DateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date timeDate = (Date) dateFormat.parse(releaseAging);//util类型
		java.sql.Timestamp dateTime = new java.sql.Timestamp(timeDate.getTime());
		
		String newType = request.getParameter("newType");
		String status = request.getParameter("status");
		String id = request.getParameter("id");
		String publishers = request.getParameter("publishers");
		String releaseTime = request.getParameter("releaseTime2");
		java.util.Date timeDate2 = (Date) dateFormat.parse(releaseTime);//util类型
		java.sql.Timestamp dateTime2 = new java.sql.Timestamp(timeDate2.getTime());
		news.setTitle(title);
		news.setContent(content2);
		news.setNewType(Integer.valueOf(newType));
		news.setReleaseAging(dateTime);
		news.setStatus(Integer.valueOf(status));
		news.setId(Integer.valueOf(id));
		news.setReleaseTime(dateTime2);
		news.setPublishers(user.getUserName());
	newsService.updateNew(news);
	CacheManager.clearAll();
	return "true";
		/*return "redirect:newsList.do";*/
} catch (Exception e) {
	e.printStackTrace();
	request.setAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
	}
/**
 * 更新公告
 * @param news
 * @return
 */
@RequestMapping("/updateNotice")
@ResponseBody
public String updateNotice(News news,HttpServletRequest request){
	try {
		Users user = (Users)request.getSession().getAttribute("userInfo");
		//news.setReleaseTime(Common.getSqlDate());
		String title = request.getParameter("title");
		String content2 = request.getParameter("content2");
		String releaseAging = request.getParameter("releaseAging2");
		DateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date timeDate = (Date) dateFormat.parse(releaseAging);//util类型
		java.sql.Timestamp dateTime = new java.sql.Timestamp(timeDate.getTime());
		
		String newType = request.getParameter("newType");
		String status = request.getParameter("status");
		String id = request.getParameter("id");
		String publishers = request.getParameter("publishers");
		String releaseTime = request.getParameter("releaseTime2");
		java.util.Date timeDate2 = (Date) dateFormat.parse(releaseTime);//util类型
		java.sql.Timestamp dateTime2 = new java.sql.Timestamp(timeDate2.getTime());
		news.setTitle(title);
		news.setContent(content2);
		news.setNewType(Integer.valueOf(newType));
		news.setReleaseAging(dateTime);
		news.setStatus(Integer.valueOf(status));
		news.setId(Integer.valueOf(id));
		news.setReleaseTime(dateTime2);
		news.setPublishers(user.getUserName());
	newsService.updateNew(news);
	CacheManager.clearAll();
	return "true";
		/*return "redirect:noticeList.do";*/
} catch (Exception e) {
	e.printStackTrace();
	request.setAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
	}
/**
 * 批量删除New
 * @param request
 * @param response
 */
@RequestMapping("/deleteMoreNew") 
@ResponseBody
public void deleteMoreNew(HttpServletRequest request, HttpServletResponse response) { 
	try {
	String sid = request.getParameter("Uid");
	newsService.deleteByIds(sid);
	CacheManager.clearAll();
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
	}
} 
/**
 * 批量删除Notice
 * @param request
 * @param response
 */
@RequestMapping("/deleteMoreNotice") 
public void deleteMoreNotice(HttpServletRequest request, HttpServletResponse response) { 
	try {
	String sid = request.getParameter("Uid");
	newsService.deleteByIds(sid);
	CacheManager.clearAll();
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
	}
}

//新闻搜索及分页
@RequestMapping(value="searchNewsInfo",produces={ "application/json;charset=UTF-8" })
@ResponseBody
public String searchNewsInfo(HttpServletRequest request){
	String json = "{'result':'false'}";
	try {
		Page page1=new Page();	
		Page page2=new Page();
	    Page page3=new Page();
		//获取用户输入的查询信息
		String title = request.getParameter("title");
		//获取新闻类型
		Integer newType = Integer.valueOf(request.getParameter("newType"));
		Map<String,Object> parm = new HashMap<>();
		parm.put("newType", newType);
		parm.put("title", title);
		switch (newType) {
		case 1:
			//新闻类型1的分页
			parm.put("page", page1);
			//搜索查询
			List<News> newsList1 = newsService.searchNewsInfo(parm);
			//搜索结果行数
			int rows1 = newsService.searchNewsRows(parm);
			page1.setRows(rows1);
			String newsPage =JSONObject.fromObject(page1).toString();
			String newsList = JSONArray.fromObject(newsList1).toString();
			//数据传给页面
			json = "{'result':'true','newsList':"+newsList+",'newsPage':"+newsPage+"}";
			break;
		case 2:
			parm.put("page", page2);
			List<News> newsList2 = newsService.searchNewsInfo(parm);
			int rows2 = newsService.searchNewsRows(parm);
			page2.setRows(rows2);
			String noticePage = JSONObject.fromObject(page2).toString();
			String noticeList = JSONArray.fromObject(newsList2).toString();
			json = "{'result':'true','noticeList':"+noticeList+",'noticePage':"+noticePage+"}";
			break;
		case 3:
			parm.put("page", page3);
			List<News> newsList3 = newsService.searchNewsInfo(parm);
			int rows3 = newsService.searchNewsRows(parm);
			page3.setRows(rows3);
			String industryNewsPage = JSONObject.fromObject(page3).toString();
			String industryNewsList = JSONArray.fromObject(newsList3).toString();
			json = "{'result':'true','industryNewsList':"+industryNewsList+",'industryNewsPage':"+industryNewsPage+"}";
			break;	
		}
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
	}
	return json;
}

}
