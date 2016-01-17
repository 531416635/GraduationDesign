package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.service.ProductCategoryService;
/**
 * 商品品类管理
 * @author chenqiulong
 *
 */
@Controller
@RequestMapping("/productCategory")
public class ProductCategoryController {
	
	@Autowired
	private ProductCategoryService productCategoryService;
/**
 * 商品品类列表
 * @param model
 * @return
 */
	/*@RequestMapping("/productCategoryList")
	public String productCategoryList(Model model) {
		try {
		List<ProductCategory> productCategorys = productCategoryService.findProductCategory();
		model.addAttribute("productCategorys", JSONArray.fromObject(productCategorys).toString());
		return "Manager/products/productCategoryList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}*/
	
		@RequestMapping("/productCategoryList")  
	    public String toproductCategoryList(Model model){  
			
			List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
			String json=JSONArray.fromObject(productCategorys).toString();
			model.addAttribute("productCategorys",json.replaceAll("cateGoryName", "name").replaceAll("parentCateGory", "pId"));
	         return "Manager/products/productCategoryList";  
	    }
	    @RequestMapping(value = "/productCategoryLists", produces = { "application/json;charset=UTF-8" })  
	    @ResponseBody  
	    public String getproductCategoryList(@RequestParam(defaultValue="0")int pid) throws Exception{  
	    	List<ProductCategory> productCategorys= productCategoryService.getChildrens(pid);
	    	return 	JSONArray.fromObject(productCategorys).toString();  
	    }  

	    
	/**
	 * 删除品类信息
	 * @param id
	 * @return
	 */
	    @RequestMapping(value = "/deleteProductCategory", produces = { "application/json;charset=UTF-8" })  
	    @ResponseBody
		public String deleteProductCategory(HttpServletRequest request) {
	    	Integer id = Integer.valueOf(request.getParameter("id")) ;
			String result="false";
			try {
			productCategoryService.deleteProductCategory(id);
			result="true";
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}
			return result;
		}
	/**
	 * 进入添加页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/toAddProductCategory")
	public String toAddProductCategory(Model model) {
		try {
		List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
		model.addAttribute("productCategorys",productCategorys);
		return "Manager/products/productCategoryAdd";
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
	@RequestMapping(value = "/addProductCategory", produces = { "application/json;charset=UTF-8" })  
    @ResponseBody  
	public String addProductCategory(ProductCategory productCategory,Model model){
		String json = "{result:'false'}";
		try {
		productCategoryService.addProductCategory(productCategory);
		json = "{result:'true',categoryId:'"+productCategory.getId()+"'}";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
		return json;
		}
	/**
	 *进入更新页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toUpdateProductCategory")
	public String toUpdateProductCategory(Integer id,Model model ){
		try {
		List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
		model.addAttribute("productCategorys",productCategorys);
		ProductCategory productCategory = productCategoryService.findbyId(id);
		model.addAttribute("productCategory",productCategory);
			return "Manager/products/productCategoryUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		}
	/**
	 * 更新信息
	 * @param productCategory
	 * @return
	 */
	@RequestMapping(value = "/updateProductCategory", produces = { "application/json;charset=UTF-8" })  
    @ResponseBody
	public String updateProductCategory(ProductCategory productCategory,Model model){
		String result="false";
		try {
		productCategoryService.updateProductCategory(productCategory);
		result="true";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
		return result;
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
		productCategoryService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	} 
}
