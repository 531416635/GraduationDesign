package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Page;
import com.wit.model.ProductType;
import com.wit.service.ProductTypeService;

@Controller
@RequestMapping("productType")
public class ProductTypeController {
@Autowired
private ProductTypeService productTypeService;

@RequestMapping("productTypeList")
public String productTypeList(Page page,Model model){
	String json="";
	try {
	List<ProductType> productTypes = productTypeService.getAlls(page);
	model.addAttribute("productTypes", productTypes);
	int rows = productTypeService.findRows();
	page.setRows(rows);
	model.addAttribute("page", page);
	json=JSONObject.fromObject(page).toString();
	model.addAttribute("json", json);
	return "Manager/products/productTypeList";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 删除品类信息
 * @param id
 * @return
 */
@RequestMapping("/deleteProductType")
public String deleteProductType(Integer id,Model model) {
	try {
	productTypeService.delete(id);
	return "redirect:productTypeList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
}
/**
 * 进入添加页面
 * @param model
 * @return
 */
@RequestMapping("/toAddProductType")
public String toAddProductType(Model model) {
	try {
	List<ProductType> productTypes= productTypeService.getAll();
	model.addAttribute("productTypes",productTypes);
	return "Manager/products/productTypeAdd";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 新添品类信息
 * @param productCategory
 * @return
 */
@RequestMapping("/addProductType")
public String addProductType(ProductType productType,Model model){
	try {
	productTypeService.add(productType);
		return "redirect:productTypeList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
	}
/**
 *进入更新页面
 * @param id
 * @param model
 * @return
 */
@RequestMapping("/toUpdateProductType")
public String toUpdateProductType(Integer id,Model model ){
	try {
	List<ProductType> productTypes= productTypeService.getAll();
	model.addAttribute("productTypes",productTypes);
	ProductType productType= productTypeService.findbyId(id);
	model.addAttribute("productType",productType);
	return "Manager/products/productTypeUpdate";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
/**
 * 更新信息
 * @param productType
 * @return
 */
@RequestMapping("/updateProductType")
public String updateProductType(ProductType productType,Model model){
	try {
	productTypeService.update(productType);
		return "redirect:productTypeList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
	}
/**
 * 批量删除
 * @param request
 * @param response
 */
@RequestMapping("/allDeleteDis") 
public void deleteMore(HttpServletRequest request, HttpServletResponse response) { 
	try {
	String sid = request.getParameter("Uid");
	productTypeService.deleteByIds(sid);
	} catch (Exception e) {
		e.printStackTrace();
	}
} 

}
