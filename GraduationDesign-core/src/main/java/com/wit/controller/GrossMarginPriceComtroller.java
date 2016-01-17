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

import com.wit.model.CompanyProductPrice;
import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductType;
import com.wit.model.Products;
import com.wit.service.CompanyProductPriceService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductTypeService;
import com.wit.service.ProductsService;
@Controller
@RequestMapping("/grossMarginPrice")
public class GrossMarginPriceComtroller {
	@Autowired
	private ProductsService productsService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductTypeService productTypeService;
	@Autowired
	private CompanyProductPriceService companyProductPriceService;
	/**
	 * grossMarginPrice列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/grossMarginPriceList")
	public String productsList1(Page page, Model model) {
		try {
		List<Products> products = productsService.findAll(page);
		for(Products p:products){
			System.out.println(p);
		}
		model.addAttribute("products", products);
		int rows = productsService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		return "Manager/products/grossMarginPriceList";
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
	@RequestMapping("/deleteProduct")
	public String deleteProduct(Integer id, Model model) {
		try {
		productsService.deleteById(id);
		return "redirect:grossMarginPriceList.do";
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
	@RequestMapping("/toAddGrossMarginPrice")
	public String toAddGrossMarginPrice(Model model) {
		try {
		List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
		model.addAttribute("productCategorys",productCategorys);
		List<ProductType> productTypes= productTypeService.getAll();
		model.addAttribute("productTypes",productTypes);
		return "Manager/products/grossMarginPriceAdd";
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
	@RequestMapping("/addProssMarginPrice")
	public String addProssMarginPrice(Products product, Model model) {
		try {
		productsService.insert(product);
		return "redirect:grossMarginPriceList.do";
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
	@RequestMapping("/toUpdategrossMarginPrice")
	public String toUpdateProduct(Integer id, Model model) {
		try {
		Products product = productsService.findById(id);
		model.addAttribute("product", product);
		return "Manager/products/grossMarginPriceUpdate";
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
	@RequestMapping("/toGrossProductInfo")
	public String toGrossProductInfo(Integer id, Model model) {
		try {
		Products product = productsService.findById(id);	
		model.addAttribute("product", product);
		return "Manager/products/grossProductInfo";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
	}
	/**
	 * 进入品类详情页
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toCompanyProductPrice")
	public String toCompanyProductPrice(Integer companyId,Integer productId, Model model) {
		try {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("companyId", companyId);
		map.put("productId", productId);
		CompanyProductPrice companyProductPrice = companyProductPriceService.findByIds(map);
		model.addAttribute("companyProductPrice", companyProductPrice);
		return "Manager/products/companyProductPriceInfo";
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
	@RequestMapping("/updategrossMarginPrice")
	public String updategrossMarginPrice(Products product, Model model) {
		try {
		productsService.update(product);
		return "redirect:grossMarginPriceList.do";
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
