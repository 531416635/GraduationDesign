package com.wit.controller;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Cache;
import com.wit.comm.CacheManager;
import com.wit.comm.Common;
import com.wit.model.CompanyProducts;
import com.wit.model.Companys;
import com.wit.model.Dictionarys;
import com.wit.model.DispatchBill;
import com.wit.model.InquirySheet;
import com.wit.model.Invoice;
import com.wit.model.Orders;
import com.wit.model.Page;
import com.wit.model.ProductCategory;
import com.wit.model.ProductPic;
import com.wit.model.ProductReview;
import com.wit.model.Products;
import com.wit.model.SecondPage;
import com.wit.model.ShoppingAddress;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.model.newOrNoticePage;
import com.wit.service.CompanyContractService;
import com.wit.service.CompanyProductsService;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.DispatchBillService;
import com.wit.service.GrouponService;
import com.wit.service.InquirySheetService;
import com.wit.service.InvoiceService;
import com.wit.service.OrdersService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductsService;
import com.wit.service.ShoppingAddressService;
import com.wit.service.SystemLogsService;
import com.wit.service.UserManagerService;

@Controller
@RequestMapping("/web")
public class WebGrouponController {

	@Autowired
	private GrouponService grouponService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private ProductsService productsService;
	@Autowired
	private SystemLogsService systemLoggerService;
	@Autowired
	private ProductPicService productPicService;
	@Autowired
	private CompanysService companyService;
	@Autowired
	private CompanyContractService companyContractService;
	@Autowired
	private InquirySheetService inquirySheetService;
	@Autowired
	private OrdersService ordersService;
	@Autowired
	private CompanyProductsService companyProductsService;
	@Autowired
	private ShoppingAddressService shoppingAddressService;
	@Autowired
	private UserManagerService userManagerService;
	@Autowired
	private DispatchBillService dispatchBillService;
	@Autowired
	private InvoiceService invoiceService;

	private static Logger log = Logger.getLogger(WebGrouponController.class);

	/*
	 * 查询团购商品
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/toGroupon")
	public String toGroupPurchase(Page page, Model model) {
		try {
			// 团购前12个商品显示（每类各2个）
			List<Integer> superParent = null;
			Cache tmpCache = CacheManager.getCacheInfo("superParent");
			if (tmpCache != null) {
				superParent = (List<Integer>) (tmpCache.getValue());
			} else {
				superParent = productCategoryService.findSuperParent();
				tmpCache = new Cache();
				tmpCache.setKey("superParent");
				tmpCache.setValue(superParent);
				CacheManager.putCache("superParent", tmpCache);
			}
			model.addAttribute("superParent", superParent);
			Map<String, Object> parm1 = new HashMap<>();

			List<List<Map<String, Object>>> productlist = null;
			Cache tmpCache1 = CacheManager.getCacheInfo("productlist");
			if (tmpCache1 != null) {
				productlist = (List<List<Map<String, Object>>>) (tmpCache1
						.getValue());
			} else {
				productlist = new ArrayList<List<Map<String, Object>>>();

				for (int i = 0; i < superParent.size(); i++) {
					parm1.put("pageNum", 2);
					parm1.put("begin", 0);
					parm1.put("cateGoryId", superParent.get(i));//
					List<Map<String, Object>> productlist1 = grouponService
							.findGrouponHot(parm1);
					productlist.add(productlist1);
				}
				tmpCache1 = new Cache();
				tmpCache1.setKey("productlist");
				tmpCache1.setValue(productlist);
				CacheManager.putCache("productlist", tmpCache1);
			}
			model.addAttribute("productlist1", productlist);

			// 团购后48个商品显示（每类各8个）
			Map<String, Object> parm = new HashMap<>();
			Map<Integer, List<Map<String, Object>>> productGroupMap = new HashMap<>();
			Cache tmpCache2 = CacheManager.getCacheInfo("productGroupMap");
			if (tmpCache2 != null) {
				productGroupMap = (Map<Integer, List<Map<String, Object>>>) (tmpCache2
						.getValue());
			} else {
				for (int i = 0; i < superParent.size(); i++) {
					parm.put("cateGoryId", superParent.get(i));//
					page.setPageNum(8);
					parm.put("page", page);
					List<Map<String, Object>> productlist2 = grouponService
							.findGroupon(parm);
					productGroupMap.put(superParent.get(i), productlist2);
				}

				tmpCache2 = new Cache();
				tmpCache2.setKey("productGroupMap");
				tmpCache2.setValue(productGroupMap);
				CacheManager.putCache("productGroupMap", tmpCache2);
			}

			model.addAttribute("productGroupMap", productGroupMap);
			return "website/groupPurchase";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/toGrouponInfo")
	public String toProductInfo(SecondPage page, Integer id, Integer ProductId,
			HttpServletRequest request) {
		String jsonAddrs = "";

		// 品类展示
		try {

			// 获取用户登录信息
			Users user = (Users) request.getSession().getAttribute("user");
			if (user == null) {
				return "redirect:/web/toLogin.do";
			}
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
			request.setAttribute("product", product);
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

			} else {
				viewPros.add(product);
			}
			request.getSession().setAttribute("viewProducts", viewPros);
			// 获取商品品类
			/*
			 * List<ProductCategory> productCategoryItems =
			 * productCategoryService
			 * .getCateGoryByIds(product.getProductCategory());
			 */
			request.setAttribute("productCategoryItems",
					product.getProductCategorys());
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

		// 获取团购商品信息
		try {
			List<Map<String, Object>> groupList = grouponService.findById(id);
			request.setAttribute("groupList", groupList);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

		// 获取商品图片
		try {
			List<ProductPic> productPics = productPicService
					.getProductPicByProductId(ProductId);
			request.setAttribute("productPic", productPics);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "website/groupInfo";
	}

	/**
	 * 团购订单的新增 (先添加到询价单，在添加到订单中)
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/AddGrouponSheet", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddGrouponSheet(HttpServletRequest request) {
		String json = "{'result':'false'}";
		int productId = Integer.parseInt(request.getParameter("productId"));
		Object user = request.getSession().getAttribute("user");
		// 判断用户是否登录
		if (user == null) {
			return "{'result':'1'}";
		}
		Integer companyId = ((Users) user).getCompanyId();
		Companys company = companyService.webfindById(companyId);

		// 判断公司状态是否已认证
		// System.out.println(company.getStatus());
		switch (company.getStatus()) {
		case 0:
			return "{'result':'2'}";
			/*
			 * case 1: return "{result:'true',inquiryId:'" +
			 * inquirySheet.getInquiryId() + "'}";
			 */
		case 2:
			return "{'result':'3'}";
		}
		if (company.getCompanyType() == null || company.getCompanyType() == 3) {
			return "{'result':'5'}"; // 供应商
		}
		/******************/
		String address = request.getParameter("address");
		int buyNum = Integer.parseInt(request.getParameter("buyNum"));
		BigDecimal GrouponPrice = new BigDecimal(
				request.getParameter("GrouponPrice"));
		BigDecimal buyNum1 = new BigDecimal(buyNum);
		BigDecimal totolAmount = buyNum1.multiply(GrouponPrice);
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
				Integer companyProductId = companyProductsService
						.findbyProductId(productId);
				Orders orders = new Orders();
				orders.setOrderId(inquirySheet.getInquiryId());
				orders.setUserId(((Users) user).getId());
				orders.setCompanyProductId(companyProductId);
				orders.setQuantity(buyNum);
				orders.setProductUnit(product.getProductUnit());
				orders.setUnitPrice(GrouponPrice);
				orders.setTotolAmount(totolAmount);
				orders.setOrderType(2);
				ordersService.add(orders);
				int groupID = Integer.parseInt(request.getParameter("groupID"));
				Map<String, Object> parm = new HashMap<>();
				parm.put("id", groupID);
				parm.put("soldOut", buyNum);
				grouponService.addSoldOut(parm);

				// return "redirect:Orders.do";

				json = "{result:'true',orderId:'" + orders.getId() + "'}";
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 跳转到订单的配送拆分和支付页面
	@RequestMapping("toGrouponPay")
	public String toGrouponPay(HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			Integer companyId = user.getCompanyId();
			// 获取当次传值的订单号
			String id = request.getParameter("id");
			if (id != null && id.isEmpty() == false) {
				Orders order = ordersService.findById(Integer.valueOf(id));
				request.setAttribute("order", order);

				CompanyProducts companyProducts = companyProductsService
						.findbyId(order.getCompanyProductId());

				String fliePath = productPicService
						.selectByProductId(companyProducts.getProduct().getId());
				request.setAttribute("fliePath", fliePath);
				// 取出询价单，根据询价单比配相关的配送地址
				InquirySheet inquirySheet = inquirySheetService
						.findByInquiryId(order.getOrderId());
				// 获取配送地址
				List<ShoppingAddress> shopAdds = shoppingAddressService
						.findbyShoppingAddress(user.getCompanyId(),
								inquirySheet.getAddress());

				String temp[] = inquirySheet.getAddress().trim().split(",");
				String s = "";
				for (int i = 0; i < temp.length; i++) {
					s += dictionaryService.findById(Integer.parseInt(temp[i]))
							.getDicName();
				}

				request.setAttribute("Address", s);
				request.setAttribute("shopAdds", shopAdds);
				request.setAttribute("addressIds", inquirySheet.getAddress());

				/*
				 * List<Users> users = userManagerService
				 * .webfindAllByCompanyId(user.getCompanyId());
				 */
				Map<String, Object> parm1 = new HashMap<>();
				parm1.put("companyId", user.getCompanyId());
				parm1.put("departmentId", user.getDepartmentId());
				List<Users> users = userManagerService
						.webfindAllByDepartID(parm1);
				request.setAttribute("users", users);

				// 发票信息

				List<Invoice> invoice = invoiceService
						.findByCompanyId(companyId);
				request.setAttribute("invoice", invoice);

			}
			return "website/groupOrder";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	/*
	 * 保存地址和发票信息
	 * 
	 * *
	 */
	@RequestMapping(value = "/AddGrouponPay", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddGrouponPay(HttpServletRequest request) {

		String json = "{'result':'false'}";
		String orderid = request.getParameter("orderid");
		String jsonData = request.getParameter("DispatchBill");
		Object objUser = request.getSession().getAttribute("user");
		String InvoiceTitle = request.getParameter("InvoiceTitle");
		String invoiceType = request.getParameter("invoiceType");
		String allAmount = request.getParameter("allAmount");
		Users user = (Users) request.getSession().getAttribute("user");
		Integer companyId = user.getCompanyId();

		if (objUser == null) {
			return "{'result':'1'}";
		}
		if (orderid == null || orderid.isEmpty()) {
			return "{'result':'2'}";
		}
		try {
			Orders order = ordersService.findById(Integer.valueOf(orderid));
			JSONArray obj = JSONArray.fromObject(jsonData);
			for (int i = 0; i < obj.size(); i++) {
				DispatchBill dispatchBill = new DispatchBill();
				dispatchBill.setOrderId(Integer.valueOf(orderid));
				dispatchBill.setStatus(0);
				JSONObject jo = (JSONObject) obj.get(i);
				Integer ShoppingAddressId = Integer.valueOf(jo.get("id")
						.toString());
				dispatchBill.setShoppingAddressId(ShoppingAddressId);
				dispatchBill.setPurchaseQuantity(new BigDecimal(jo.get("num")
						.toString()));
				dispatchBill.setCompanyProductId(order.getCompanyProductId());
				Integer userId = Integer
						.valueOf(jo.get("checkUser").toString());
				dispatchBill.setCheckUser(userId);
				dispatchBill.setDeliveryTime(Timestamp.valueOf(jo
						.get("deliveryTime").toString().replace('@', ':')));
				dispatchBill.setUnitPrice(order.getUnitPrice());
				dispatchBill.setProductUnit(order.getProductUnit());
				BigDecimal amount = (new BigDecimal(jo.get("num").toString()))
						.multiply(order.getUnitPrice());
				dispatchBill.setAmount(amount);
				// 根据订单信息填写配送单信息
				dispatchBillService.insertData(dispatchBill);
			}
			// 当订单拆解完毕，更改订单的状态为已拆分，状态为：2
			order.setStatus(2);
			ordersService.update(order);

			/****** 保存发票信息 ********/
			if (invoiceType != "" && allAmount != "" && InvoiceTitle != "") {
				Map<String, Object> parm = new HashMap<>();
				parm.put("tmpInvoiceType", invoiceType);
				parm.put("tmpInvoiceTitle",
						java.net.URLDecoder.decode(InvoiceTitle, "UTF-8"));
				parm.put("tmpAmount", allAmount);
				parm.put("tmpCompanyId", companyId);
				parm.put("tmpStatementId", 0);
				invoiceService.buyerInvoiceApply(parm);
			}
			/****** 保存发票信息 ********/
			json = "{'result':'true'}";
		} catch (Exception e) {
			Common.setLog(e);
		}
		return json;
	}

}
