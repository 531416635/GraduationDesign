package com.wit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Favorite;
import com.wit.model.Page;
import com.wit.model.Products;
import com.wit.model.Users;
import com.wit.service.FavoriteService;
import com.wit.service.ProductsService;

@Controller
@RequestMapping("/favorite")
public class ProductFavoriteController {
	@Autowired
	private FavoriteService favoriteService;
	@Autowired
	private ProductsService productsService;
	/**
	 * 收藏列表
	 * @param page
	 * @param userID
	 * @param model
	 * @return
	 */
	@RequestMapping("/favoriteList")
	public String productsList(Page page,HttpServletRequest request) {
		try {
			Users user = (Users)request.getSession().getAttribute("userInfo");
		Map<String, Object> map = 
				new HashMap<String, Object>();
		map.put("page", page);
		map.put("userID", user.getId());
		List<Favorite> favorites = favoriteService.getAlls(map);
		request.setAttribute("favorites", favorites);
		int rows = favoriteService.findRows(user.getId());
		page.setRows(rows);
		request.setAttribute("page", page);
		return "Manager/products/favoriteList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 删除收藏
	 * @param id
	 * @param userID
	 * @return
	 */
	@RequestMapping("favoriteDelete")
	public String favoriteDelete(Integer id, Model model){
		try {
		favoriteService.delete(id);
		return "redirect:favoriteList.do";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
	/**
	 * 转到添加收藏页面
	 * @return
	 */
	@RequestMapping("tofavoriteAdd")
	public String tofavoriteAdd(HttpServletRequest request){
		try {
		return "Manager/products/favoriteAdd";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 添加收藏
	 * @param favorite
	 * @return
	 */
	@RequestMapping("favoriteAdd")
	public String favoriteAdd(Favorite favorite, HttpServletRequest request){
		try {
			Users user = (Users)request.getSession().getAttribute("userInfo");
			favorite.setUserId(user.getId());
		favoriteService.add(favorite);
		return "redirect:favoriteList.do";
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
		
	}
	/**
	 * 进入修改页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("tofovoriteUpdate")
	public String tofovoriteUpdate(Integer id,Model model){
		try {
		Favorite favorite = favoriteService.findbyId(id);
		model.addAttribute("favorite",favorite);
		return "Manager/products/favoriteUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 修改收藏信息
	 * @param favorite
	 * @return
	 */
	@RequestMapping("fovoriteUpdate")
	public String fovoriteUpdate(Favorite favorite,HttpServletRequest request){
		try {
		Users user =(Users)request.getSession().getAttribute("userInfo"); 
		favorite.setUserId(user.getId());
		favoriteService.update(favorite);
		return "redirect:favoriteList.do";
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
	/**
	 * 批量删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/allDeleteDis")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		try {
		String sid = request.getParameter("Uid");
		favoriteService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}
	/**
	 * 列出收藏信息
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("favoriteProductInfo")
	public String favoriteProductInfo(Integer id,Model model){
		try {
		Products product =productsService.findById(id);
		model.addAttribute("product",product);
		return "Manager/products/favoriteProductInfo";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}

}
