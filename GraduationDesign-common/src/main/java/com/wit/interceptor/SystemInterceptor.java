package com.wit.interceptor;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wit.comm.Common;
import com.wit.model.Menus;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.service.MenusService;
import com.wit.service.SystemLogsService;
@Repository
public class SystemInterceptor extends HandlerInterceptorAdapter {

	@SuppressWarnings("unused")
	@Autowired
	private SystemLogsService systemLoggerService;
	@Autowired
	private MenusService menusService;

	private Log log;

	/*
	 * * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle
	 * (javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		// 后台session控制
		// String[] noFilters = new String[] { "login.do",
		// "veriCode.do","index.do", "logout.do" };
		List<String> noFilters = new ArrayList<String>();
		noFilters.add("toLogin.do");
		noFilters.add("toMain.do");
		noFilters.add("linkTop.do");
		noFilters.add("linkLeft.do");
		noFilters.add("linkRight.do");
		noFilters.add("toIndex.do");
		noFilters.add("toSecondIndex.do");
		noFilters.add("toProductsList.do");
		noFilters.add("login.do");
		noFilters.add("toLogin.do");
		noFilters.add("toReg.do");
		noFilters.add("reg.do");
		noFilters.add("toWjmm.do");
		noFilters.add("wjmm.do");
		noFilters.add("toAqrz.do");
		noFilters.add("verification.do");
		noFilters.add("aqrz.do");
		noFilters.add("toReset.do");
		noFilters.add("reset.do");
		noFilters.add("xgcg.do");
		noFilters.add("ljdl.do");
		noFilters.add("toInvoiceAdd.do");
		noFilters.add("invoiceAdd.do");
		noFilters.add("invoiceSign.do");
		noFilters.add("commonProblem.do");
		noFilters.add("purchaserInvoiceSend.do");
		noFilters.add("listProductTypes.do");
		noFilters.add("listProductCategoryson.do");
		noFilters.add("toCompanyAuthentication.do");
		noFilters.add("getUserForHeader.do");
		noFilters.add("getNewsListForHeader.do");
		noFilters.add("getMenusListForHeader.do");
		noFilters.add("addWorkFlowLogs.do");
		noFilters.add("provinceUrbanLinkage.do");
		noFilters.add("merchantAccountManager.do");
		noFilters.add("AddInquirySheet.do");
		noFilters.add("uploadAuthenticationfile.do");
		noFilters.add("deleteAuthenticationInfo.do");
		noFilters.add("completeMerchantAccountInfo.do");
		noFilters.add("authenticationInfoList.do");
		noFilters.add("toPurchaserList.do");
		noFilters.add("toAddBankAccount.do");
		noFilters.add("addBankAccount.do");
		noFilters.add("AddFavorite.do");
		noFilters.add("DelFavorite.do");
		noFilters.add("addShoppingCart.do");
		noFilters.add("toSpotPriceIndex.do");
		noFilters.add("addShoppingAddress.do");
		noFilters.add("grounding.do");
		noFilters.add("undercarriage.do");
		noFilters.add("addProvince.do");
		noFilters.add("addTitle.do");
		noFilters.add("sysAddTitle.do");
		noFilters.add("reconciliation.do");
		noFilters.add("getFAQForFooter.do");
		noFilters.add("spotProduct.do");
		noFilters.add("findProductByModel.do");
		noFilters.add("spotShoppingCar.do");
		noFilters.add("InquiryShoppingCar.do");
		noFilters.add("myCollection.do?favoriteType=2");
		noFilters.add("myCollection.do?favoriteType=1");
		noFilters.add("deleteShoppingCart.do");
		noFilters.add("findProductBrand.do");
		noFilters.add("searchNewsInfo.do");
		
		
		//微信端
		noFilters.add("findMyInquiry.do");
		noFilters.add("findSettlement.do");
		noFilters.add("findMoreSettlement.do");
		noFilters.add("myDispatchBill.do");
		noFilters.add("findMoreDispatchBill.do");
		noFilters.add("findMoreMyInquiry.do");
		noFilters.add("findOfferInquiry.do");
		noFilters.add("findMoreOfferInquiry.do");
		noFilters.add("toOrder.do");
		noFilters.add("order.do");
		noFilters.add("orderMore.do");
		noFilters.add("orderInquiry.do");
		noFilters.add("orderInquiryMore.do");
		noFilters.add("companyStatement.do");
		noFilters.add("findMoreCompanyStatement.do");
		noFilters.add("pastStatement.do");
		

		//noFilters.add("toUpdateJobs.do.do");

		noFilters.add("toUpdateJobs.do");

		String requestUrl = request.getRequestURI();
		String[] uri = requestUrl.split("/");

		boolean beFilter = true;
		Object objUser = null;
		if (uri.length > 0) {
			beFilter = !noFilters.contains(uri[uri.length - 1]);
		}

		/*
		 * for (String s : noFilters) { if (uri.indexOf(s) != -1) { beFilter =
		 * false; break; } }
		 */
		if (beFilter) {
			// web
			String url = uri[uri.length - 2].toLowerCase();
			switch (url) {
			case "web":
			case "website":
				return super.preHandle(request, response, handler);
			case "merchant":
				objUser = request.getSession().getAttribute("user");
				if (null == objUser) {
					// 未登录
					PrintWriter out = response.getWriter();
					StringBuilder builder = new StringBuilder();
					builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
					// builder.append("alert(\"页面过期，请重新登录\");");
					builder.append("window.top.location.href=\"");
					builder.append(request.getContextPath());
					builder.append("/web/toLogin.do\";</script>");
					out.print(builder.toString());
					out.close();
					return false;
				}
				break;
			default:
				objUser = request.getSession().getAttribute("userInfo");
				if (null == objUser) {
					// 未登录
					PrintWriter out = response.getWriter();
					StringBuilder builder = new StringBuilder();
					builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
					builder.append("window.top.location.href=\"");
					builder.append(request.getContextPath());
					builder.append("/main/toLogin.do\";");
					builder.append("</script>");
					out.print(builder.toString());
					out.close();
					return false;
				}
				break;
			}

			Users user = (Users) objUser;

			List<Menus> menusList = null;
			try {
				Map<String, Object> parm = new HashMap<>();
				parm.put("userID", user.getId());
				parm.put("patform", user.getUserType());
				parm.put("menuType", 0);
				parm.put("status", 1);
				parm.put("menuUrl", requestUrl);
				menusList = menusService.getMenusByMenuUrl(parm);

			} catch (Exception ex) {
				log.debug(ex.toString());
			}
			if (menusList == null || menusList.size() == 0) {
				// 未登录

				PrintWriter out = response.getWriter();
				StringBuilder builder = new StringBuilder();
				builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
				builder.append("alert(\"对不起，你没有操作权限，请与管理员联系\");");
				builder.append("window.history.go(-1);");
				builder.append("</script>");
				out.print(builder.toString());
				out.close();
				return false;
			}
			// 添加日志 判断页面权限
			String operateContent = request.getContextPath();
			if (null != operateContent) {
				String ip = request.getRemoteAddr();
				// Integer userId = ((Users) obj).getId();
				SystemLogs form = new SystemLogs();
				StringBuilder sb = new StringBuilder();
				sb.append(user.getUserName());
				sb.append(":");
				sb.append(ip);
				sb.append(",");
				sb.append(requestUrl);

				form.setLogContent(sb.toString());
				form.setLogTime(Common.getDateTimeNow());
				switch (url) {
				case "web":
				case "website":
				case "merchant":
					form.setLogType(Common.UserType.Merchant.getIndex());
					break;
				default:
					form.setLogType(Common.UserType.Manager.getIndex());
					break;
				}
				form.setLogBy(user.getId());
				try {
					this.systemLoggerService.AddLog(form);
				} catch (Exception ex) {
					log.debug(ex.toString());
				}
			}
		}

		Map paramsMap = request.getParameterMap();

		for (Iterator<Map.Entry> it = paramsMap.entrySet().iterator(); it
				.hasNext();) {
			Map.Entry entry = it.next();
			Object[] values = (Object[]) entry.getValue();
			for (Object obj : values) {

				if (sqlValidate(obj.toString())) {
					// throw new RuntimeException("有非法字符：" + obj);
					PrintWriter out = response.getWriter();
					StringBuilder builder = new StringBuilder();
					builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
					builder.append("alert(\"有非法字符：");
					builder.append(obj.toString());
					builder.append("\");");
					builder.append("window.top.location.href=\"");
					builder.append(request.getContextPath());
					builder.append("/main/toError.do\";</script>");
					out.print(builder.toString());
					out.close();
					return false;
				}

			}
		}

		return super.preHandle(request, response, handler);

	}

	// 效验
	protected boolean sqlValidate(String str) {
		str = str.toLowerCase();// 统一转为小写
		StringBuilder badStr = new StringBuilder();
		badStr.append("exec|execute|insert|select|delete|update|count|drop|*|%|chr|mid|master|truncate|");
		badStr.append("char|declare|sitename|net user|xp_cmdshell|;|+|exec|execute|insert|create|drop|");
		badStr.append("table|from|grant|use|group_concat|column_name|");
		badStr.append("information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|");
		badStr.append("chr|mid|master|truncate|char|declare|;|--|+|like|%|#");// 过滤掉的sql关键字，可以手动添加
		String[] badStrs = badStr.toString().split("\\|");

		for (int i = 0; i < badStrs.length; i++) {
			if (str.indexOf(" "+badStrs[i]+" ") >=0) {
				return true;
			}
		}
		return false;
	}
}