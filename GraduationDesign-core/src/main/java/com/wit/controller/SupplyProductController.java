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
import com.wit.model.CompanyProductPriceLog;
import com.wit.model.CompanyProducts;
import com.wit.model.GrossMargin;
import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductType;
import com.wit.model.Products;
import com.wit.model.Users;
import com.wit.service.CompanyProductPriceLogService;
import com.wit.service.CompanyProductPriceService;
import com.wit.service.CompanyProductsService;
import com.wit.service.GrossMarginService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductTypeService;
import com.wit.service.ProductsService;

@Controller
@RequestMapping("/supplyCompanyProducts")
public class SupplyProductController extends BaseController {
	@Autowired
	private CompanyProductsService companyProductsService;
	@Autowired
	private CompanyProductPriceService companyProductPriceService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductTypeService productTypeService;
	@Autowired
	private ProductsService productsService;
	@Autowired
	private GrossMarginService grossMarginService;	
	@Autowired
	private CompanyProductPriceLogService companyProductPriceLogService;
	@RequestMapping("/companyProductsList")
	public String companyProductsList(Page page,HttpServletRequest request) {
		try {
			Users user = (Users)request.getSession().getAttribute("userInfo");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("companyId", user.getCompanyId());
			map.put("page", page);
			List<CompanyProducts> companyProducts = companyProductsService
					.findCompanyProductsbyCompanyId(map);
			request.setAttribute("companyProducts", companyProducts);
			int rows = companyProductsService.findRowsbyCompanyId(user.getCompanyId());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/products/supplyCompanyProductsList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 删除供应商商品
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteCompanyProducts")
	public String deleteCompanyProducts(Integer id,Model model) {
		try {
			companyProductsService.deleteCompanyProduct(id);
			return "redirect:companyProductsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 批量删除供应商商品信息
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/deleteMore")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			companyProductsService.deleteCompanyProductByIds(sid);	
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}
	/**
	 * 进入添加供应商商品页面
	 * 
	 * @return
	 */
	@RequestMapping("/toAddCompanyProducts")
	public String toAddCompanyProducts(Model model) {
		try {
			List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
			model.addAttribute("productCategorys",productCategorys);
			List<ProductType> productTypes= productTypeService.getAll();
			model.addAttribute("productTypes",productTypes);
			return "Manager/products/supplyCompanyProductsAdd";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 添加供应商商品信息
	 * 
	 * @param companyProduct
	 * @return
	 */
	@RequestMapping("/addCompanyProducts")
	public String addCompanyProducts(CompanyProducts companyProduct,Products product,HttpServletRequest request) {
		try {
			List<Integer> productTypeIds = product.getProductTypeIds();
			StringBuilder str = new StringBuilder();
			for(Integer id :productTypeIds){
				str.append(id);
				str.append(",");
			}
			//product.setProductType(str.toString());
			productsService.insert(product);
			Users user = (Users)request.getSession().getAttribute("userInfo");
			companyProduct.setCompanyId(user.getCompanyId());
			companyProduct.setProductId(product.getId());
			companyProductsService.addCompanyProduct(companyProduct);
			return "redirect:companyProductsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 进入供应商商品更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toUpdateCompanyProducts")
	public String toUpdateCompanyProducts(Integer id, Model model) {
		try {
			List<ProductCategory> productCategorys= productCategoryService.findProductCategory();
			model.addAttribute("productCategorys",productCategorys);
			List<ProductType> productTypes= productTypeService.getAll();
			model.addAttribute("productTypes",productTypes);
			CompanyProducts companyProduct = companyProductsService
					.findbyIds(id);
			model.addAttribute("companyProduct", companyProduct);
			return "Manager/products/supplyCompanyProductUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 更新供应商商品信息
	 * 
	 * @param companyProduct
	 * @return
	 */
	@RequestMapping("/updateCompanyProducts")
	public String updateProduct(CompanyProducts companyProduct,Products product, HttpServletRequest request) {
		try {
			product.setId(companyProduct.getProductId());
			List<Integer> productTypeIds = product.getProductTypeIds();
			StringBuilder str = new StringBuilder();
			for(Integer id :productTypeIds){
				str.append(id);
				str.append(",");
			}
			//product.setProductType(str.toString());
			productsService.update(product);
			Users user = (Users)request.getSession().getAttribute("userInfo");
			companyProduct.setCompanyId(user.getCompanyId());
			companyProductsService.updateCompanyProducts(companyProduct);
			return "redirect:companyProductsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	@RequestMapping("/toCompanyProductPriceInfo")
	public String toCompanyProductPriceInfo(Page page,Integer id, Model model) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("page", page);
			List<CompanyProductPrice> companyProductPrices = companyProductPriceService
					.findByCompanyProductIds(map);
			int rows = companyProductPriceService.findRows(id);
			page.setRows(rows);
			List<CompanyProductPriceLog>companyProductPriceLogs = companyProductPriceLogService.findAllByCompanyProductId(id);
			model.addAttribute("companyProductPriceLogs", companyProductPriceLogs);
			model.addAttribute("page", page);
			model.addAttribute("companyProductPrices", companyProductPrices);
			model.addAttribute("companyProductId", id);
			return "Manager/products/supplyCompanyProductsPriceList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 添加价格信息
	 * 
	 * @param companyProductPrice
	 * @param grossMargin
	 * @param model
	 * @return
	 */
	@RequestMapping("companyProductPriceAdd")
	public String companyProductPriceAdd(
			CompanyProductPrice companyProductPrice, GrossMargin grossMargin,
			Model model) {
		try {
			grossMarginService.addGrossMarginr(grossMargin);
			companyProductPrice.setGrossmMarginPriceId(grossMargin.getId());
			companyProductPriceService.insert(companyProductPrice);
			return "redirect:toCompanyProductPriceInfo.do?id="
					+ companyProductPrice.getCompanyProductId();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 进入价格更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("toCompanyProductPriceUpdate")
	public String toCompanyProductPriceUpdate(Integer id, Model model) {
		try {
			CompanyProductPrice companyProductPrice = companyProductPriceService
					.findById(id);
			model.addAttribute("companyProductPrice", companyProductPrice);
			return "Manager/products/supplyCompanyProductsPriceUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 价格更新
	 * 
	 * @param companyProductPrice
	 * @param grossMargin
	 * @return
	 */
	@RequestMapping("companyProductPriceUpdate")
	public String companyProductPriceUpdate(
			CompanyProductPrice companyProductPrice,CompanyProductPriceLog companyProductPriceLog, GrossMargin grossMargin, Model model) {
		try {
			grossMargin.setId(companyProductPrice.getGrossmMarginPriceId());
			companyProductPriceService.update(companyProductPrice);
			grossMarginService.updateGrossMargin(grossMargin);
			companyProductPriceLogService.insert(companyProductPriceLog);
			return "redirect:toCompanyProductPriceInfo.do?id="
					+ companyProductPrice.getCompanyProductId();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}


}
