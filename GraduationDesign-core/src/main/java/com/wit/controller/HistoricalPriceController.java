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

import com.wit.model.CompanyProductPriceLog;
import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductType;
import com.wit.model.Products;
import com.wit.service.CompanyProductPriceLogService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductTypeService;
import com.wit.service.ProductsService;

@Controller
@RequestMapping("/historicalPrice")
public class HistoricalPriceController {
	@Autowired
	private ProductsService productsService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductTypeService productTypeService;
	@Autowired
	private CompanyProductPriceLogService companyProductPriceLogService;
	/**
	 * 商品列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/historicalPriceList")
	public String historicalPriceList(Page page, Model model) {
		try {
		List<Products> products = productsService.findAll(page);
		model.addAttribute("products", products);
		int rows = productsService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		return "Manager/products/historicalPriceList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 删除商品
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteHistoricalPrice")
	public String deleteHistoricalPrice(Integer id, Model model) {
		try {
		productsService.deleteById(id);
		return "redirect:historicalPriceList.do";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}

	/**
	 * 进入添加商品页面
	 * 
	 * @return
	 */
	@RequestMapping("/toAddHistoricalPrice")
	public String toAddHistoricalPrice(Model model) {
		try {
		List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
		model.addAttribute("productCategorys",productCategorys);
		List<ProductType> productTypes= productTypeService.getAll();
		model.addAttribute("productTypes",productTypes);
		return "Manager/products/historicalPriceAdd";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 添加商品
	 * 
	 * @param product
	 * @return
	 */
	@RequestMapping("/addHistoricalPrice")
	public String addHistoricalPrice(Products product, Model model) {
		try {
			List<Integer> productTypeIds = product.getProductTypeIds();
			StringBuilder str = new StringBuilder();
			for(Integer id :productTypeIds){
				str.append(id);
				str.append(",");
			}
			//product.setProductType(str.toString());
		productsService.insert(product);
		return "redirect:historicalPriceList.do";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
	

	/**
	 * 进入更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toUpdateHistoricalPrice")
	public String toUpdateHistoricalPrice(Integer id, Model model) {
		try {
			List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
			model.addAttribute("productCategorys",productCategorys);
			List<ProductType> productTypes= productTypeService.getAll();
			model.addAttribute("productTypes",productTypes);	
		Products product = productsService.findById(id);
		model.addAttribute("product", product);
		return "Manager/products/historicalPriceUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 进入详情商品详情页
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toHistoricalPriceInfo")
	public String toHistoricalPriceInfo(Page page,Integer id, Model model) {
		try {
		/*Products product = productsService.findById(id);	
		model.addAttribute("product", product);*/
			Map<String,Object> maps = new HashMap<String,Object>();
			maps.put("page", page);
			maps.put("productId",id);
			List<CompanyProductPriceLog> companyProductPriceLogs =companyProductPriceLogService.findAllByCompanyId(maps);
			System.out.println(companyProductPriceLogs);
			model.addAttribute("companyProductPriceLogs", companyProductPriceLogs);
			int rows = companyProductPriceLogService.findRows(id);
			page.setRows(rows);
			model.addAttribute("page", page);
		return "Manager/products/historicalPriceInfoList";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}


	/**
	 * 更新商品
	 * 
	 * @param product
	 * @return
	 */
	@RequestMapping("/updateHistoricalPrice")
	public String updateHistoricalPrice(Products product, Model model) {
		try { 
			List<Integer> productTypeIds = product.getProductTypeIds();
			StringBuilder str = new StringBuilder();
			for(Integer id :productTypeIds){
				str.append(id);
				str.append(",");
			}
			//product.setProductType(str.toString());
		productsService.update(product);
		return "redirect:historicalPriceList.do";
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
		productsService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}
}
