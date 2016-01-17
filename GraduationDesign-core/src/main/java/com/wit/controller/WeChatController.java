package com.wit.controller;


import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.wit.model.InquirySheet;
import com.wit.model.Page;
import com.wit.service.InquirySheetService;
import com.wit.comm.Common;
import com.wit.model.AccountStatementPage;
import com.wit.model.CompanyBalanceStatement;
import com.wit.model.Companys;
import com.wit.model.DeliveryInquiryPage;
import com.wit.model.DispatchBill;
import com.wit.model.FiltratePage;
import com.wit.model.MyOrderPage;
import com.wit.model.OfferInquiryPage;
import com.wit.model.OrderInquiryPage;
import com.wit.model.Orders;
import com.wit.model.Page;
import com.wit.model.Products;
import com.wit.model.SecondPage;
import com.wit.model.SettleInquiryPage;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.model.PriceInquiryPage;
import com.wit.service.CompanyBalanceStatementService;
import com.wit.service.CompanysService;
import com.wit.service.DispatchBillService;
import com.wit.service.OrdersService;
import com.wit.service.PriceSheetService;
import com.wit.service.SettlementService;
import com.wit.service.SystemLogsService;
import com.wit.service.UserService;


@Controller

@SessionAttributes({"offerInquiryPage","priceInquiryPage","settleInquiryPage","accountStatementPage","deliveryInquiryPage","myOrderPage","orderInquiryPage"})

@RequestMapping("/weChat")
public class WeChatController extends BaseController{
	@Autowired
	private PriceSheetService priceSheetService;
	
	@Autowired
	private InquirySheetService inquirySheetService;
	
	@Autowired
	private SettlementService settlementService;

	@Autowired
	private CompanysService companyService;

	@Autowired
	private UserService userService;

	@Autowired
	private SystemLogsService systemLoggerService;

	@Autowired
	private OrdersService ordersService;
	
	@Autowired
	private DispatchBillService dispatchBillService;
	
	@Autowired
	private CompanyBalanceStatementService companyBalanceStatementService;

			// 查询询价单
			@RequestMapping("findMyInquiry")
			public String myInquiry(PriceInquiryPage page, HttpServletRequest request) {
				// 获取登录用户信息
				Users user = (Users) request.getSession().getAttribute("weChatUser");
				page.setCurrentPage(1);
				Map<String, Object> parm = new HashMap<>(); 	
				parm.put("userId", user.getId());
				parm.put("page", page);
				//查询用户询价单信息
				List<Map<String, Object>> inquirySheets= inquirySheetService.weChatFindAllByIds(parm);
				page.setRows(inquirySheetService.weChatFindAllRowsByIds(parm));
				request.setAttribute("inquirySheets", inquirySheets);			
				request.setAttribute("currentPage", ""+page.getCurrentPage());			
				request.getSession().setAttribute("priceInquiryPage", page);
				return "WeChat/priceInquiry";
			}
			// 查询更多询价单
			@RequestMapping(value = "/findMoreMyInquiry", produces = { "application/json;charset=UTF-8" })
			@ResponseBody
			public String findMoreMyInquiry(PriceInquiryPage page, HttpServletRequest request) {
				String json = "false";
				try {
					// 获取登录用户信息
					Users user = (Users) request.getSession().getAttribute("weChatUser");			
					Map<String, Object> parm = new HashMap<>();
					parm.put("userId", user.getId());
					parm.put("page", page);
					//查询用户询价单信息
					List<Map<String, Object>> inquirySheets= inquirySheetService.weChatFindAllByIds(parm);
					page.setRows(inquirySheetService.weChatFindAllRowsByIds(parm));
					request.getSession().setAttribute("priceInquiryPage", page);
					json = JSONArray.fromObject(inquirySheets).toString();
					json = "{" + '\"' + "inquirySheets" + '\"' + ":" + json +"}";
				} catch (Exception e) {
					Common.setLog(e);
					return json;
				}
				return json;
			}
			
			
			
			// 查询报价单
			@RequestMapping("findOfferInquiry")
			public String findOfferInquiry(OfferInquiryPage page, HttpServletRequest request) {
				try {
				page.setCurrentPage(1);
				// 获取登录用户信息
				Users user = (Users) request.getSession().getAttribute("weChatUser");	
				Map<String, Object> parm = new HashMap<>();
				parm.put("userId", user.getId());
				parm.put("page", page);
				//查询用户询价单信息
				List<Map<String, Object>> priceSheets= priceSheetService.getWeChatPriceSheetInfo(parm);
				page.setRows(priceSheetService.getWeChatPriceSheetInfoRow(parm));
				request.setAttribute("priceSheets", priceSheets);	
				request.getSession().setAttribute("offerInquiryPage", page);
				request.setAttribute("currentPage", ""+page.getCurrentPage());			
				
				} catch (Exception e) {
					Common.setLog(e);
					return "";
				}
				return "WeChat/offerInquiry";
			}
			// 查询更多报价单
			@RequestMapping(value = "/findMoreOfferInquiry", produces = { "application/json;charset=UTF-8" })
			@ResponseBody
			public String findMoreOfferInquiry(OfferInquiryPage page, HttpServletRequest request) {
				String json = "false";
			try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("weChatUser");			
			Map<String, Object> parm = new HashMap<>();
			parm.put("userId", user.getId());
			parm.put("page", page);
			//查询用户询价单信息
			List<Map<String, Object>> priceSheets= priceSheetService.getWeChatPriceSheetInfo(parm);
			page.setRows(priceSheetService.getWeChatPriceSheetInfoRow(parm));
			//查询用户询价单信息
			request.getSession().setAttribute("offerInquiryPage", page);
			json = JSONArray.fromObject(priceSheets).toString();
			json = "{" + '\"' + "priceSheets" + '\"' + ":" + json + "}";
			} catch (Exception e) {
				Common.setLog(e);
				return json;
			}
			return json;
		}
			// 查询结算单
			@RequestMapping("findSettlement")
			public String findSettlement(SettleInquiryPage page, HttpServletRequest request) {
				try {
					page.setCurrentPage(1);
				// 获取登录用户信息
				Users user = (Users) request.getSession().getAttribute("weChatUser");			
				Map<String, Object> parm = new HashMap<>();
				parm.put("companyId", user.getCompanyId());
				parm.put("page", page);
				//查询用户询价单信息
				List<Map<String, Object>> settlements= settlementService.findWeChatSettlementInfo(parm);				
				page.setRows(settlementService.findWeChatSettlementInfoRow(parm));			
				request.setAttribute("settlements", settlements);	
				request.setAttribute("currentPage", ""+page.getCurrentPage());			
				request.getSession().setAttribute("settleInquiryPage", page);
			} catch (Exception e) {
				Common.setLog(e);
				return "";
			}
				return "WeChat/settleInquiry";
			}
		// 查询更多结算单
			@RequestMapping(value = "/findMoreSettlement", produces = { "application/json;charset=UTF-8" })
			@ResponseBody
			public String findMoreSettlement(SettleInquiryPage page, HttpServletRequest request) {
				String json = "false";
			try {
			// 获取登录用户信息
			Users user = (Users) request.getSession().getAttribute("weChatUser");			
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", user.getCompanyId());
			parm.put("page", page);
			//查询用户询价单信息
			List<Map<String, Object>> settlements= settlementService.findWeChatSettlementInfo(parm);	
			page.setRows(settlementService.findWeChatSettlementInfoRow(parm));
			//查询用户询价单信息
			request.getSession().setAttribute("settleInquiryPage", page);
			json = JSONArray.fromObject(settlements).toString();
			json = "{" + '\"' + "settlements" + '\"' + ":" + json + "}";
			} catch (Exception e) {
				e.printStackTrace();
				Common.setLog(e);
				return json;
			}
			return json;
		}
	
	/*
	 * 跳转到订单查询页面
	 */
	@RequestMapping("toOrder")
	public String toOrder(HttpServletRequest request) {
		return "WeChat/order";
	}

	/*
	 * 订单查询
	 */
	@RequestMapping("order")
	public String order(OrderInquiryPage page, HttpServletRequest request) {
		try {
			// 获取用户登录信息
			//Users user = (Users) request.getSession().getAttribute("weChatUser");
			Users user = (Users) request.getSession().getAttribute("weChatUser");
			if (user == null) {
				return "redirect:/weChat/toLogin.do";
			}
			if(page.getEndOrderTime()!=null){
				 java.util.Date endOrderTime = page.getEndOrderTime();
			     Calendar   calendar   =   new   GregorianCalendar(); 
			     calendar.setTime(endOrderTime); 
			     calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
			     endOrderTime= calendar.getTime();
			     java.sql.Date date2 = new java.sql.Date(endOrderTime.getTime());
			     page.setEndOrderTime(date2);
			}
			page.setCurrentPage(1);
			Map<String, Object> parm = new HashMap<>(); 	
			parm.put("userId", user.getId());
			parm.put("page", page);
			List<Map<String, Object>> orders = ordersService.findOrders(parm);
			request.setAttribute("orders", orders);
			page.setRows(ordersService.findRowsOrder(parm));
			request.setAttribute("currentPage", ""+page.getCurrentPage());
			request.getSession().setAttribute("orderInquiryPage", page);
			return "WeChat/orderInquiry";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
// 查询更多询价单
	@RequestMapping(value = "/orderMore", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String orderMore(OrderInquiryPage page, HttpServletRequest request) {
		String json = "false";
		try {
			// 获取登录用户信息
			Users user = (Users) request.getSession()
					.getAttribute("weChatUser");
			
			if(page.getEndOrderTime()!=null){
				 java.util.Date endOrderTime = page.getEndOrderTime();
			     Calendar   calendar   =   new   GregorianCalendar(); 
			     calendar.setTime(endOrderTime); 
			     calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
			     endOrderTime= calendar.getTime();
			     java.sql.Date date2 = new java.sql.Date(endOrderTime.getTime());
			     page.setEndOrderTime(date2);
			}
			
			Map<String, Object> parm = new HashMap<>();
			parm.put("userId", user.getId());
			parm.put("page", page);
			// 查询用户询价单信息
			List<Map<String, Object>> orders = ordersService.findOrders(parm);
			request.setAttribute("orders", orders);
			page.setRows(ordersService.findRowsOrder(parm));
			request.getSession().setAttribute("orderInquiryPage", page);
			//json = JSONObject.fromObject(page).toString();u
			json = JSONArray.fromObject(orders).toString();
			json = "{" + '\"' + "orders" + '\"' + ":" + json + "}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}
	/*
	 * 订单查询条件改变(查询字段名称)
	 */
	@RequestMapping("orderInquiry")
	public String orderInquiry(MyOrderPage page, HttpServletRequest request) {
		try {
			// 获取用户登录信息
			//Users user = (Users) request.getSession().getAttribute("weChatUser");
			Users user = (Users) request.getSession().getAttribute("weChatUser");
			if (user == null) {
				return "redirect:/weChat/toLogin.do";
			}
			
			if(page.getEndOrderTime()!=null){
				 java.util.Date endOrderTime = page.getEndOrderTime();
			     Calendar   calendar   =   new   GregorianCalendar(); 
			     calendar.setTime(endOrderTime); 
			     calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
			     endOrderTime= calendar.getTime();
			     java.sql.Date date2 = new java.sql.Date(endOrderTime.getTime());
			     page.setEndOrderTime(date2);
			}
			
			page.setCurrentPage(1);
			// 获取用户ID
			int userId = user.getId();
			Map<String, Object> parm = new HashMap<String, Object>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<Map<String, Object>> orders = ordersService
					.findOrderInquiry(parm);
			request.setAttribute("orders", orders);
			System.out.println(orders);
			page.setRows(ordersService.findRowsOrderInquiry(parm));
			request.setAttribute("currentPage", ""+page.getCurrentPage());
			request.getSession().setAttribute("myOrderPage", page);
			return "WeChat/myOrder";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	// 查询更多询价单
		@RequestMapping(value = "/orderInquiryMore", produces = { "application/json;charset=UTF-8" })
		@ResponseBody
		public String orderInquiryMore(MyOrderPage page, HttpServletRequest request) {
			String json = "false";
			try {
				// 获取登录用户信息
				Users user = (Users) request.getSession()
						.getAttribute("weChatUser");
				
				if(page.getEndOrderTime()!=null){
					 java.util.Date endOrderTime = page.getEndOrderTime();
				     Calendar   calendar   =   new   GregorianCalendar(); 
				     calendar.setTime(endOrderTime); 
				     calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
				     endOrderTime= calendar.getTime();
				     java.sql.Date date2 = new java.sql.Date(endOrderTime.getTime());
				     page.setEndOrderTime(date2);
				}
				
				Map<String, Object> parm = new HashMap<>();
				parm.put("userId", user.getId());
				parm.put("page", page);
				List<Map<String, Object>> orders = ordersService
						.findOrderInquiry(parm);
				request.setAttribute("orders", orders);
				page.setRows(ordersService.findRowsOrderInquiry(parm));
				request.getSession().setAttribute("myOrderPage", page);
				//json = JSONObject.fromObject(page).toString();u
				json = JSONArray.fromObject(orders).toString();
				json = "{" + '\"' + "orders" + '\"' + ":" + json + "}";
			} catch (Exception e) {
				Common.setLog(e);
				return json;
			}
			return json;
		}
	
	// 跳转登录页面
	@RequestMapping("toLogin")
	public String toLogin(HttpServletRequest request) {
		String json = "";
		Users user = (Users) request.getSession().getAttribute("weChatUser");

		// 登录过
		if (user != null) {
			// 判断是否认证
			// 获取登录用户的公司ID
			Integer companyId = user.getCompanyId();
			if (companyId == null) {
				return "WeChat/weLogin";
			} else {
				// 根据公司ID获取公司类型
				Companys companys = companyService.findById(companyId);
				if (companys == null) {
					return "WeChat/weLogin";
				} else {
					Integer status = companys.getStatus();
					if (status == 0) {
						// 未认证,重定向到认证页面
						return "redirect:/merchant/toCompanyAuthentication.do";
					} else {
						// 已认证，重定向到后台首页
						return "redirect:/merchant/toPurchaserList.do";
					}
				}
			}
		} else {
			// 没登录过则跳转登录页面
			return "WeChat/weLogin";
		}
	}

	// 登录
	@RequestMapping("login")
	@ResponseBody
	public String login(HttpServletRequest request) {
		try {
			// 获取用户输入登录名(用户编号，邮箱，电话)
			String userCode = request.getParameter("userCode");
			// 获取用户输入登录密码
			String userPsw = request.getParameter("userPsw");
			// 获取用户输入的验证码
			/*
			 * String yzm = request.getParameter("yzm"); // 获取页面生成的验证码 String
			 * imageCode = (String) request.getSession().getAttribute(
			 * "certCode");
			 */
			// 根据用户名查找用户信息
			Users user = userService.findUsers(userCode);
			if (user != null) {
				if (userPsw == null || userPsw == "") {
					// 请输入密码
					return "null2Error";
				} else if (user.getUserPsw() == null
						|| user.getUserPsw().equals(Common.md5(userPsw)) == false) {
					// 密码错误
					return "pwdError";
				}/*
				 * else if (yzm == null || yzm == "") { // 请输入验证码 return
				 * "null3Error"; } else if (yzm.equalsIgnoreCase(imageCode) ==
				 * false) { // 验证码不正确 return "yzmError"; }
				 */else {
					// 将用户信息存入session传给后台页面
					HttpSession session = request.getSession();
					session.setAttribute("weChatUser", user);
					/*
					 * 判断用户类型 （商户用户还是系统用户） userType =1 系统用户 userType = 2 商户用户
					 * 商户用户可以登录，系统用户不能登录
					 */
					Integer userType = user.getUserType();
					if (userType == 1)
						return "typeError";
					else {
						// 判断用户状态
						Integer userStatus = user.getStatus();
						switch (userStatus) {
						/*
						 * case 0: //初始 return "initial"; case 1: //可用 return
						 * "usable";
						 */
						case 2:
							// 冻结
							return "freeze";
						case 3:
							// 删除
							return "delete";
						}
						// 将用户的登录动作及登录时间写入系统日志
						SystemLogs form = new SystemLogs();
						String ip = request.getRemoteAddr();
						StringBuilder sb = new StringBuilder();
						sb.append(Common.getDateTimeNow());
						sb.append(user.getUserName());
						sb.append("登录平台");
						sb.append(",   ");
						sb.append("IP");
						sb.append(":");
						sb.append(ip);
						form.setLogContent(sb.toString());
						form.setLogTime(Common.getDateTimeNow());
						form.setLogType(user.getUserType());
						form.setLogBy(user.getId());
						this.systemLoggerService.AddLog(form);
						// 获取登录用户的公司ID
						Integer companyId = user.getCompanyId();
						// 根据公司ID获取公司类型
						Companys companys = companyService
								.findLoginStatus(companyId);
						if (companys != null) {
							Integer status = companys.getStatus();
							// 判断公司认证状态
							if (status == 0) {
								// 未认证
								return "authenticationError";
							} else if (status == 2) {
								// 公司信息已删除
								return "companyDelete";
							} else {
								// 商户后台
								return "success";
							}

						}
						return "authenticationError";
					}
				}
			} else {
				if (userCode == null || userCode == "") {
					// 请输入用户名
					return "nullError";
				} else {
					// 用户名不存在
					return "nameError";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}
	//配送单查看查询页面(许昌博)
	@RequestMapping("myDispatchBill")
	public String myDispatchBill(DeliveryInquiryPage page,  HttpServletRequest request){
		// 获取登录用户信息
		try{	
			page.setCurrentPage(1);
			    Users user = (Users) request.getSession().getAttribute("weChatUser");
				if (user == null) {
					return "redirect:/weChat/toLogin.do";
				}

	/*	        String shoppingAddressName=request.getParameter("shoppingAddressName");
		        String dispatchBillId=request.getParameter("dispatchBillId");
		        String deliveryUserName=request.getParameter("deliveryUserName");
		        String status=request.getParameter("status");*/
		        Map<String,Object> parm=new HashMap<>();
		        parm.put("companyId",  user.getCompanyId());
		     /*   parm.put("shoppingAddressName", shoppingAddressName);
		        parm.put("dispatchBillId", dispatchBillId);
		        parm.put("deliveryUserName", deliveryUserName);
		        parm.put("status", status);*/
		        parm.put("page", page);
		       List<DispatchBill> dispatchBill=dispatchBillService.findBillByCompanyId(parm);
		       page.setRows(dispatchBillService.findBillRowByCompanyId(parm));
		       request.setAttribute("dispatchBill", dispatchBill);
		       request.getSession().setAttribute("deliveryInquiryPage", page);
		       request.setAttribute("currentPage", ""+page.getCurrentPage());
		       return"WeChat/deliveryInquiry";
		       } catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("InfoMessage",
							"信息载入失败！具体异常信息：" + e.getMessage());
		return"";
		       }
		
	}
	// 查询更多配送单
				@RequestMapping(value = "/findMoreDispatchBill", produces = { "application/json;charset=UTF-8" })
				@ResponseBody
				public String findMoreDispatchBill(DeliveryInquiryPage page, HttpServletRequest request) {
					String json = "false";
				try {
				// 获取登录用户信息
				Users user = (Users) request.getSession().getAttribute("weChatUser");			
				Map<String, Object> parm = new HashMap<>();
				parm.put("companyId", user.getCompanyId());
				parm.put("page", page);
				//查询用户配送单信息
				 List<DispatchBill> dispatchBill=dispatchBillService.findBillByCompanyId(parm);
				 page.setRows(dispatchBillService.findBillRowByCompanyId(parm));
				//查询用户配送单信息
				request.getSession().setAttribute("deliveryInquiryPage", page);
				json = JSONArray.fromObject(dispatchBill).toString();
				json = "{" + '\"' + "dispatchBill" + '\"' + ":" + json + "}";
				} catch (Exception e) {
					Common.setLog(e);
					return json;
				}
				return json;
			}
	//对账单查看页面(许昌博)
	@RequestMapping("companyStatement")
	public String companyStatement(AccountStatementPage page, HttpServletRequest request){
		try{	
			page.setCurrentPage(1);
			   Users user = (Users) request.getSession().getAttribute("weChatUser");
		    	Map<String, Object> parm = new HashMap<>(); 	
				parm.put("companyId", user.getCompanyId());
				parm.put("page", page);
			List<CompanyBalanceStatement> accountStatements=companyBalanceStatementService.findStatementByCompanyId(parm);
			page.setRows(companyBalanceStatementService.findStatementRowsByCompanyId(user.getCompanyId()));
			request.setAttribute("currentPage", ""+page.getCurrentPage());			
			request.getSession().setAttribute("accountStatementPage", page);
			request.setAttribute("accountStatements", accountStatements);		
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return""; 
	}
		return"WeChat/AccountStatement";
	}
		// 查询更多对账单
		@RequestMapping(value = "/findMoreCompanyStatement", produces = { "application/json;charset=UTF-8" })
		@ResponseBody
		public String findMoreCompanyStatement(AccountStatementPage page, HttpServletRequest request) {
			String json = "false";
		try {
		// 获取登录用户信息
		Users user = (Users) request.getSession().getAttribute("weChatUser");			
		Map<String, Object> parm = new HashMap<>();
		parm.put("companyId", user.getCompanyId());
		parm.put("page", page);
		//查询用户询价单信息
		List<CompanyBalanceStatement> accountStatements=companyBalanceStatementService.findStatementByCompanyId(parm);
		//查询用户询价单信息
		request.getSession().setAttribute("accountStatementPage", page);
		json = JSONArray.fromObject(accountStatements).toString();
		json = "{" + '\"' + "accountStatements" + '\"' + ":" + json + "}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}
}
