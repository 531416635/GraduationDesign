package com.wit.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
/*import javax.persistence.UniqueConstraint;*/
import javax.servlet.http.HttpServletRequest;

import jxl.write.DateTime;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.ibatis.io.ResolverUtil.IsA;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.wit.comm.Common;
import com.wit.model.CompanyBalance;
import com.wit.model.CompanyBalanceStatement;
import com.wit.model.CompanyBankAccount;
import com.wit.model.CompanyContracts;
import com.wit.model.CompanyProductPic;
import com.wit.model.CompanyProductPrice;
import com.wit.model.CompanyProducts;
import com.wit.model.Companys;
import com.wit.model.Dictionarys;
import com.wit.model.DispatchBill;
import com.wit.model.Favorite;
import com.wit.model.FiltratePage;
import com.wit.model.InquirySheet;
import com.wit.model.Invoice;
import com.wit.model.Menus;
import com.wit.model.News;
import com.wit.model.OrderPage;
import com.wit.model.Orders;
import com.wit.model.Page;
import com.wit.model.PriceSheet;
import com.wit.model.ProductCategory;
import com.wit.model.ProductPic;
import com.wit.model.ProductSample;
import com.wit.model.Products;
import com.wit.model.Settlement;
import com.wit.model.ShoppingAddress;
import com.wit.model.ShoppingCart;
import com.wit.model.Storage;
import com.wit.model.Suppliers;
import com.wit.model.Users;
import com.wit.model.WebPriceSheetPage;
import com.wit.model.WorkflowLogs;
import com.wit.model.newOrNoticePage;
import com.wit.service.CompanyBalanceService;
import com.wit.service.CompanyBalanceStatementService;
import com.wit.service.CompanyBankAccountService;
import com.wit.service.CompanyContractService;
import com.wit.service.CompanyProductPicService;
import com.wit.service.CompanyProductPriceService;
import com.wit.service.CompanyProductsService;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.DispatchBillService;
import com.wit.service.FavoriteService;
import com.wit.service.InquirySheetService;
import com.wit.service.InvoiceService;
import com.wit.service.MenusService;
import com.wit.service.NewsService;
import com.wit.service.OrdersService;
import com.wit.service.PriceSheetService;
import com.wit.service.ProductBrandService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductTypeService;
import com.wit.service.ProductsService;
import com.wit.service.SettlementService;
import com.wit.service.ShoppingAddressService;
import com.wit.service.ShoppingCartService;
import com.wit.service.StorageService;
import com.wit.service.SuppliersService;
import com.wit.service.UserManagerService;
import com.wit.service.WorkflowLogsService;
import com.wit.util.UserExcelView;

/**
 * 门户页面采购商控制器
 * 
 * @author tangxiaoqing
 * 
 */

@SessionAttributes({ "orderPage", "oldOrderPage", "webPriceSheetPage",
		"priceInquiryPage" })
@Controller
@RequestMapping("/merchant")
public class WebPurchaserController extends BaseController {

	@Autowired
	private CompanyBalanceStatementService companyBalanceStatementService;

	@Autowired
	private InquirySheetService inquirySheetService;

	@Autowired
	private CompanysService companyService;

	@Autowired
	private CompanyBalanceService companyBalanceService;

	@Autowired
	private ShoppingCartService shoppingCartService;

	@Autowired
	private ProductsService productService;

	@Autowired
	private OrdersService orderService;

	@Autowired
	private ProductsService productsService;

	@Autowired
	private PriceSheetService priceSheetService;

	@Autowired
	private DispatchBillService dispatchBillService;

	@Autowired
	private ProductCategoryService productCategoryService;

	@Autowired
	private ProductTypeService productTypeService;

	@Autowired
	private ProductBrandService brandService;

	@Autowired
	private CompanyProductsService companyProductsService;

	@Autowired
	private FavoriteService favoriteService;

	@Autowired
	private ShoppingAddressService ShoppingAddressService;

	@Autowired
	private UserManagerService userManagerService;

	@Autowired
	private DictionaryService dictionaryService;

	@Autowired
	private CompanyProductPicService companyProductPicService;

	@Autowired
	private ProductPicService productPicService;
	@Autowired
	private CompanyProductPriceService companyProductPriceService;

	@Autowired
	private StorageService storageService;

	@Autowired
	private ShoppingAddressService shoppingAddressService;

	@Autowired
	private SettlementService settlementService;

	@Autowired
	private SuppliersService suppliersService;

	@Autowired
	private MenusService menusService;

	@Autowired
	private InvoiceService invoiceService;

	@Autowired
	private CompanyBankAccountService companyBankAccountService;

	@Autowired
	private WorkflowLogsService workflowLogsService;
	@Autowired
	private CompanyContractService companyContractService;
	
	@Autowired
	private NewsService newsService;

	// 跳转到商户后台页面
	@RequestMapping("toPurchaserList")
	public String purchaserList(Page page, HttpServletRequest request) {
		try {
			// 获取用户登录信息
			Users user = (Users) request.getSession().getAttribute("user");
			if (user == null) {
				return "redirect:/web/toLogin.do";
			}
			/**
			 * 用户登录信息
			 */

			// 获取用户ID
			Integer userId = user.getId();
			// 获取用户名
			String userName = user.getUserName();
			// 获取公司ID
			Integer companyId = user.getCompanyId();
			if (companyId == null) {
				return "redirect:/web/toLogin.do";
			}
			// 根据公司ID获取公司信息
			Companys companys = companyService.findById(companyId);
			// 获取公司状态、公司名称
			int status = companys.getStatus();
			if (status == 3) {
				return "redirect:authenticationInfoList.do";
			}
			String companyName = companys.getCompanyName();
			// 将数据传给页面
			request.setAttribute("userName", userName);
			request.setAttribute("status", status);
			request.setAttribute("companyName", companyName);
			//门户商户控制台新闻公告
			 List<News> newList=newsService.findAllNews();
			 request.getSession().setAttribute("newList", newList);
			// 根据用户的权限可以查看工作台
			List<Menus> menus = menusService.getMenusByUser(user.getId(),
					user.getUserType(), 3, 1);
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < menus.size(); i++) {
				switch (menus.get(i).getMenuCode()) {
				case "CompanyStatement":// 资金对账单
					sb.append("IsCompanyStatement,");
					/**
					 * 财务信息
					 */
					// 根据公司ID查询资金对账单信息
					Map<String, Object> parm = new HashMap<>();
					parm.put("companyId", companyId);
					// Page page = new Page();
					page.setPageNum(3);
					parm.put("page", page);
					List<CompanyBalanceStatement> companyBalanceStatement = companyBalanceStatementService
							.findbyCompanyId(parm);
					/*
					 * int rows =
					 * companyBalanceStatementService.rows(companyId);
					 * page.setRows(rows);
					 */
					// 将数据传给页面
					request.setAttribute("cbs", companyBalanceStatement);
					request.setAttribute("page", page);
					break;
				case "CompanyBalance":// 资金账户
					sb.append("IsCompanyBalance,");

					Map<String, Object> cbParm = new HashMap<>();
					cbParm.put("companyId", companyId);
					cbParm.put("currency", "CNY");
					BigDecimal companyBalance = companyBalanceService
							.findBalanceByCompanyId(cbParm);
					if (companyBalance == null) {
						companyBalance = BigDecimal.ZERO;
					}
					// 将数据传给页面
					request.setAttribute("companyBalance", companyBalance);
					// 获取公司类型并将数据传给页面
					int companyType = companys.getCompanyType();
					request.setAttribute("companyType", companyType);
					// 获取当前时间，格式为年月日，从而定位当前属于哪个季度
					Date utildate = new Date();
					java.sql.Date date = new java.sql.Date(utildate.getTime());
					// 计算每季度累计采购金额
					BigDecimal CountPurchaseAmount = companyBalanceStatementService
							.CountPurchaseAmount(companyId, date);
					// 计算每季度累计供应金额
					BigDecimal CountSupplyAmount = companyBalanceStatementService
							.CountSupplyAmount(companyId, date);
					// 将数据传给页面
					request.setAttribute("CountPurchaseAmount",
							CountPurchaseAmount);
					request.setAttribute("CountSupplyAmount", CountSupplyAmount);
					break;
				case "ShoppingCart":// 购物车
					sb.append("IsShoppingCart,");
					/**
					 * 商品信息
					 */
					Map<String, Object> parm3 = new HashMap<>();
					parm3.put("userId", userId);
					parm3.put("limit", 5);
					// 获取购物车信息
					List<ShoppingCart> shoppingCart = shoppingCartService
							.findByUserIdLimit(parm3);
					request.setAttribute("shoppingCart", shoppingCart);
					break;
				case "CompanyProduct":// 商品供应
					sb.append("IsCompanyProduct,");
					Map<String, Object> parm1 = new HashMap<>();
					parm1.put("companyId", companyId);
					parm1.put("status", 1);
					Page page1 = new Page();
					page1.setPageNum(6);
					parm1.put("page", page1);
					List<Map<String, Object>> companyProducts = companyProductsService
							.productSupply(parm1);
					request.setAttribute("companyProducts", companyProducts);
					break;
				case "ProductFavorite":// 商品收藏
					sb.append("IsProductFavorite,");
					Map<String, Object> parm2 = new HashMap<>();
					parm2.put("userId", userId);
					Page page2 = new Page();
					page2.setPageNum(6);
					parm2.put("page", page2);
					// 展示一般收藏商品
					parm2.put("favoriteType", 1);
					List<Map<String, Object>> favorites = favoriteService
							.findFavoriteInfo(parm2);
					request.setAttribute("favorites", favorites);
					break;
				case "Purchase":// 采购业务
					sb.append("IsPurchase,");
					/**
					 * 业务信息
					 */
					break;
				// 议价管理供应商已响应条数
				case "bargainingResponse":
					sb.append("bargainingResponse,");
					int rows1 = priceSheetService.bargainingResponse(userId);
					request.setAttribute("rows1", rows1);
					break;
				// 配送管理等待分配地址条数
				case "OrderAddressNum":
					sb.append("OrderAddressNum,");
					int rows2 = orderService.OrderAddressNum(userId);
					request.setAttribute("rows2", rows2);
					break;
				// 验收管理等待处理条数
				case "purchaserCheckNum":
					sb.append("purchaserCheckNum,");
					Map<String, Object> par = new HashMap<>();
					par.put("page", page);
					par.put("userId", userId);
					par.put("userRole", "Checker");
					int rows3 = dispatchBillService.getMyDispatchBillrows(par);
					request.setAttribute("rows3", rows3);
					break;
				// 将数据传给页面
				case "Supply":// 供应业务
					sb.append("IsSupply,");
					/**
					 * 业务信息
					 */
					break;
				// 议价管理等待处理条数
				case "bargainingWait":
					sb.append("bargainingWait,");
					int r1 = priceSheetService.bargainingWait(companyId);
					request.setAttribute("r1", r1);
					break;
				// 配送管理等待发货配送条数
				case "OrderSendNum":
					sb.append("OrderSendNum,");
					Map<String, Object> pa = new HashMap<>();
					pa.put("page", page);
					pa.put("companyId", user.getCompanyId());
					pa.put("userRole", "Supplier");
					int r2 = dispatchBillService.getMyDispatchBillrows(pa);
					request.setAttribute("r2", r2);
					break;
				// 验收管理等待处理条数
				case "supplierCheckNum":
					sb.append("supplierCheckNum,");
					int r3 = dispatchBillService.supplierCheckNum(user.getId());
					request.setAttribute("r3", r3);
					break;
				}
			}
			request.setAttribute("pageRights", sb.toString());
			// 采购信息
			return "merchant/purchaserList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 我的财务信息
	@RequestMapping("financeInfo")
	public String financeInfo(Page page, HttpServletRequest request) {
		try {
			String ids = request.getParameter("fileIds");
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			/*
			 * // 获取对账单信息 List<Map<String,Object>> companyBalanceStatement =
			 * companyBalanceStatementService .accountInfo(page, companyId); int
			 * rows = companyBalanceStatementService.rows(companyId);
			 * page.setRows(rows);
			 */
			BigDecimal companyBalance = companyBalanceStatementService
					.findReconciliationAmount(ids);
			/*
			 * // 将数据传给页面 request.setAttribute("cbs", companyBalanceStatement);
			 * request.setAttribute("page", page);
			 */
			// 发票信息
			List<Invoice> invoice = invoiceService.findByCompanyId(companyId);
			request.setAttribute("invoice", invoice);

			// 公司ID
			request.setAttribute("companyId", companyId);
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("companyId", companyId);
			List<CompanyBalanceStatement> cbs = companyBalanceStatementService
					.findbyCompanyId(parm);
			request.setAttribute("cbs", cbs);
			request.setAttribute("companyBalance", companyBalance);
			return "merchant/financeInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 财务对账功能
	@RequestMapping(value = "/reconciliation", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String reconciliation(HttpServletRequest request) {
		String json = "{'result':'false'}";
		// 获取页面传过来的json数据
		String ids = request.getParameter("ids");
		// 获取用户登录信息
		/*
		 * Users user = (Users) request.getSession().getAttribute("user"); //
		 * 获取用户公司 Integer companyId = user.getCompanyId(); //对账金额 BigDecimal
		 * companyBalance = companyBalanceStatementService
		 * .findReconciliationAmount(ids);
		 */
		try {
			// 调用存储过程改变对账状态，将对账金额加到公司资金账户，同时记录日志
			companyBalanceStatementService.editCompanyBalanceStatement(Integer
					.valueOf(ids));
			json = "{'result':'true'}";
			// 对账改变状态
			// companyBalanceStatementService.webReconciliation(ids);
			/*
			 * //对账后金额加到账户金额 companyBalanceService.renewalBalance(ids);
			 */
			// 本次对账金额
			// BigDecimal companyBalance =
			// companyBalanceStatementService.findReconciliationAmount(ids);
			// json = "{'result':'true','companyBalance':'"+companyBalance+"'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}

		return json;

	}

	// 对账单我要支付
	@RequestMapping(value = "iWantPay", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String iWantPay(Settlement settlement, HttpServletRequest request) {
		String json = "{'result':'false'}";
		// 获取用户选择的账单
		String ids = request.getParameter("ids");
		try {
			/*
			 * //获取对账状态 int status =
			 * companyBalanceStatementService.findAccountStatus(ids);
			 */
			// 账户余额(公司账户金额+对账金额)
			companyBalanceService.renewalBalance(ids);
			// 将传给页面
			json = "{'result':'true'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 我的商品信息
	@RequestMapping("productInfo")
	public String productInfo(HttpServletRequest request) {
		try {
			return "merchant/productInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	/*
	 * 我的业务信息 询价单 myInquiry 报价单 myPriceSheet 订单 myOrder 发货单 myDispatchBill 结算单
	 * myStatement 退货单
	 */

	// 询价单
	@RequestMapping("myInquiry")
	public String myInquiry(Page page, HttpServletRequest request) {
		String json = "";
		try {
			// ,inquiryId:'" + inquirySheet.getInquiryId()
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			String ids = request.getParameter("InquiryId");

			// 询价单搜索条件
			String inquiryId2 = request.getParameter("inquiryId2");
			String productName = request.getParameter("productName");
			String orderTime1 = request.getParameter("orderTime");
			String status = request.getParameter("status");
			
			if (inquiryId2 != null) {
				inquiryId2 = inquiryId2.trim();
			}
			if (productName != null) {
				productName = productName.trim();
			}
			if (orderTime1 != null) {
				orderTime1 = orderTime1.trim();
			}
			if (status != null) {
				status = status.trim();
			}

			java.sql.Date orderTime = null;
			if (orderTime1 != "" && orderTime1 != null) {
				orderTime = java.sql.Date.valueOf(orderTime1);
			}

			// 搜索分页条件保存
			request.setAttribute("inquiryId", inquiryId2);
			request.setAttribute("productName", productName);
			request.setAttribute("orderTime", orderTime);
			request.setAttribute("status", status);
			/*
			 * if(ids==null || ids.isEmpty()) {
			 * request.setAttribute("InfoMessage","InquirySheetID is null");
			 * return "merchant/myInquiry"; }
			 */
			Integer userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("ids", ids);
			parm.put("inquiryId", inquiryId2);
			parm.put("productName", productName);
			parm.put("orderTime", orderTime);
			parm.put("status", status);
			// 查询用户询价单信息
			List<Map<String, Object>> inquirySheet = inquirySheetService
					.findAllByIds(parm);
			int rows = inquirySheetService.findAllByIdsRows(parm);
			page.setRows(rows);
			request.setAttribute("userId", userId);
			json = JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			request.setAttribute("inquirySheet", inquirySheet);
			String jsonAddrs = "";
			// 查询省份信息（用户选择地区）
			try {
				List<Dictionarys> addrs = dictionaryService.getDicsByDicType(1);
				jsonAddrs = JSONArray.fromObject(addrs).toString();
				request.setAttribute("jsonAddrs", jsonAddrs);
			} catch (Exception ex) {
			}

			return "merchant/myInquiry";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 订单管理，我的订单
	@RequestMapping("myOrder")
	public String myOrder(OrderPage page, HttpServletRequest request) {
		try {

			// 获取用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer userId = user.getId();
			/*
			 * // 获取用户输入的搜索条件(近三个月) String orderId =
			 * request.getParameter("orderId"); String productName =
			 * request.getParameter("productName"); String orderTimeStart =
			 * request.getParameter("orderTimeStart"); String orderTimeStop =
			 * request.getParameter("orderTimeStop"); String orderStatus =
			 * request.getParameter("orderStatus"); String
			 * orderType=request.getParameter("orderType"); //
			 * 将用户输入的搜索条件参数传给页面用于分页显示(近三个月) if (orderId != null && orderId !=
			 * "") { request.setAttribute("orderId", orderId); } if (productName
			 * != null && productName != "") {
			 * request.setAttribute("productName", productName); } if
			 * (orderTimeStart != null && orderTimeStart != "") {
			 * request.setAttribute("orderTimeStart", orderTimeStart); } if
			 * (orderTimeStop != null && orderTimeStop != "") {
			 * request.setAttribute("orderTimeStop", orderTimeStop); }
			 * request.setAttribute("orderStatus", orderStatus);
			 * request.setAttribute("orderType",orderType);
			 */

			// 分页部分
			OrderPage page1 = (OrderPage) request.getSession().getAttribute(
					"orderPage1");
			if (page1 == null) {
				page1 = new OrderPage();
			}
			String currentPage = request.getParameter("currentPage1");
			page1.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));

			// 获取近三个月订单信息
			Map<String, Object> parm1 = new HashMap<>();
			parm1.put("page", page1);
			parm1.put("userId", userId);
			parm1.put("orderId", page.getOrderId());
			parm1.put("productName", page.getProductName());
			parm1.put("orderTimeStart", page.getOrderTimeStart());
			parm1.put("orderTimeStop", page.getOrderTimeStop());
			parm1.put("orderStatus", page.getOrderStatus());
			parm1.put("orderType", page.getOrderType());
			List<Orders> order1 = orderService.findOrderInfo(parm1);
			request.setAttribute("order1", order1);
			request.setAttribute("page", page);
			request.getSession().setAttribute("orderPage", page);
			page1.setRows(orderService.findOrderInfoRows(parm1));
			request.getSession().setAttribute("orderPage1", page1);
			request.setAttribute("orderPage1", JSONObject.fromObject(page1)
					.toString());
			return "merchant/myOrder";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 获取三个月前订单信息

	@RequestMapping("myOldOrder")
	public String myOldOrder(OrderPage page1, HttpServletRequest request) {
		try {
			// 获取用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer userId = user.getId();
			/*
			 * // 获取用户输入的搜索条件 String oldOrderId =
			 * request.getParameter("oldOrderId"); String oldProductName =
			 * request.getParameter("oldProductName"); String oldOrderTimeStart
			 * = request.getParameter("oldOrderTimeStart"); String
			 * oldOrderTimeStop = request.getParameter("oldOrderTimeStop");
			 * String orderType=request.getParameter("orderType"); //
			 * 再将用户输入的搜索条件参数传给页面用于分页显示 if (oldOrderId != null && oldOrderId !=
			 * "") { request.setAttribute("oldOrderId", oldOrderId); } if
			 * (oldProductName != null && oldProductName != "") {
			 * request.setAttribute("oldProductName", oldProductName); } if
			 * (oldOrderTimeStart != null && oldOrderTimeStart != "") {
			 * request.setAttribute("oldOrderTimeStart", oldOrderTimeStart); }
			 * if (oldOrderTimeStop != null && oldOrderTimeStop != "") {
			 * request.setAttribute("oldOrderTimeStop", oldOrderTimeStop); }
			 * request.setAttribute("orderType",orderType);
			 */
			// 分页部分

			OrderPage page2 = (OrderPage) request.getSession().getAttribute(
					"orderPage2");
			if (page2 == null) {
				page2 = new OrderPage();
			}
			String currentPage = request.getParameter("currentPage2");
			page2.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			// 获取三个月前订单信息
			Map<String, Object> parm2 = new HashMap<>();
			parm2.put("page", page2);
			parm2.put("userId", userId);

			parm2.put("oldOrderId", page1.getOrderId());
			parm2.put("oldProductName", page1.getProductName());
			parm2.put("oldOrderTimeStart", page1.getOrderTimeStart());
			parm2.put("oldOrderTimeStop", page1.getOrderTimeStop());
			parm2.put("orderType", page1.getOrderType());
			parm2.put("orderStatus", page1.getOrderStatus());
			List<Orders> order2 = orderService.findAll(parm2);
			request.setAttribute("order2", order2);
			request.setAttribute("page1", page1);
			request.getSession().setAttribute("oldOrderPage", page1);
			page2.setRows(orderService.findOldOrderRows(parm2));
			request.getSession().setAttribute("orderPage2", page2);
			request.setAttribute("orderPage2", JSONObject.fromObject(page2)
					.toString());
			return "merchant/myOldOrder";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	@RequestMapping(value = "/AddOrder", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddOrder(HttpServletRequest request) {

		String json = "{'result':'false'}";
		String ids = request.getParameter("ids");
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		try {
			Integer orderId = orderService.findbyOrderId(Integer.valueOf(ids));
			if (orderId == null || orderId <= 0) {
				Orders order = orderService.getOrderByID(Integer.valueOf(ids));
				order.setOrderType(1);// 订单类型设置1，表示普通询价单
				int i = orderService.add(order);
				if (i > 0) {
					if (order.getId().toString().isEmpty() == false) {
						// 修改报价单的model,status=1
						json = "{'result':'true','orderId':"
								+ order.getId().toString() + "}";
						Map<String, Object> parm = new HashMap<>();
						parm.put("ids", ids);
						parm.put("status", 1);
						priceSheetService.updateByIds(parm);
					}
				}
			} else {
				json = "{'result':'true','orderId':" + String.valueOf(orderId)
						+ "}";
				Map<String, Object> parm = new HashMap<>();
				parm.put("ids", ids);
				parm.put("status", 1);
				priceSheetService.updateByIds(parm);
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@RequestMapping(value = "/AddSuppliers", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddSuppliers(HttpServletRequest request) {

		String json = "{'result':'false'}";
		String companyProductId = request.getParameter("companyProductId");
		Object objuser = request.getSession().getAttribute("user");
		if (objuser == null) {
			return "{'result':'1'}";
		}
		try {

			Users user = (Users) objuser;

			Map<String, Object> parm = new HashMap<>();
			parm.put("companyProductId", companyProductId);
			parm.put("companyId", user.getCompanyId());
			List<Suppliers> list = suppliersService
					.findAllByCompanyProductId(parm);
			if (list == null || list.size() == 0) {
				Suppliers order = new Suppliers();
				order.setBuyCompanyId(user.getCompanyId());
				order.setSellCompanyProductId(Integer.valueOf(companyProductId));
				order.setUpdateBy(user.getId());
				order.setUpdateTime(new Date());
				order.setIsDefault(1);
				order.setIsLock(0);
				int i = suppliersService.insertSuppliers(order);
				if (i > 0) {
					if (order.getId() != null
							&& order.getId().toString().isEmpty() == false) {
						// 修改报价单的model,status=1
						json = "{'result':'true','orderId':"
								+ order.getId().toString() + "}";
					}
				}
			} else {
				return "{'result':'2'}";
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 我的订单导出
	@RequestMapping("excel")
	public ModelAndView export2Excel(HttpServletRequest request) {
		// 获取用户信息
		Users user = (Users) request.getSession().getAttribute("user");
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("货品");
		titles.add("单价");
		titles.add("数量");
		titles.add("总金额");
		titles.add("订单状态");
		titles.add("交易日期");
		dataMap.put("titles", titles);
		List<Orders> orders = orderService.getAlljExcel(user.getId());
		dataMap.put("orders", orders);
		UserExcelView erv = new UserExcelView();
		ModelAndView mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	// 到验收结算
	@RequestMapping("myStatement")
	public String myStatement(Page page, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			Integer userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<Map<String, Object>> dispatchBill = dispatchBillService
					.dispatchBillInfo(userId);
			int rows = dispatchBillService.rows(userId);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			request.setAttribute("page", page);
			dispatchBillService.getAll(parm);
			return "merchant/acceptanceSettlement";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 我的结算单
	@RequestMapping("statement")
	public String statement(HttpServletRequest request) {
		String json = "";
		try {
			// 获取用户输入的金额
			String settleAmount = request.getParameter("settleAmount");

			// 获取用户公司ID
			Page page = new Page();
			Users user = (Users) request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			String currentPage1 = request.getParameter("currentPage1");
			page.setCurrentPage(Integer.parseInt(currentPage1 == null ? "1"
					: currentPage1));
			parm.put("page", page);

			// 公司账户余额
			List<CompanyBalance> companyBalance = companyBalanceService
					.findByCompanyId(companyId);
			request.setAttribute("companyBalance", companyBalance);
			request.setAttribute("companyId", companyId);

			// 根据公司ID查找发票信息 发票抬头
			List<Invoice> invoice = invoiceService.findByCompanyId(companyId);
			request.setAttribute("invoice", invoice);

			// 根据公司ID查找银行账号信息 银行账号
			List<CompanyBankAccount> companyBankAccount = companyBankAccountService
					.findByCompanyId(companyId);
			request.setAttribute("companyBankAccount", companyBankAccount);
			/*
			 * // 将用户填写的金额传递过来给页面 request.setAttribute("pay", settleAmount);
			 */

			// 查询结算单信息
			List<Map<String, Object>> list = settlementService
					.findSettlementInfo(parm);
			request.setAttribute("list", list);
			int rows = settlementService.rows(companyId);
			page.setRows(rows);
			request.setAttribute("json", JSONObject.fromObject(page).toString());

			// 第二个div 查询 分页
			// 获取用户输入的查询时间
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			Page page2 = new Page();
			Map<String, Object> parm2 = new HashMap<>();
			String currentPage2 = request.getParameter("currentPage2");
			page2.setCurrentPage(Integer.parseInt(currentPage2 == null ? "1"
					: currentPage2));
			parm2.put("page", page2);
			parm2.put("companyId", companyId);
			parm2.put("startTime", startTime);
			parm2.put("endTime", endTime);
			request.setAttribute("st", startTime);
			request.setAttribute("et", endTime);
			// 条件查询结算单信息
			if (startTime != null && startTime != "" && endTime != null
					&& endTime != "") {
				List<Map<String, Object>> settlementInfo = settlementService
						.findSettlementInfo(parm2);
				// 查询结算单信息行数
				request.setAttribute("settlementInfo", settlementInfo);
			}
			int rows2 = settlementService.pastRows(parm2);
			page2.setRows(rows2);
			request.setAttribute("json2", JSONObject.fromObject(page2)
					.toString());

			String show = request.getParameter("show");
			if (show == null || show.isEmpty()) {
				show = "1";
			}
			request.setAttribute("show", show);
			return "merchant/myStatement";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 查看日期内结算单信息
	@RequestMapping("findTimeAccountInfo")
	public String findTimeAccountInfo(CompanyBalanceStatement cbs,
			HttpServletRequest request) {
		try {
			companyBalanceStatementService.findTimeAccount(cbs);
			return "redirect:statement.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 账期内对账详情
	@RequestMapping("financialSettlement")
	public String financialSettlement(Integer id, Page page,
			HttpServletRequest request) {
		try {
			CompanyBalanceStatement cbs = companyBalanceStatementService
					.findAccountInfoById(id);
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", cbs.getCompanyId());
			parm.put("startTime", cbs.getStartTime());
			parm.put("endTime", cbs.getEndTime());
			parm.put("page", page);
			parm.put("stateType", cbs.getStateType());
			// 获取对账单信息
			List<Map<String, Object>> companyBalanceStatement = companyBalanceStatementService
					.accountInfo(parm);
			int rows = companyBalanceStatementService.accountRow(parm);
			page.setRows(rows);
			request.setAttribute("cbs", companyBalanceStatement);
			request.setAttribute("page", page);
			request.setAttribute("id", id);
			return "merchant/financeDetails";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 我的收藏
	@RequestMapping("myCollection")
	public String myCollection(HttpServletRequest request) {
		String jsonAddrs = "";
		try {
			int favoriteType = Integer.parseInt(request
					.getParameter("favoriteType"));
			Page page1 = (Page) request.getSession().getAttribute(
					"collectionPage1");
			if (page1 == null) {
				page1 = new Page();
			}
			String currentPage = request.getParameter("currentPage1");
			page1.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			/*
			 * Page page2 = (Page) request.getSession().getAttribute(
			 * "collectionPage2"); if (page2 == null) { page2 = new Page(); }
			 * currentPage = request.getParameter("currentPage2");
			 * page1.setCurrentPage(Integer.parseInt(currentPage == null ? "1" :
			 * currentPage));
			 */
			/*
			 * Page page1 = (Page) request.getAttribute("page1"); if (page1 ==
			 * null) { page1 = new Page(); } Page page2 = (Page)
			 * request.getAttribute("page2"); if (page2 == null) { page2 = new
			 * Page(); }
			 */
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			if (user != null) {
				Map<String, Object> parm = new HashMap<>();
				parm.put("userId", user.getId());
				parm.put("page", page1);
				parm.put("favoriteType", favoriteType);
				List<Map<String, Object>> list = favoriteService
						.findFavoriteInfo(parm);
				int rows1 = favoriteService.findFavoriteInfoRows(parm);
				page1.setRows(rows1);
				request.setAttribute("list", list);
				/*
				 * // 获取用户的供应商 Map<String, Object> parm2 = new HashMap<>();
				 * parm2.put("companyId", user.getCompanyId());
				 * parm2.put("page", page2); List<Map<String, Object>> list2 =
				 * suppliersService .findSuppliers(parm2); int rows2 =
				 * suppliersService.findSuppliersRows(parm2);
				 * page2.setRows(rows2); request.setAttribute("list2", list2);
				 */

				String show = request.getParameter("show");
				if (show == null || show.isEmpty()) {
					show = "1";
				}
				// 查询省份信息（用户选择地区）
				try {
					List<Dictionarys> dictionarys = dictionaryService
							.findProvinceInfo();
					request.setAttribute("dictionarys", dictionarys);
					List<Dictionarys> addrs = dictionaryService
							.getDicsByDicType(1);
					jsonAddrs = JSONArray.fromObject(addrs).toString();
					request.setAttribute("jsonAddrs", jsonAddrs);
				} catch (Exception ex) {
				}
				/* request.setAttribute("page1", page1); */
				request.getSession().setAttribute("collectionPage1", page1);
				request.setAttribute("collectionPage1",
						JSONObject.fromObject(page1).toString());
				/* request.setAttribute("page2", page2); */
				/*
				 * request.getSession().setAttribute("collectionPage2", page2);
				 * request.setAttribute("collectionPage2",
				 * JSONObject.fromObject(page2).toString());
				 */
				request.setAttribute("show", show);
			}
			if (favoriteType == 1) {
				return "merchant/myCollection";// 普通商品收藏
			} else if (favoriteType == 2) {
				return "merchant/spotMyCollection";// 现货商品收藏
			} else {
				return "error";
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// editSuppliersStatus
	// ids,Isdefault,Islock
	@RequestMapping(value = "/editSuppliersIsDefault", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String editSuppliersIsDefault(HttpServletRequest request) {

		String json = "0";
		String ids = request.getParameter("ids");
		String isDefault = request.getParameter("isDefault");
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "2";
		}
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("ids", ids);
			parm.put("isDefault", isDefault);
			parm.put("updateBy", ((Users) user).getId());

			suppliersService.editSuppliersStatus(parm);
			json = "1";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@RequestMapping(value = "/editSuppliersIsLock", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String editSuppliersIsLock(HttpServletRequest request) {

		String json = "0";
		String ids = request.getParameter("ids");
		String isLock = request.getParameter("isLock");
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "2";
		}
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("ids", ids);
			parm.put("isLock", isLock);
			parm.put("updateBy", ((Users) user).getId());

			suppliersService.editSuppliersStatus(parm);
			json = "1";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// delSuppliers
	@RequestMapping(value = "/delSuppliers", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String delSuppliers(HttpServletRequest request) {

		String json = "0";
		String ids = request.getParameter("ids");
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "2";
		}
		try {
			suppliersService.delSuppliers(ids);
			json = "1";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 跳转我的商品 (搜索)
	@RequestMapping("toProductEdit")
	public String toProductEdit(FiltratePage page, HttpServletRequest request) {

		try {
			// 所有品类(便于已有条件展现)
			List<ProductCategory> productCategory = productCategoryService
					.findProductCategory();
			request.setAttribute("productCategory",
					JSONArray.fromObject(productCategory).toString());
			// 父品类
			List<ProductCategory> productCategorys = productCategoryService
					.getAllSSS();
			request.setAttribute("productCategorys", productCategorys);
			// 查询省份信息（用户选择地区）
			List<Dictionarys> dictionarys = dictionaryService
					.findProvinceInfo();
			request.setAttribute("dictionarys", dictionarys);
			// 筛选页显示商品信息
			List<Products> products = productsService.webfindProducts(page);
			request.setAttribute("products", products);
			Integer rows = productsService.webfindRows(page);
			page.setRows(rows);
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			/* request.setAttribute("page", page); */
			return "merchant/productEdit";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	@RequestMapping(value = "/checksupply", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String checksupply(HttpServletRequest request) {
		String json = "{'result':'false'}";
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			String productId = request.getParameter("productId");
			Map<String, Object> maps = new HashMap<>();
			maps.put("productId", productId);
			maps.put("companyId", user.getCompanyId());
			List<CompanyProducts> companyProduct = companyProductsService
					.findCompanyProductsbyCompanyIdProdcuts(maps);
			if (companyProduct.size() > 0) {
				json = "{'result':'true'}";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return json;
	}

	// 商品编辑(精确查找)
	@RequestMapping("searchProduct")
	public String searchProduct(HttpServletRequest request) {
		try {
			// 根据货号或商品名称查找
			String code = request.getParameter("code");
			Products product = productsService.findByCode(code);
			request.setAttribute("product", product);
			return "redirect:toProductEdit.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 商品编辑(模糊查找)
	@RequestMapping("searchProduct2")
	public String searchProduct2(HttpServletRequest request) {
		try {
			// 根据品类、品牌、规格、商品查找
			return "redirect:toProductEdit.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 跳转新增商品
	@RequestMapping("toProductEdit2")
	public String toProductEdit2(HttpServletRequest request, Model model) {
		try {
			List<ProductCategory> productCategorys = productCategoryService
					.getAllSSS();
			request.setAttribute("productCategorys", productCategorys);
			List<Dictionarys> dictionary = dictionaryService
					.getDicsByDicType(2);
			model.addAttribute("dictionarys", dictionary);
			// 查询省份信息（用户选择地区）
			List<Dictionarys> dictionarys = dictionaryService
					.findProvinceInfo();
			request.setAttribute("dictionarys", dictionarys);
			String productType = request.getParameter("productType");
			request.setAttribute("productType", productType);

			return "merchant/productEdit2";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 新增商品编辑
	@RequestMapping("productEdit")
	public String productEdit(HttpServletRequest request,Products product ) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			// 保存商品相对应信息
			if (product.getId() == null) {
				productsService.insert(product);
			}
			// 保存供应商商品信息
			CompanyProducts companyProduct = new CompanyProducts();
			companyProduct.setCompanyId(user.getCompanyId());
			companyProduct.setProductId(product.getId());
			companyProduct.setUnitPrice(BigDecimal.valueOf(Double
					.valueOf(request.getParameter("unitPrice"))));
			companyProduct.setStatus(3);
			// 是否供应商提供商品小样
			String isSample = request.getParameter("isSample");
			if (isSample != null && isSample.equals("1")) {
				companyProduct.setIsSample(1);// 1代表提供商品小样
			} else {
				companyProduct.setIsSample(0);// 0代表不提供商品小样
			}

			companyProductsService.addCompanyProduct(companyProduct);
			Integer companyProductId = companyProduct.getId();

			// 区间价信息
			String priceRange = request.getParameter("priceRange");
			String[] priceRanges = priceRange.split(",");
			CompanyProductPrice companyProductPrice2 = new CompanyProductPrice();
			companyProductPrice2.setMinNum(BigDecimal.valueOf(0));
			companyProductPrice2.setMaxNum(BigDecimal.valueOf(500));
			companyProductPrice2.setCompanyProductId(companyProductId);
			companyProductPrice2.setUserId(user.getId());
			companyProductPrice2.setPrice(BigDecimal.valueOf(Double
					.parseDouble(priceRanges[0])));
			companyProductPriceService.insert(companyProductPrice2);
			CompanyProductPrice companyProductPrice3 = new CompanyProductPrice();
			companyProductPrice3.setMinNum(BigDecimal.valueOf(500));
			companyProductPrice3.setMaxNum(BigDecimal.valueOf(1000));
			companyProductPrice3.setCompanyProductId(companyProductId);
			companyProductPrice3.setUserId(user.getId());
			companyProductPrice3.setPrice(BigDecimal.valueOf(Double
					.parseDouble(priceRanges[1])));
			companyProductPriceService.insert(companyProductPrice3);
			CompanyProductPrice companyProductPrice4 = new CompanyProductPrice();
			companyProductPrice4.setMinNum(BigDecimal.valueOf(1000));
			companyProductPrice4.setMaxNum(BigDecimal.valueOf(2000));
			companyProductPrice4.setCompanyProductId(companyProductId);
			companyProductPrice4.setUserId(user.getId());
			companyProductPrice4.setPrice(BigDecimal.valueOf(Double
					.parseDouble(priceRanges[2])));
			companyProductPriceService.insert(companyProductPrice4);
			CompanyProductPrice companyProductPrice5 = new CompanyProductPrice();
			companyProductPrice5.setMinNum(BigDecimal.valueOf(2000));
			companyProductPrice5.setCompanyProductId(companyProductId);
			companyProductPrice5.setUserId(user.getId());
			companyProductPrice5.setPrice(BigDecimal.valueOf(Double
					.parseDouble(priceRanges[3])));
			companyProductPriceService.insert(companyProductPrice5);

			// 存储仓库数量信息
			String goodsNum = request.getParameter("goodsNum");
			Storage storage = new Storage();
			storage.setGoodsId(product.getId());
			storage.setGoodsNum(BigDecimal.valueOf(Integer.valueOf(goodsNum)));
			storage.setSupplierId(user.getId());
			storageService.insert(storage);

			// 商品图片信息
			String isDefault = request.getParameter("isDefault");
			/*
			 * String[] isDefs; if (isDefault.indexOf(',') == (-1)) { isDefs =
			 * new String[] { isDefault }; } else { isDefs =
			 * isDefault.split(","); }
			 */
			String[] isDefs = isDefault.split(",");
			String[] safetys = request.getParameter("safetys").split(",");
			/*
			 * JSONObject obj = JSONObject.fromObject(request
			 * .getParameter("safetys"));
			 */

			// 保存商品相对应图片信息
			// 创建一个通用的多部分解析器
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
					request.getSession().getServletContext());
			// 判断 request 是否有文件上传,即多部分请求
			if (multipartResolver.isMultipart(request)) {
				// 转换成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				int flag1 = 1;
				int flag2 = 1;
				Integer isDef = 1;
				Integer safety = 1;
				// 取得request中的所有文件名
				Iterator<String> iter = multiRequest.getFileNames();

				while (iter.hasNext()) {
					// 取得上传文件
					MultipartFile file = multiRequest.getFile(iter.next());
					if (file != null) {
						// 取得当前上传文件的文件名称
						String myFileName = file.getOriginalFilename();
						// 判断文件是否存在
						if (myFileName.trim() != "") {
							// 定义上传路径
							String path = request.getSession()
									.getServletContext()
									.getRealPath(File.separator);
							File webrootPath = new File(path + "/frontImg/"
									+ companyProductId);
							if (!webrootPath.isDirectory()) {
								webrootPath.mkdirs();
							}
							// 存储商品图片
							CompanyProductPic productpic = new CompanyProductPic();
							productpic.setCompanyProductsId(companyProductId);
							// 存储商品图片信息
							if (flag1 < isDefs.length) {
								isDef = Integer.valueOf(isDefs[flag1++]);
								productpic.setIsDefault(isDef);

								// 插入商品图片到表productpic中
								productpic.setFileClass(1);
								companyProductPicService.insertPic(productpic);
								// 存储商品安全认证信息
								path = webrootPath + File.separator
										+ productpic.getId() + ".jpg";
								/* String path = "E:/" + fileName; */
								productpic = companyProductPicService
										.findbyId(productpic.getId());
								productpic.setFilePath("/frontImg/"
										+ companyProductId + "/"
										+ productpic.getId() + ".jpg");
								companyProductPicService.update(productpic);
								File localFile = new File(path);
								file.transferTo(localFile);
							} else {
								safety = Integer.valueOf(safetys[flag2++]);
								productpic.setFileClass(safety);
								productpic.setUploadBy(user.getId());
								// if(productPic1.getIsDefault()==1)
								// 插入商品安全认证到表companyproductpic中
								companyProductPicService.insertPic(productpic);
								// 重命名上传后的文件名
								path = webrootPath + File.separator
										+ productpic.getId() + ".jpg";
								/* String path = "E:/" + fileName; */
								productpic = companyProductPicService
										.findbyId(productpic.getId());
								productpic.setFilePath("/frontImg/"
										+ companyProductId + "/"
										+ productpic.getId() + ".jpg");
								companyProductPicService.update(productpic);
								File localFile = new File(path);
								file.transferTo(localFile);
							}

						}
					}
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());

		}

		String s = "";
		String productType = request.getParameter("productType");
		if (productType != null || productType != "") {
			s += "?productType=" + productType;
		}

		return "redirect:toProductEdit4.do" + s;
	}

	@RequestMapping("toProductEdit4")
	public String toProductEdit4(Page page, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			Map<String, Object> parm2 = new HashMap<>();
			parm2.put("companyId", user.getCompanyId());
			parm2.put("fileClass", "2,3,4,5,6,7");
			parm2.put("page", page);
			List<CompanyProducts> productLists2 = companyProductsService
					.webfindProductPicbyCompanyId(parm2);
			page.setRows(companyProductsService
					.webfindProductPicbyCompanyIdRows(parm2));
			/* request.setAttribute("productEdit4Page",productLists2); */
			/*
			 * request.setAttribute("productEdit4Page",JSONObject.fromObject(page
			 * ).toString());
			 */
			request.setAttribute("productList", productLists2);
			String jsonPage = JSONObject.fromObject(page).toString();
			request.setAttribute("jsonPages", jsonPage);
			request.setAttribute("productLists",
					JSONArray.fromObject(productLists2).toString());
		} catch (Exception e) {
			e.printStackTrace();
			Common.setLog(e);
		}
		return "merchant/productEdit4";
	}

	// 上传认证资料
	@RequestMapping(value = "uploadSafetyfile", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String uploadSafetyfile(HttpServletRequest request) {
		String json = "false";
		// 创建一个通用的多部分解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名;
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if (myFileName.trim() != "") {
						// 定义上传路径

						String path = request.getSession().getServletContext()
								.getRealPath(File.separator);
						Users user = (Users) request.getSession().getAttribute(
								"user");
						Integer companyProductId = Integer.parseInt(request
								.getParameter("companyProductId"));
						Integer fileclass = Integer.parseInt(request
								.getParameter("fileClass"));

						File webrootPath = new File(path + "/frontImg/"
								+ companyProductId);
						if (!webrootPath.isDirectory()) {
							webrootPath.mkdirs();
						}
						// 存储商品图片
						CompanyProductPic productpic = new CompanyProductPic();
						productpic.setCompanyProductsId(companyProductId);
						productpic.setFileClass(fileclass);
						productpic.setUploadBy(user.getId());
						productpic.setStatus(0);

						// 插入商品安全认证到表companyproductpic中
						companyProductPicService.insertPic(productpic);
						// 重命名上传后的文件名
						path = webrootPath + File.separator
								+ productpic.getId() + ".jpg";
						/* String path = "E:/" + fileName; */
						productpic = companyProductPicService
								.findbyId(productpic.getId());
						productpic.setFilePath("/frontImg/" + companyProductId
								+ "/" + productpic.getId() + ".jpg");
						companyProductPicService.update(productpic);
						json = JSONObject.fromObject(productpic).toString();
						File localFile = new File(path);
						try {
							file.transferTo(localFile);
						} catch (Exception e) {
							e.printStackTrace();
							return json;
						}
					}
				}
			}
		}
		return json;
	}

	// 跳转商品上下架
	@RequestMapping("toProductEdit3")
	public String toProductEdit3(HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			Page page1 = new Page();
			String currentPage = request.getParameter("currentPage1");
			page1.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			Page page2 = new Page();
			currentPage = request.getParameter("currentPage2");
			page2.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			Map<String, Object> parm1 = new HashMap<>();
			parm1.put("companyId", user.getCompanyId());
			parm1.put("status", "1");
			parm1.put("page", page1);
			List<Map<String, Object>> productLists1 = companyProductsService
					.findProductsbyCompanyId(parm1);
			int rows1 = companyProductsService
					.findProductsbyCompanyIdRows(parm1);
			page1.setRows(rows1);
			request.getSession().setAttribute("productPage1",
					JSONObject.fromObject(page1).toString());
			request.setAttribute("productLists1", productLists1);

			Map<String, Object> parm2 = new HashMap<>();
			parm2.put("companyId", user.getCompanyId());
			parm2.put("status", "0");
			parm2.put("page", page2);

			List<Map<String, Object>> productLists2 = companyProductsService
					.findProductsbyCompanyId(parm2);
			int rows2 = companyProductsService
					.findProductsbyCompanyIdRows(parm2);
			page2.setRows(rows2);
			request.getSession().setAttribute("productPage2",
					JSONObject.fromObject(page2).toString());
			request.setAttribute("productLists2", productLists2);

			String show = request.getParameter("show");
			if (show == null || show.isEmpty()) {
				show = "1";
			}
			request.setAttribute("show", show);
			return "merchant/productEdit3";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 商品上货中进入商品编辑页面
	@RequestMapping("toEditCompanyProducts")
	public String toEditCompanyProducts(Integer id, Model model) {
		CompanyProducts companyproducts = companyProductsService
				.findProductInfoById(id);
		model.addAttribute("companyproducts", companyproducts);

		return "merchant/updateCompanyProduct";
	}

	// 保存商品编辑页面修改的信息
	@RequestMapping("updateCompanyProductsInfo")
	public String updateCompanyProductsInfo(CompanyProducts companyproduct,
			Model model) {
		try {
			companyProductsService.updateProductInfo(companyproduct);
			return "redirect:toProductEdit3.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	/**
	 * 批量删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/editCompanyProductsStatus", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String editCompanyProductsStatus(HttpServletRequest request) {
		String result = "0";
		try {
			String ids = request.getParameter("ids");
			String status = request.getParameter("status");
			Users user = (Users) request.getSession().getAttribute("user");
			if (user == null) {
				return "2";
			}
			Map<String, Object> parm = new HashMap<>();
			parm.put("ids", ids);
			parm.put("status", status);
			parm.put("companyId", user.getCompanyId());

			companyProductsService.changeCompanyProductStatus(parm);
			result = "1";
		} catch (Exception e) {
			Common.setLog(e);
		}
		return result;
	}

	// 报价单
	@RequestMapping("myPriceSheet")
	public String myPriceSheet(Page page, HttpServletRequest request) {
		String json = "";
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			if (user == null) {
				return "redirect:/web/toIndex.do";
			}
			// 获取用户ID
			Integer userId = user.getId();
			// 获取当次传值的询价单号
			String ids = request.getParameter("ids");
			String inquiryId = request.getParameter("inquiryId");
			// 搜索条件
			String priceSheetId = request.getParameter("priceSheetId");
			String productName = request.getParameter("productName");
			String companyName = request.getParameter("companyName");
			String createDateStart = request.getParameter("createDateStart");
			String createDateStop = request.getParameter("createDateStop");
			String status = request.getParameter("status");
			if (priceSheetId != null) {
				priceSheetId = priceSheetId.trim();
			}
			if (productName != null) {
				productName = productName.trim();
			}
			if (companyName != null) {
				companyName = companyName.trim();
			}
			if (createDateStart != null) {
				createDateStart = createDateStart.trim();
			}
			if (createDateStart != null) {
				createDateStop = createDateStop.trim();
			}
			if (status != null) {
				status = status.trim();
			}
			request.setAttribute("priceSheetId", priceSheetId);
			request.setAttribute("productName", productName);
			request.setAttribute("companyName", companyName);
			request.setAttribute("createDateStart", createDateStart);
			request.setAttribute("createDateStop", createDateStop);
			request.setAttribute("status", status);
			
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("ids", ids);
			parm.put("status", "0,1,2,3,4,5");
			parm.put("priceSheetId", priceSheetId);
			parm.put("productName", productName);
			parm.put("companyName", companyName);
			parm.put("createDateStart", createDateStart);
			parm.put("createDateStop", createDateStop);
			parm.put("status1", status);
			List<Map<String, Object>> priceSheet = priceSheetService
					.getPriceSheetInfo(parm);
			request.setAttribute("priceSheet", priceSheet);
			request.setAttribute("supplierId", user.getId());

			// String result=checkProductSample(Integer supplierId, Integer
			// CompanyProductID, Model model);

			int rows = priceSheetService.getPriceSheetInfoRow(parm);
			page.setRows(rows);
			request.getSession().setAttribute("webPriceSheetPage", page);
			json = JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);

			request.setAttribute("userId", userId);
			request.setAttribute("page", page);
			request.setAttribute("ids", ids);
			request.setAttribute("inquiryId", inquiryId);
			return "merchant/myPriceSheet";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	/**
	 * 商品资质显示
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/productsCertificate")
	public String productsCertificate(Integer id, Integer companyID, Model model) {

		try {
			Map<String, Integer> parm = new HashMap<>();
			parm.put("id", id);
			parm.put("companyID", companyID);
			List<CompanyProductPic> productsCertificate = companyProductPicService
					.findCompanyProductPicByProductId(parm);

			model.addAttribute("productsCertificate", productsCertificate);

			return "merchant/productsCertificate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 报价单
	@RequestMapping("splitPriceSheet")
	public String splitPriceSheet(HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			// 获取当次传值的订单号
			String id = request.getParameter("id");
			if (id != null && id.isEmpty() == false) {
				Orders order = orderService.findById(Integer.valueOf(id));
				request.setAttribute("order", order);
				// 取出询价单，根据询价单比配相关的配送地址
				InquirySheet inquirySheet = inquirySheetService
						.findByInquiryId(order.getOrderId());
				// 获取配送地址
				List<ShoppingAddress> shopAdds = ShoppingAddressService
						.findbyShoppingAddress(user.getCompanyId(),
								inquirySheet.getAddress());
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
			}
			return "merchant/myPriceSheet3";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 添加收藏
	@RequestMapping("addMyCollection")
	public String addMyCollection(HttpServletRequest request) {
		int pid = Integer.parseInt(request.getParameter("pid"));
		int favoriteType = Integer.parseInt(request
				.getParameter("favoriteType"));
		String addrsss = request.getParameter("addrsss");
		Users user = (Users) request.getSession().getAttribute("user");
		Integer uid = user.getId();
		Map<String, Object> parm = new HashMap<>();
		parm.put("userId", uid);
		parm.put("productId", pid);
		parm.put("favoriteType", favoriteType);
		if (favoriteService.findbyProdcutId(parm) == null) {
			Favorite favorite = new Favorite();
			favorite.setProductId(pid);
			favorite.setUserId(uid);
			favorite.setFavoriteType(favoriteType);
			favorite.setFavoriteAddress(addrsss);
			favoriteService.add(favorite);
		}
		return "redirect:myCollection.do?favoriteType=" + favoriteType;
	}

	/**
	 * 添加收货地址
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/addShoppingAddress", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String addShoppingAddress(HttpServletRequest request) {
		String json = "";
		try {
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String shortAddress = request.getParameter("shortAddress");
			String[] addrs = address.split(",");
			Users user = (Users) request.getSession().getAttribute("user");

			ShoppingAddress shoppingAddress = new ShoppingAddress();
			for (int i = 0; i < addrs.length; i++) {
				switch (i) {
				case 0:
					shoppingAddress.setProvince(Integer.valueOf(addrs[i]));
					break;
				case 1:
					shoppingAddress.setCity(Integer.valueOf(addrs[i]));
					break;
				case 2:
					shoppingAddress.setDistrict(Integer.valueOf(addrs[i]));
				}
			}
			shoppingAddress.setShoppingAddress(detailAddress);
			shoppingAddress.setAdderssName(shortAddress);
			shoppingAddress.setUserId(user.getId());
			shoppingAddress.setCompanyId(user.getCompanyId());
			ShoppingAddressService.insertPurchaserAddress(shoppingAddress);
			shoppingAddress = ShoppingAddressService
					.findbyShoppingAddressId(shoppingAddress.getId());
			json = JSONObject.fromObject(shoppingAddress).toString();
		} catch (Exception e) {
			Common.setLog(e);
			return "false";
		}
		return json;
	}

	@RequestMapping(value = "/AddPriceSheet", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddPriceSheet(HttpServletRequest request) {

		String json = "{'result':'false'}";
		String data = request.getParameter("data");
		Object user = request.getSession().getAttribute("user");
		// Integer companyId=((Users)user).getCompanyId();
		if (user == null) {
			return "{'result':'1'}";
		}

		try {
			JSONArray obj = JSONArray.fromObject(data);
			for (int i = 0; i < obj.size(); i++) {
				JSONObject jo = (JSONObject) obj.get(i);
				String ids = jo.get("id").toString();
				// 报价并修改询价单信息

				Map<String, Object> parm = new HashMap<>();
				parm.put("ids", ids);
				parm.put("times", jo.get("time").toString());
				parm.put("num", jo.get("num").toString());
				parm.put("address", jo.get("address").toString());

				priceSheetService.addByIds(parm);
				// 修改询价单状态
				// inquirySheetService.deleteInquirySheetInfo(ids);
				json = "{'result':'true','ids':'" + ids + "'}";
			}

		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@RequestMapping(value = "/AddDispatchBill", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddDispatchBill(HttpServletRequest request) {

		String json = "{'result':'false'}";
		String orderid = request.getParameter("orderid");
		String jsonData = request.getParameter("DispatchBill");
		Object objUser = request.getSession().getAttribute("user");

		if (objUser == null) {
			return "{'result':'1'}";
		}
		if (orderid == null || orderid.isEmpty()) {
			return "{'result':'2'}";
		}
		try {
			Orders order = orderService.findById(Integer.valueOf(orderid));
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
			orderService.update(order);
			json = "{'result':'true'}";
		} catch (Exception e) {
			Common.setLog(e);
		}
		return json;
	}

	// 议价单数据展示，发起议价，显示议价单
	@RequestMapping("toBargaining")
	public String toBargaining(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			// 获取当次传值的询价单号
			String ids = request.getParameter("ids");
			Map<String, Object> parm = new HashMap<>();
			parm.put("userId", userId);
			parm.put("page", page);
			parm.put("ids", ids);
			parm.put("status", "0");
			List<Map<String, Object>> list = priceSheetService
					.getBargainingInfo(parm);
			int rows = priceSheetService.getBargainingInfoRow(parm);
			page.setRows(rows);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("status", "0");
			request.setAttribute("ids", ids);
			return "merchant/myPriceSheet2";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 议价
	@RequestMapping("Bargaining")
	public String Bargaining(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			// 获取当次传值的询价单号
			String ids = request.getParameter("ids");
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", user.getCompanyId());
			parm.put("page", page);
			parm.put("ids", ids);
			parm.put("status", "2");
			List<Map<String, Object>> list = priceSheetService
					.getCompanyBargainingInfo(parm);
			int rows = priceSheetService.getCompanyBargainingInfoRow(parm);
			page.setRows(rows);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			request.setAttribute("status", "2");
			request.setAttribute("ids", ids);
			return "merchant/myPriceSheet2";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	@RequestMapping("ProcessBargainPrice")
	public String ProcessBargainPrice(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			// 获取当次传值的询价单号
			String ids = request.getParameter("ids");
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", user.getCompanyId());
			parm.put("page", page);
			parm.put("ids", ids);
			parm.put("status", "3,4");
			List<Map<String, Object>> list = priceSheetService
					.getCompanyBargainingInfo(parm);
			int rows = priceSheetService.getCompanyBargainingInfoRow(parm);
			page.setRows(rows);
			request.setAttribute("list", list);
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("status", "3,4");
			request.setAttribute("ids", ids);
			return "merchant/myPriceSheet2";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 议价
	@RequestMapping(value = "/EidtPriceSheet", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String EidtPriceSheet(HttpServletRequest request) {

		String json = "{'result':'false'}";
		String priceSheetID = request.getParameter("priceSheetID");
		String jsonData = request.getParameter("bargainPrice");
		Object objUser = request.getSession().getAttribute("user");
		String status = request.getParameter("status");
		if (objUser == null) {
			return "{'result':'1'}";
		}
		if (priceSheetID == null || priceSheetID.isEmpty()) {
			return "{'result':'2'}";
		}
		try {
			// 采购商发起议价，填写议价价格，将状态更改为2
			JSONArray obj = JSONArray.fromObject(jsonData);
			for (int i = 0; i < obj.size(); i++) {
				JSONObject jo = (JSONObject) obj.get(i);
				PriceSheet priceSheet = new PriceSheet();
				priceSheet.setId(Integer.valueOf(jo.get("id").toString()));
				switch (status) {
				case "2":
					priceSheet.setStatus(2);
					priceSheet.setBargainPrice(new BigDecimal(jo.get("num")
							.toString()));
					priceSheet.setIsBargain(1);
					break;
				case "3":
				case "4":
					priceSheet.setStatus(Integer.valueOf(status));
					priceSheet.setUnitPrice(new BigDecimal(jo.get("num")
							.toString()));
					break;
				}
				priceSheetService.bargaining(priceSheet);
			}
			json = "{'result':'true'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 议价下订单
	@RequestMapping("placeOrder")
	public String xiadan(HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			// 获取当次传值的订单号

			String priceSheetID = request.getParameter("priceSheetID");
			if (priceSheetID != null && priceSheetID.isEmpty() == false) {
				Orders order = orderService.findById(Integer
						.valueOf(priceSheetID));
				request.setAttribute("order", order);
				// 取出询价单，根据询价单比配相关的配送地址
				InquirySheet inquirySheet = inquirySheetService
						.findByInquiryId(order.getOrderId());
				// 获取配送地址
				List<ShoppingAddress> shopAdds = ShoppingAddressService
						.findbyShoppingAddress(user.getCompanyId(),
								inquirySheet.getAddress());
				request.setAttribute("shopAdds", shopAdds);
			}

			return "merchant/myPriceSheet3";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 发货单(配送单)
	// 采购商查看本人订单所有配送单
	@RequestMapping("myDispatchBill")
	public String myDispatchBill(OrderPage page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();

			// 验收单搜索条件
			String orderCode = request.getParameter("orderCode");
			String productName = request.getParameter("productName");
			String supplierName = request.getParameter("supplierName");
			String status = request.getParameter("status");
			if (orderCode != null) {
				orderCode = orderCode.trim();
			}
			if (productName != null) {
				productName = productName.trim();
			}
			if (supplierName != null) {
				supplierName = supplierName.trim();
			}
			if (status != null) {
				status = status.trim();
			}
			request.setAttribute("orderCode", orderCode);
			request.setAttribute("productName", productName);
			request.setAttribute("supplierName", supplierName);
			request.setAttribute("status", status);
			
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("userRole", "PurchaseUser");
			parm.put("orderCode", orderCode);
			parm.put("productName", productName);
			parm.put("supplierName", supplierName);
			parm.put("status", status);
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			/* request.setAttribute("page", page); */
			request.setAttribute("userRole", "PurchaseUser");
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 查看被拆分的订单的验收情况
	@RequestMapping("acceptanceDetails")
	public String acceptanceDetails(OrderPage page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			String id = request.getParameter("id");
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("userRole", "PurchaseUser");
			parm.put("id", id);
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			request.setAttribute("userRole", "PurchaseUser");
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	/**
	 * 订单查看拆分发货单(配送单)
	 * 
	 * @param page
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/dispatchBillsOfOrder", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String dispatchBillsOfOrder(String orderId,
			HttpServletRequest request) {
		String json = "";
		try {
			List<DispatchBill> dispatchBill = dispatchBillService
					.findOrderId(orderId);
			json = JSONArray.fromObject(dispatchBill).toString();
			json = "{" + '\"' + "dispatchBill" + '\"' + ":" + json + "," + '\"'
					+ "userRole" + '\"' + ":'PurchaseUser'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	// 发货单(配送单)
	// 采购商查看公司所有配送单
	@RequestMapping("myDispatchBillToCompany")
	public String myDispatchBillToCompany(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			// Integer userId = .getId();

			// 公司验收单搜索条件
			String orderCode = request.getParameter("orderCode");
			String productName = request.getParameter("productName");
			String supplierName = request.getParameter("supplierName");
			String status = request.getParameter("status");
			if (orderCode != null) {
				orderCode = orderCode.trim();
			}
			if (productName != null) {
				productName = productName.trim();
			}
			if (supplierName != null) {
				supplierName = supplierName.trim();
			}
			if (status != null) {
				status = status.trim();
			}
			request.setAttribute("orderCode", orderCode);
			request.setAttribute("productName", productName);
			request.setAttribute("supplierName", supplierName);
			request.setAttribute("status", status);
			
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			// parm.put("userId", userId);
			parm.put("companyId", user.getCompanyId());
			parm.put("userRole", "PurchaseCompany");
			parm.put("orderCode", orderCode);
			parm.put("productName", productName);
			parm.put("supplierName", supplierName);
			parm.put("status", status);
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("compoanyId", user.getCompanyId());
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "PurchaseCompany");
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 发货单(配送单)
	// 采购商财务经理查看公司所有配送单
	@RequestMapping("myDispatchBillToFinancial")
	public String myDispatchBillToFinancial(Page page,
			HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			// Integer userId = .getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			// parm.put("userId", userId);
			parm.put("companyId", user.getCompanyId());
			parm.put("userRole", "PurchaseFinancial");
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("compoanyId", user.getCompanyId());
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "PurchaseFinancial");
			// 获取本公司所在部门的所有员工
			/*
			 * List<Users> users = userManagerService.webfindAllByCompanyId(user
			 * .getCompanyId());
			 */
			Map<String, Object> parm1 = new HashMap<>();
			parm1.put("companyId", user.getCompanyId());
			parm1.put("departmentId", user.getDepartmentId());
			List<Users> users = userManagerService.webfindAllByDepartID(parm1);

			request.setAttribute("users", users);
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 发货单(配送单)
	// 采购商查看部门所有配送单
	@RequestMapping("myDispatchBillToDepart")
	public String myDispatchBillToDepart(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			// Integer userId = user.getId();

			// 部门验收单搜索条件
			String orderCode = request.getParameter("orderCode");
			String productName = request.getParameter("productName");
			String supplierName = request.getParameter("supplierName");
			String status = request.getParameter("status");
			if (orderCode != null) {
				orderCode = orderCode.trim();
			}
			if (productName != null) {
				productName = productName.trim();
			}
			if (supplierName != null) {
				supplierName = supplierName.trim();
			}
			if (status != null) {
				status = status.trim();
			}
			request.setAttribute("orderCode", orderCode);
			request.setAttribute("productName", productName);
			request.setAttribute("supplierName", supplierName);
			request.setAttribute("status", status);
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("departId", user.getDepartmentId());
			parm.put("userRole", "PurchaseDepart");
			parm.put("orderCode", orderCode);
			parm.put("productName", productName);
			parm.put("supplierName", supplierName);
			parm.put("status", status);
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("departId", user.getDepartmentId());
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "PurchaseDepart");
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 发货单(配送单)
	// 供应商查看所有配送单
	@RequestMapping("myDispatchBillToSupplier")
	public String myDispatchBillToSupplier(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			// Integer userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("companyId", user.getCompanyId());
			parm.put("userRole", "Supplier");
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("companyId", user.getCompanyId());
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "Supplier");
			// 获取本公司的所有员工
			/*
			 * List<Users> users = userManagerService.webfindAllByCompanyId(user
			 * .getCompanyId());
			 */
			Map<String, Object> parm1 = new HashMap<>();
			parm1.put("companyId", user.getCompanyId());
			parm1.put("departmentId", user.getDepartmentId());
			List<Users> users = userManagerService.webfindAllByDepartID(parm1);
			request.setAttribute("users", users);
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 发货单(配送单)
	// 验收人查看所有配送单
	@RequestMapping("myDispatchBillToChecker")
	public String myDispatchBillToChecker(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("userRole", "Checker");
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "Checker");
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 修改配送单实收数
	@RequestMapping(value = "/EditPackagesNumber", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String EditPackagesNumber(HttpServletRequest request) {
		String json = "{'result':'false'}";
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		String packagesNum = request.getParameter("PackagesNum");
		try {
			JSONArray jsonNum = JSONArray.fromObject(packagesNum);
			for (int i = 0; i < jsonNum.size(); i++) {
				JSONObject obj = jsonNum.getJSONObject(i);
				dispatchBillService.updatePackagesNumber(obj.get("id")
						.toString(), obj.get("num").toString());
			}
			json = "{result:'true'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;

	}

	// 修改配送人
	@RequestMapping(value = "/editDispatchBillUser", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String editDispatchBillUser(HttpServletRequest request) {
		String json = "{'result':'false'}";
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		String userId = request.getParameter("user");
		String ids = request.getParameter("ids");
		String status = request.getParameter("status");
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("ids", ids);
			parm.put("userId", userId);
			parm.put("status", status);
			dispatchBillService.updateDispatchBillUser(parm);
			json = "{result:'true'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;

	}

	@RequestMapping("processContentInfo")
	public String processContentInfo(Page page, HttpServletRequest request) {
		Map<String, Object> parm = new HashMap<>();
		String dispatchBillId = request.getParameter("dispatchBillId");
		parm.put("refId", dispatchBillId);
		parm.put("page", page);
		// String refid = request.getParameter("dispatchBillId");
		try {
			List<Map<String, Object>> workflowLogsAndNodes = workflowLogsService
					.findbyRefId(parm);
			// System.out.println(workflowLogsAndNodes.size());

			JSONObject objPage = JSONObject.fromObject(page);
			request.setAttribute("workflowLogsAndNodes", workflowLogsAndNodes);
			request.setAttribute("json", objPage.toString());
			return "merchant/processContentInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 向流程审计表添加数据
	@RequestMapping(value = "/addWorkFlowLogs", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String insertWorkFlowLogs(HttpServletRequest request) {
		String json = "{'result':'false'}";
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		int userId = ((Users) user).getId();
		String jsonDatas = request.getParameter("jsonDatas");
		System.out.println(jsonDatas);
		// 先求jsonDatas数据的长度
		JSONArray jsonArray = JSONArray.fromObject(jsonDatas);
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonJ = jsonArray.getJSONObject(i);

			String dispatchBillId = jsonJ.getString("dispatchBillId");
			String processContent = jsonJ.getString("processContent");
			int processResult = jsonJ.getInt("processResult");
			int status = jsonJ.getInt("status");
			WorkflowLogs workflowLogs = new WorkflowLogs();
			switch (status) {
			case 0:
				if (processResult == 0) {
					workflowLogs.setNodeId(1);
				}
				break;
			case 2:
				if (processResult == 1) {
					workflowLogs.setNodeId(1);// 供应商指派配送
				} else {
					workflowLogs.setNodeId(2);
				}
				break;
			case 3:
				if (processResult == 1) {
					workflowLogs.setNodeId(2);// 配送填写实收
				} else {
					workflowLogs.setNodeId(3);
				}
				break;
			case 4:
				if (processResult == 1) {
					workflowLogs.setNodeId(3);// 验收实收
				} else {
					workflowLogs.setNodeId(4);
				}
				break;
			case 5:
				if (processResult == 1) {
					workflowLogs.setNodeId(4);// 财务指派审核
				} else {
					workflowLogs.setNodeId(5);
				}
				break;
			case 6:
				if (processResult == 1) {
					workflowLogs.setNodeId(5);// 财务审核
				}
				break;
			}
			workflowLogs.setWorkflowId(0);
			workflowLogs.setUserId(userId);
			workflowLogs.setRefId(dispatchBillId);
			workflowLogs.setProcessResult(processResult);
			workflowLogs.setProcessContent(processContent);

			workflowLogsService.insert(workflowLogs);

		}
		json = "{result:'true'}";
		return json;
	}

	// 退回操作
	@RequestMapping(value = "/EditDispatchBillStatus", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String EditDispatchBillStatus(HttpServletRequest request) {
		String json = "{'result':'false'}";
		Users user = (Users) request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		String status = request.getParameter("status");
		// String ids = request.getParameter("ids");
		String fileIds = request.getParameter("fileIds");
		try {
			dispatchBillService.updateDispatchBillStatus(fileIds.toString(),
					status);
			json = "{result:'true'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;

	}

	// 发货单(配送单)
	// 配送人查看所有配送单
	@RequestMapping("myDispatchBillToDeliveryUser")
	public String myDispatchBillToDeliveryUser(Page page,
			HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("userRole", "DeliveryUser");
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "DeliveryUser");
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 发货单(配送单)
	// 对账人查看所有配送单
	@RequestMapping("myDispatchBillToAccepter")
	public String myDispatchBillToAccepter(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取用户ID
			Integer userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("userRole", "Accepter");
			// 根据用户的公司ID，查看所有采购商配送单。
			List<DispatchBill> dispatchBill = dispatchBillService.getAll(parm);
			// 获取总条数
			int rows = dispatchBillService.getMyDispatchBillrows(parm);
			page.setRows(rows);
			request.setAttribute("dispatchBill", dispatchBill);
			request.setAttribute("userId", userId);
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			request.setAttribute("userRole", "Accepter");
			return "merchant/myDispatchBill";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 跳转购物车
	@RequestMapping("InquiryShoppingCar")
	public String toShoppingCar(Page page, HttpServletRequest request) {
		String jsonAddrs = "";
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer userId = user.getId();
			Integer departId = user.getDepartmentId();
			Integer companyId = user.getCompanyId();
			Map<String, Object> parm = new HashMap<String, Object>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("companyId", companyId);
			parm.put("departId", departId);
			/*
			 * for(int i = 0; i<list.size();i++){ Map<String, Object>
			 * map=list.get(i); map.put("cateGoryName",
			 * productCategoryService.getCategoryByCompanyId
			 * ((Integer)map.get("ID"))); list.set(i, map); }
			 */
			// 返回的是String
			// productCategoryService.getCategoryByCompanyId(companyId);
			int rows = shoppingCartService.findShopCartInfoRows(parm);
			page.setRows(rows);
			request.setAttribute("userId", userId);
			if (departId != null) {
				// 查询用户询价信息
				List<Map<String, Object>> list = shoppingCartService
						.findShopCartInfo(parm);
				request.setAttribute("departId", departId.toString());
				request.setAttribute("list", list);
			} else {
				// 查询用户询价信息
				List<Map<String, Object>> list = shoppingCartService
						.findShopCartInfo(parm);
				request.setAttribute("departId", "0");
				request.setAttribute("list", list);
			}

			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());

			// 获取checkBox中ID值
			String ids = request.getParameter("Uid");
			request.setAttribute("ids", ids);

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
			return "merchant/InquiryShoppingCar";

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}

	}

	// 询价购物车根据单个ID物理删除
	@RequestMapping("deleteShoppingCart")
	@ResponseBody
	public String deleteShoppingCart(Page page, HttpServletRequest request) {
		String json = "{'result':'false'}";
		try {

			Integer shoppingCartId = Integer.parseInt(request
					.getParameter("shoppingCartId"));
			BigDecimal productQuantity = new BigDecimal(
					request.getParameter("productQuantity"));

			shoppingCartService.updateShoppingCartStatus(shoppingCartId,
					productQuantity);
			json = "{'result':'true'}";
			return json;

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return json;
		}

	}

	// 跳转现货特供购物车
	@SuppressWarnings("null")
	@RequestMapping("spotShoppingCar")
	public String toSpotShoppingCar(Page page, HttpServletRequest request) {
		String jsonAddrs = "";
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer userId = user.getId();
			Integer departId = user.getDepartmentId();
			Integer companyId = user.getCompanyId();
			Map<String, Object> parm = new HashMap<String, Object>();
			parm.put("page", page);
			parm.put("userId", userId);
			parm.put("companyId", companyId);
			parm.put("departId", departId);

			/*
			 * for(int i = 0; i<list.size();i++){ Map<String, Object>
			 * map=list.get(i); map.put("cateGoryName",
			 * productCategoryService.getCategoryByCompanyId
			 * ((Integer)map.get("ID"))); list.set(i, map); }
			 */
			// 返回的是String
			// productCategoryService.getCategoryByCompanyId(companyId);
			int rows = shoppingCartService.findSpotShopCartInfoRows(parm);
			page.setRows(rows);
			request.setAttribute("userId", userId);
			if (departId != null) {//普通子账户购物车信息
				// / 现货购物车查询详细信息
				List<Map<String, Object>> list = shoppingCartService
						.findSpotShopCartInfo(parm);
				request.setAttribute("departId", departId.toString());
				request.setAttribute("list", list);
			} else {//最大账户购物车信息
				// 现货购物车查询详细信息
				List<Map<String, Object>> list = shoppingCartService
						.findSpotShopCartInfo(parm);
				request.setAttribute("departId", "0");
				request.setAttribute("list", list);
			
			}
			
			/* request.setAttribute("page", page); */
			request.setAttribute("json", JSONObject.fromObject(page).toString());
			// 获取checkBox中ID值
			String ids = request.getParameter("Uid");
			request.setAttribute("ids", ids);
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
			return "merchant/spotShoppingCar";

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}

	}

	@RequestMapping("CompanyShoppingCar")
	public String CompanyShoppingCar(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			if (user != null) {
				Integer userId = user.getId();
				Map<String, Object> parm = new HashMap<String, Object>();
				parm.put("page", page);
				parm.put("companyId", user.getCompanyId());
				parm.put("departId", user.getDepartmentId());
				// 查询用户询价信息
				List<Map<String, Object>> list = shoppingCartService
						.findShopCartCompany(parm);
				int rows = shoppingCartService.findShopCartCompanyRows(parm);
				page.setRows(rows);
				request.setAttribute("userId", userId);
				request.setAttribute("companyId", user.getCompanyId());
				request.setAttribute("page", page);
				request.setAttribute("list", list);
				// 获取checkBox中ID值
				String ids = request.getParameter("Uid");
				request.setAttribute("ids", ids);
			}
			return "merchant/CompanyShoppingCar";

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	@RequestMapping("CompanyShoppingCarItem")
	public String CompanyShoppingCarItem(Page page, HttpServletRequest request) {
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("user");
			if (user != null) {
				Integer userId = user.getId();
				String companyId = request.getParameter("companyId");
				String departId = request.getParameter("departId");
				String productId = request.getParameter("productId");
				String addressId = request.getParameter("addressId");
				Map<String, Object> parm = new HashMap<String, Object>();
				parm.put("page", page);
				parm.put("companyId", companyId);
				parm.put("departId", departId);
				parm.put("productId", productId);
				parm.put("addressId", addressId);
				// 查询用户询价信息
				List<Map<String, Object>> list = shoppingCartService
						.findShopCartCompanyItem(parm);
				int rows = shoppingCartService
						.findShopCartCompanyItemRows(parm);
				page.setRows(rows);
				request.setAttribute("userId", userId);
				request.setAttribute("companyId", companyId);
				request.setAttribute("departId", departId);
				request.setAttribute("productId", productId);
				request.setAttribute("addressId", addressId);
				/* request.setAttribute("page", page); */
				request.setAttribute("json", JSONObject.fromObject(page)
						.toString());
				request.setAttribute("list", list);
				// 获取checkBox中ID值
				String ids = request.getParameter("Uid");
				request.setAttribute("ids", ids);
			}
			return "merchant/InquiryShoppingCar";

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 逻辑删除报价单信息
	@RequestMapping("deletePriceSheetInfo")
	public void deletePriceSheetInfo(PriceSheet priceSheet,
			HttpServletRequest request) {
		try {
			Integer priceSheetId = Integer.valueOf(request
					.getParameter("priceSheetID"));
			priceSheet.setId(priceSheetId);
			priceSheetService.deletePriceSheetInfo(priceSheet);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}

	// 添加到询价单并生成询价单编号
	@RequestMapping(value = "/AddToInquiry", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String shoppingCar(HttpServletRequest request) {
		String json = "{'result':'false'}";
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		Companys company = companyService.webfindById(((Users) user)
				.getCompanyId());
		switch (company.getStatus()) {
		case 0:
			return "{'result':'2'}";
		case 2:// 公司状态2表示认证信息审核中
			return "{'result':'3'}";
		}
		String shoppingCartId = request.getParameter("shoppingCartId");
		String num = request.getParameter("productQuantity");
		String address = request.getParameter("addressShopping");

		// 获取购物车信息
		ShoppingCart shoppingCart = shoppingCartService.findById(Integer
				.parseInt(shoppingCartId));
		Integer productId = shoppingCart.getProductId();
		InquirySheet inquirySheet = new InquirySheet();
		// BigDecimal productQuantity = shoppingCart.getProductQuantity();
		// String address = shoppingCart.getAddress();
		/*
		 * String num =request.getParameter("productQuantity2");
		 */

		// 生成询价单号

		// 用户修改的产品数量
		BigDecimal productQuantity2 = BigDecimal.valueOf(Double.valueOf(num));
		inquirySheet.setUserId(((Users) user).getId());
		inquirySheet.setProductID(productId);
		inquirySheet.setProductQuantity(productQuantity2);
		inquirySheet.setAddress(address);
		inquirySheet.setCurrency("CNY");

		try {
			inquirySheetService.add(inquirySheet);

			json = "{result:'true',inquiryId:'" + inquirySheet.getInquiryId()
					+ "'}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		// 逻辑删除购物车信息
		shoppingCartService.updateShoppingCartStatus(
				Integer.parseInt(shoppingCartId), productQuantity2);
		return json;

	}

	// 添加到询价单并生成询价单编号
	@RequestMapping(value = "/AddInquiry", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddInquiry(HttpServletRequest request) {
		String json = "{'result':'false'}";
		Object user = request.getSession().getAttribute("user");
		if (user == null) {
			return "{'result':'1'}";
		}
		// 逻辑删除购物车信息
		String shoppingIds = request.getParameter("shoppingIds");
		if (shoppingIds == null || shoppingIds.isEmpty()) {
			return "{'result':'2'}";
		}
		try {
			JSONArray data = JSONArray.fromObject(shoppingIds);
			for (int i = 0; i < data.size(); i++) {
				InquirySheet inquirySheet = new InquirySheet();
				JSONObject obj = (JSONObject) data.get(i);
				// 生成询价单号
				inquirySheet.setUserId(((Users) user).getId());
				inquirySheet.setCurrency("CNY");
				inquirySheet.setProductID(Integer.valueOf(obj.get("id")
						.toString()));
				inquirySheet.setProductQuantity(new BigDecimal(obj.get("num")
						.toString()));
				inquirySheet.setAddress(obj.get("addressId").toString());
				inquirySheetService.add(inquirySheet);
				if (inquirySheet.getInquiryId() != null) {
					json = "{result:'true',inquiryId:'"
							+ inquirySheet.getInquiryId() + "'}";
					// 提交过的购物车，需要及时更新状态
					String companyId = obj.get("companyId").toString();
					String departId = obj.get("departId").toString();
					String productId = obj.get("productId").toString();
					String addressId = obj.get("addressId").toString();
					Map<String, Object> parm = new HashMap<String, Object>();
					parm.put("companyId", companyId);
					parm.put("departId", departId);
					parm.put("productId", productId);
					parm.put("addressId", addressId);
					// 查询用户询价信息
					List<Map<String, Object>> list = shoppingCartService
							.findShopCartCompanyItem(parm);
					StringBuilder sb = new StringBuilder();
					for (int j = 0; j < list.size(); j++) {
						sb.append(list.get(j).get("ShoppingCartId").toString());
						sb.append(",");
					}
					shoppingCartService
							.editShoppingCartStatus(sb.toString(), 1);
				}
			}

		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;

	}

	// 配送管理
	@RequestMapping("distributionManagement")
	public String distributionManagement(HttpServletRequest request) {
		try {
			return "merchant/distributionManagement";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 订单配送
	@RequestMapping("orderDistribution")
	public String orderDistribution(HttpServletRequest request) {
		try {
			return "merchant/orderDistribution";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 存入商品小样信息
	@RequestMapping("addProductSample")
	public String addProductSample(ProductSample productSample, Model model,
			HttpServletRequest request) {
		try {
			String ids = request.getParameter("ids");
			String s = "";
			productsService.insertProductSample(productSample);
			if (ids != null || ids != "") {
				s += "?ids=" + ids;
			}
			return "redirect:/merchant/myPriceSheet.do" + s;
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 比较指定商品小样的申请时间
	@RequestMapping("checkProductSample")
	@ResponseBody
	public String checkProductSample(Integer supplierId,
			Integer CompanyProductID, Model model) {
		String json = "";
		try {
			Map<String, Integer> parm = new HashMap<>();
			parm.put("supplierId", supplierId);
			parm.put("CompanyProductID", CompanyProductID);
			Date RequestTime = productsService.checkProductSample(parm);
			Date dNow = new Date();
			Calendar calendar = Calendar.getInstance(); // 得到日历
			if (RequestTime != null) {
				calendar.setTime(RequestTime);// 把当前时间赋给日历
				calendar.add(calendar.MONTH, 3); // 设置为前3月
				RequestTime = calendar.getTime();
				SimpleDateFormat sdf = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss"); // 设置时间格式

				String RequestTime1 = sdf.format(RequestTime); // 格式化前3月的时间
				String dNow1 = sdf.format(dNow);

				int result = dNow1.compareTo(RequestTime1);

				json = "{'result':'" + result + "'}";
			} else {
				if (supplierId != null && CompanyProductID != null) {
					json = "{'result':'true'}";
				} else {
					json = "{'result':'false'}";
				}

			}
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return json;
		}
	}

	/**
	 * 工作台商品下架
	 */
	@RequestMapping("/undercarriage")
	public String undercarriage(Integer id, Model model) {
		try {
			companyProductsService.changeCheck(id, 0);
			return "redirect:toPurchaserList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 工作台商品上架
	 */
	@RequestMapping("/grounding")
	public String grounding(Integer id, Model model) {
		try {
			companyProductsService.changeCheck(id, 1);
			return "redirect:toPurchaserList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
