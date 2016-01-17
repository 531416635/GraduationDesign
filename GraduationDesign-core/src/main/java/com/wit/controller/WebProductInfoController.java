package com.wit.controller;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Deque;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Common;
import com.wit.model.CompanyContracts;
import com.wit.model.Companys;
import com.wit.model.Dictionarys;
import com.wit.model.Favorite;
import com.wit.model.InquirySheet;
import com.wit.model.Orders;
import com.wit.model.ProductCategory;
import com.wit.model.ProductPic;
import com.wit.model.ProductReview;
import com.wit.model.ProductSample;
import com.wit.model.Products;
import com.wit.model.SecondPage;
import com.wit.model.ShoppingAddress;
import com.wit.model.ShoppingCart;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.service.CompanyContractService;
import com.wit.service.CompanyProductsService;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.FavoriteService;
import com.wit.service.InquirySheetService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductReviewService;
import com.wit.service.ProductsService;
import com.wit.service.ShoppingCartService;
import com.wit.service.SystemLogsService;

/**
 * 门户三级界面相关操作
 * 
 * @author chenqiulong
 * 
 */
@Controller
@RequestMapping("/web")
public class WebProductInfoController {
	@Autowired
	private ProductsService productsService;
	@Autowired
	private ProductPicService productPicService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductReviewService productReviewService;
	@Autowired
	private ShoppingCartService shoppingCartService;
	@Autowired
	private FavoriteService favoriteService;
	@Autowired
	private InquirySheetService inquirySheetService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private CompanysService companyService;
	@Autowired
	private CompanyContractService companyContractService;
	@Autowired
	private SystemLogsService systemLoggerService;
	@Autowired
	private CompanyProductsService companyProductsService;

	/**
	 * 添加到我的购物
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/addShoppingCart", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String addShoppingCart(HttpServletRequest request) {
		String json = "false";
		int productId = Integer.parseInt(request.getParameter("productId"));
		String address = request.getParameter("address");
		int buyNum = 0;
		if (request.getParameter("buyNum") != null) {
			buyNum = Integer.parseInt(request.getParameter("buyNum"));
		}
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "1"; // 未登录
		}
		Integer companyId = ((Users) user).getCompanyId();
		Companys company = companyService.webfindById(companyId);
		switch (company.getStatus()) {
		case 0:
			return "2"; // 未认证

		case 3:
			return "3"; // 等待认证
		}
		// 合同是否在有效期
		List<CompanyContracts> companyContracts = companyContractService
				.checkCompanyContractsByCompanyId(companyId);
		if (companyContracts.size() == 0) {
			// 该公司未签署协议,返回上一页
			return "4";
		}
		if (company.getCompanyType() == null || company.getCompanyType() == 3) {
			return "5"; // 供应商
		}
		ShoppingCart shoppingCart = new ShoppingCart();

		shoppingCart.setAddress(address);
		shoppingCart.setProductId(productId);
		shoppingCart.setUserId(((Users) user).getId());
		shoppingCart.setStatus(0);
		String productType = request.getParameter("productType");
		if (productType != null) {

			if (productType.equals("2")) {
				shoppingCart.setShopType(2);
				shoppingCart.setProductQuantity(new BigDecimal(1));
			}
		} else {
			shoppingCart.setShopType(1);
			shoppingCart.setProductQuantity(new BigDecimal(buyNum));
		}

		try {
			shoppingCartService.AddShoppingCart(shoppingCart);
			json = "true";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	/**
	 * 添加到询价单
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/AddInquirySheet", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddInquirySheet(HttpServletRequest request) {
		String json = "{'result':'false'}";
		int productId = Integer.parseInt(request.getParameter("productId"));
		Object user = request.getSession().getAttribute("user");
		// 判断用户是否登录
		if (user == null) {
			return "{'result':'1'}";
		}
		Integer companyId = ((Users) user).getCompanyId();
		Companys company = companyService.webfindById(companyId);
		String address = request.getParameter("address");
		int buyNum = Integer.parseInt(request.getParameter("buyNum"));
		// 判断公司状态是否已认证
		// System.out.println(company.getStatus());
		switch (company.getStatus()) {
		case 0:
			return "{'result':'2'}";
			/*
			 * case 1: return "{result:'true',inquiryId:'" +
			 * inquirySheet.getInquiryId() + "'}";
			 */
		case 3:
			return "{'result':'3'}";
		}
		// 公司合同信息
		// 判断公司是否签订合同
		// 合同是否在有效期
		List<CompanyContracts> companyContracts = companyContractService
				.checkCompanyContractsByCompanyId(companyId);
		if (companyContracts.size() == 0) {
			// 该公司未签署协议,返回上一页
			return "{'result':'4'}";
		}
		if (company.getCompanyType() == null || company.getCompanyType() == 3) {
			return "{'result':'5'}"; // 供应商
		}
		/******************/
		try {
			InquirySheet inquirySheet = new InquirySheet();
			Products product = productsService.findById(productId);
			// 生成询价单号
			inquirySheet.setProductID(productId);
			inquirySheet.setUserId(((Users) user).getId());
			inquirySheet.setProductQuantity(new BigDecimal(buyNum));
			inquirySheet.setAddress(address);
			inquirySheet.setCurrency("CNY");
			inquirySheet.setProductModel(product.getProductModel());
			inquirySheet.setProductUnit(product.getProductUnit());
			inquirySheet.setRefPrice(product.getUnitPrice());
			inquirySheetService.add(inquirySheet);
			if (inquirySheet.getInquiryId() != null) {
				json = "{result:'true',inquiryId:'"
						+ inquirySheet.getInquiryId() + "'}";
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	/**
	 * 添加到我的收藏
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/AddFavorite", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddFavorite(HttpServletRequest request) {
		String json = "false";
		int productId = Integer.parseInt(request.getParameter("productId"));
		String address=request.getParameter("address");
		int favoriteType=Integer.parseInt(request.getParameter("favoriteType"));
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "1"; // 未登录
		}
		Integer companyId = ((Users) user).getCompanyId();
		Companys company = companyService.webfindById(companyId);
		switch (company.getStatus()) {
		case 0:
			return "2"; // 未认证
		case 3:
			return "3"; // 等待认证
		}

		// 合同是否在有效期
		List<CompanyContracts> companyContracts = companyContractService
				.checkCompanyContractsByCompanyId(companyId);
		if (companyContracts.size() == 0) {
			// 该公司未签署协议,返回上一页
			return "4";
		}

		if (company.getCompanyType() == null || company.getCompanyType() == 3) {

			return "5"; // 供应商

		}
		Integer userId = ((Users) user).getId();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("productId", productId);
		param.put("favoriteType", favoriteType);
		param.put("userId", userId);
		if (favoriteService.findbyProdcutId(param) != null) {
			return "6"; // 已收藏
		}
		Favorite favorite = new Favorite();
		favorite.setProductId(productId);
		favorite.setUserId(userId);
		favorite.setFavoriteType(favoriteType);
		favorite.setFavoriteAddress(address.toString());
		try {
			favoriteService.add(favorite);
			json = "true";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 省市区三级联动关联查询
	@RequestMapping(value = "/provinceLinkage", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String provinceUrbanLinkage(Integer id, HttpServletRequest request,
			HttpServletResponse response) {
		String json = null;
		try {
			// 根据父ID查询其包含的地区
			List<Dictionarys> dictionarys = dictionaryService
					.findByParentId(id);
			json = JSONArray.fromObject(dictionarys).toString();
			// request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "false";
		}
		return json;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/toProductInfo")
	public String toProductInfo(SecondPage page, Integer ProductId,
			HttpServletRequest request) {
		String jsonAddrs = "";

		// 品类展示
		try {
			List<ProductCategory> productCategorys = null;
			Object objpc = request.getSession()
					.getAttribute("productCategorys");
			if (objpc != null) {
				productCategorys = (List<ProductCategory>) objpc;
			} else {
				productCategorys = productCategoryService.getWebAll();// .findProductCategory();
				request.getSession().setAttribute("productCategorys",
						productCategorys);
			}

			List<ProductCategory> sunProductCategorys = null;
			Object objsunpc = request.getSession().getAttribute(
					"sunProductCategorys");
			if (objpc != null) {
				sunProductCategorys = (List<ProductCategory>) objsunpc;
			} else {
				sunProductCategorys = productCategoryService.getWebAllSun();
				request.getSession().setAttribute("sunProductCategorys",
						sunProductCategorys);
			}
			request.setAttribute("productCategorys", productCategorys);
			request.setAttribute("sunProductCategorys", sunProductCategorys);
		} catch (Exception ex) {
		}
		// 查询省份信息（用户选择地区）
		try {
			List<Dictionarys> dictionarys = dictionaryService
					.findProvinceInfo();
			request.setAttribute("dictionarys", dictionarys);
			List<Dictionarys> addrs = dictionaryService.getDicsByDicType(1);
			jsonAddrs = JSONArray.fromObject(addrs).toString();
			request.setAttribute("jsonAddrs", jsonAddrs);
		} catch (Exception ex) {
		}
		// 精品推荐
		String isSub = "1";
		String isHot = "";
		String isHome = "";
		String superclass = "";
		List<Products> subpageShows = productsService.findProductsByCategory(
				page, superclass, isHot, isHome, isSub);
		request.setAttribute("subpageShows", subpageShows);
		// 获取商品详情并存入最近浏览Session中！
		try {

			Products product = productsService.findWebById(ProductId);
			// 判断session是否登陆
			Users user = (Users) request.getSession().getAttribute("user");
			if (user != null) {
				// 添加访问日志
				SystemLogs form = new SystemLogs();
				StringBuilder sb = new StringBuilder();
				sb.append(Common.getDateTimeNow());
				sb.append(user.getUserName());
				sb.append("浏览了商品：");
				sb.append(product.getProductName());
				sb.append("，商品ID：");
				sb.append(product.getId());
				form.setLogContent(sb.toString());
				form.setLogTime(Common.getDateTimeNow());
				form.setLogType(user.getUserType());
				form.setLogBy(user.getId());
				this.systemLoggerService.AddLog(form);
			}

			// 最近浏览Session中！
			List<Products> viewPros = new ArrayList<Products>();
			Object viewProducts = request.getSession().getAttribute(
					"viewProducts");
			if (viewProducts != null) {
				viewPros = (List<Products>) viewProducts;
				for (int i = 0; i < viewPros.size(); i++) {
					if (!viewPros.get(i).getId().equals(product.getId())) {
						if ((i + 1) == viewPros.size()) {
							if (viewPros.size() >= 10) {
								viewPros.remove(0);
							}
							viewPros.add(product);
						}
					}
				}
				/*
				 * 这里为什么总是插入两次相同数据？？？？ for(int i=viewPros.size()-1;i>=0;i--){
				 * if(!viewPros.get(i).getId().equals(product.getId())){
				 * if(i==0){ if(viewPros.size()>=10){
				 * System.out.println("******************"
				 * +'\n'+'\n'+'\n'+'\n'+'\n'+'\n');
				 * System.out.println(viewPros.remove(i));
				 * System.out.println('\n'
				 * +'\n'+'\n'+'\n'+'\n'+"******************"); }
				 * viewPros.add(product); } } }
				 */
			} else {
				viewPros.add(product);
			}
			//product.setProductPics(null);
			request.setAttribute("product", product);
			request.setAttribute("productJson", JSONObject.fromObject(product).toString());  //便于前台展现多个规格！
			request.getSession().setAttribute("viewProducts", viewPros);
			// 获取商品品类
			/*
			 * List<ProductCategory> productCategoryItems =
			 * productCategoryService
			 * .getCateGoryByIds(product.getProductCategory());
			 */
			request.setAttribute("productCategoryItems",
					product.getProductCategorys()); 
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		// 获取商品图片
		try {

			List<ProductPic> productPics = productPicService.getProductPicByProductId(ProductId);
			request.setAttribute("productPic", productPics);
		} catch (Exception ex) {
		}

		// 获取商品有机认证

		// 获取商品评价
		try {

			List<ProductReview> productReviews = productReviewService
					.getReviewByProductID(ProductId);
			request.setAttribute("productReviews", productReviews);
		} catch (Exception ex) {
		}

		// 获取商品小样
		try {

			// 判断session是否登陆
			Users user = (Users) request.getSession().getAttribute("user");
			// List<ProductSample> productSamples=new ArrayList<>();
			// ProductSample productSample=new ProductSample();
			String json = "";
			if (user != null) {

				Map<String, Object> parm = new HashMap<>();
				parm.put("page", page);
				parm.put("supplierId", user.getId());
				parm.put("productId", ProductId);
				List<Map<String, Object>> productSamples = productsService
						.selectProductSample(parm);
				request.setAttribute("productSamples", productSamples);

				int rows = productsService.findRowsSamples(parm);
				page.setRows(rows);
				request.setAttribute("page", page);
				json = JSONObject.fromObject(page).toString();
				request.setAttribute("json", json);

				// 查询商品小样是否可申请状态
				Map<String, Integer> par = new HashMap<>();
				par.put("ProductId", ProductId);
				par.put("companyId", user.getCompanyId());

				int findProductSample = companyProductsService
						.findProductSample(par);

				request.setAttribute("findProductSample", findProductSample);

			}

		} catch (Exception e) {
			// TODO: handle exception

		}

		return "website/productsInfo";
	}

}
