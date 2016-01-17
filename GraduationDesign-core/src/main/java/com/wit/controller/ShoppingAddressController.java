package com.wit.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Page;
import com.wit.model.ShoppingAddress;
import com.wit.service.ShoppingAddressService;

@Controller
@RequestMapping("shoppingAddress")
public class ShoppingAddressController {
	@Autowired
	private ShoppingAddressService shoppingAddressService;
/**
 * 购物地址列表
 * @param page
 * @param model
 * @return
 */
@RequestMapping("shoppingAddressList")
public String shoppingAddressList(Page page,Model model){
	try {
	List<ShoppingAddress> shoppingAddresss =shoppingAddressService.getAlls(page);
	model.addAttribute("shoppingAddresss", shoppingAddresss);
	int rows = shoppingAddressService.findRows();
	page.setRows(rows);
	model.addAttribute("page", page);
	return "Manager/products/shoppingAddressList";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 购物地址删除
 * @param id
 * @return
 */
@RequestMapping("shoppingAddressDelete")
public String shoppingAddressDelete(Integer id,Model model){
	try {
	shoppingAddressService.delete(id);
	return "redirect:shoppingAddressList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
}
/**
 * 进入购物地址添加页面
 * @param model
 * @return
 */
@RequestMapping("toShoppingAddressAdd")
public String toShoppingAddressAdd(Model model){
	try {
	return "Manager/products/shoppingAddressAdd";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 购物地址添加
 * @param shoppingAddress
 * @return
 */
@RequestMapping("shoppingAddressAdd")
public String shoppingAddressAdd(ShoppingAddress shoppingAddress,Model model){
	try {
	shoppingAddressService.addPurchaserAddress(shoppingAddress);
	return "redirect:shoppingAddressList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
}
/**
 * 进入购物地址更新页面
 * @param id
 * @param model
 * @return
 */
@RequestMapping("toshoppingAddressUpdate")
public String toshoppingAddressUpdate(Integer id,Model model){
	try {
	ShoppingAddress shoppingAddress=shoppingAddressService.findbyId(id);
	model.addAttribute("shoppingAddress", shoppingAddress);
	return "Manager/products/shoppingAddressUpdate";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 购物地址更新
 * @param shoppingAddress
 * @return
 */
@RequestMapping("shoppingAddressUpdate")
public String shoppingAddressUpdate(ShoppingAddress shoppingAddress,Model model){
	try {
	shoppingAddressService.update(shoppingAddress);
	return "redirect:shoppingAddressList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
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
	shoppingAddressService.deleteByIds(sid);
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
	}
}
}
