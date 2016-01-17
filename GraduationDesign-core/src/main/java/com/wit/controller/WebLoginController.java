package com.wit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.CacheManager;
import com.wit.comm.Cache;
import com.wit.comm.Common;
import com.wit.comm.JavaSmsApi;
import com.wit.comm.MailSend;
import com.wit.model.Companys;
import com.wit.model.FAQ;
import com.wit.model.PasswordUnlocker;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.service.CompanysService;
import com.wit.service.FAQService;
import com.wit.service.PasswordUnlockerService;
import com.wit.service.SystemLogsService;
import com.wit.service.UserService;

@Controller
@RequestMapping("/web")
public class WebLoginController {

	@Autowired
	private UserService userService;

    @Autowired
    private SystemLogsService systemLoggerService;
    
	@Autowired
	private CompanysService companyService;
	
	@Autowired
	private PasswordUnlockerService passwordUnlockerService;
	
	@Autowired
	private FAQService faqService;
	
	//编码格式。发送编码格式统一用UTF-8
    private static String ENCODING = "UTF-8";

	// 跳转登录页面
	@RequestMapping("toLogin")
	public String toLogin(HttpServletRequest request) {
		String json="";
		Users user = (Users)request.getSession().getAttribute("user");
		
		//登录过
		if(user != null){
			//判断是否认证
			// 获取登录用户的公司ID
			Integer companyId = user.getCompanyId();
			if(companyId == null){
				return "website/login";
			}else{
				// 根据公司ID获取公司类型
				Companys companys = companyService.findById(companyId);
				if(companys == null){
					return "website/login";
				}else{
					Integer status = companys.getStatus();
					if(status == 0){
						//未认证,重定向到认证页面
						return "redirect:/merchant/toCompanyAuthentication.do";
					}else{
						//已认证，重定向到后台首页
						return "redirect:/merchant/toPurchaserList.do";
					}
				}
			}
		}else{
			//没登录过则跳转登录页面
			return "website/login";
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
			String yzm = request.getParameter("yzm");
			// 获取页面生成的验证码
			String imageCode = (String) request.getSession().getAttribute(
					"certCode");
			// 根据用户名查找用户信息
			Users user = userService.findUsers(userCode);	
			if (user != null) {
				if (userPsw == null || userPsw == "") {
					// 请输入密码
					return "null2Error";
				} else if (user.getUserPsw().equals(Common.md5(userPsw)) == false) {
					// 密码错误
					return "pwdError";
				} else if (yzm == null || yzm == "") {
					// 请输入验证码
					return "null3Error";
				} else if (yzm.equalsIgnoreCase(imageCode) == false) {
					// 验证码不正确
					return "yzmError";
				} else {
					// 将用户信息存入session传给后台页面
					HttpSession session = request.getSession();
					session.setAttribute("user", user);
					/*判断用户类型 （商户用户还是系统用户）
					 * userType =1 系统用户
					 * userType = 2 商户用户
					 * 商户用户可以登录，系统用户不能登录
					 */
					Integer userType= user.getUserType();
					if (userType==1)
						return "typeError";
					else{						
					//判断用户状态
					Integer userStatus = user.getStatus();
					switch (userStatus) {
					/*case 0:
						//初始
						return "initial";
					case 1:
						//可用
						return "usable";*/
					case 2:
						//冻结
						return "freeze";
					case 3:
						//删除
						return "delete";
					}
					//将用户的登录动作及登录时间写入系统日志	
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
					Companys companys = companyService.findLoginStatus(companyId);
					if(companys!=null)
					{
						Integer status = companys.getStatus();
						// 判断公司认证状态
						if (status == 0) {
							// 未认证
							return "authenticationError";
						}else if(status == 2){
							//公司信息已删除
							return "companyDelete";
						}else {
							// 商户后台
							return "success";							
						}
						
					}				
					return "authenticationError";
				}
				}} 			
			else {
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

	// 跳转到找回密码页面
	@RequestMapping("toWjmm")
	public String toZhmm(HttpServletRequest request) {
		try {
			return "website/wjmm";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 找回密码用户名验证
	@RequestMapping("wjmm")
	@ResponseBody
	public String wjmm(HttpServletRequest request) {
		try {
			// 获取用户输入登录名(用户编号，邮箱，电话)
			String userCode = request.getParameter("userCode");
			//将用户输入的账号存入session
			request.getSession().setAttribute("zhanghao", userCode);
			// 获取用户输入的验证码
			String yzm = request.getParameter("yzm");
			// 获取页面生成的验证码
			String code = (String) request.getSession()
					.getAttribute("certCode");
			// 将用户名存入session
			HttpSession session = request.getSession();
			session.setAttribute("userCode", userCode);
			// 根据用户名查找
			Users user = userService.findUsers(userCode);
			if (user != null) {
				if (yzm == null || yzm == "") {
					// 请输入验证码
					return "null2Error";
				} else if (yzm.equals(code) == false) {
					// 验证码不正确
					return "yzmError";
				} else {
					return "success";
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

	// 到认证页面
	@RequestMapping("toAqrz")
	public String toAqrz(HttpServletRequest request) {
		try {
			return "website/aqrz";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	//发送手机验证码
	@RequestMapping("sendTelCode")
	@ResponseBody
	public String sendTelCode(HttpServletRequest request){
		//获取用户ID
		String userCode = (String)request.getSession().getAttribute("userCode");
		Users user = userService.findUsers(userCode);
		String json = "{'result':'false'}";
		try {
			//获取用户填写的手机号
			String mobile = request.getParameter("tel");
			//查询该手机号是否已存在
			Users user2 = userService.findUsers(mobile);
			if(mobile == null || mobile == ""){
				//未输入手机号
				json = "{'result':'nullError'}";
				return json;
			}else{
			//设置发送模板号
			long tpl_id = 1;
			//发送相关信息
			String text = Integer.toString((int) (Math.random() * 1000000));//生成随机6位数字验证码
			String apikey = "68865566df0b8cd417cd9703b1a79c8c";
			String codeValue = URLEncoder.encode(text, ENCODING);
		    String tpl_value = "#code#=" + codeValue + "&#company#="+"一起采";
			
		    if(user!=null){
		    	Integer userId = user.getId();
		    	// 准备要存入数据库的验证码信息
				Map<String,Object> parm = new HashMap<>();
				parm.put("userId", userId);
				parm.put("SendContent", text);
				//发送短信验证码
				JavaSmsApi.tplSendSms(apikey, tpl_id, tpl_value, mobile);
				//将验证码信息存到数据库
				passwordUnlockerService.add(parm);
				json = "{'result':'fscg'}";
				return json;
		    }else{
		    	if(user2!=null){
					//手机号已注册
					json="{'result':'existError'}";
					return json;
				}else{
					//注册时手机验证码
			    	Integer userId = null;
			    	// 准备要存入数据库的验证码信息
					Map<String,Object> parm = new HashMap<>();
					parm.put("userId", userId);
					parm.put("SendContent", text);
					request.setAttribute("code", text);
			    	//发送短信验证码
					JavaSmsApi.tplSendSms(apikey, tpl_id, tpl_value, mobile);
					passwordUnlockerService.add(parm);
					json = "{'result':'fscg','code':"+text+"}";
					return json;
				}
		    	}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	// 发送邮箱验证码
	@RequestMapping("verification")
	@ResponseBody
	public String verification(HttpServletRequest request) {
		try {
			//获取用户ID
			String userCode = (String)request.getSession().getAttribute("userCode");
			Users user = userService.findUsers(userCode);
			Integer userId = user.getId();
			// 获取用户输入的邮箱
			String email = request.getParameter("email");
			// 获取用户输入的手机号
			String tel = request.getParameter("tel");
			/*
			 * 发送邮箱验证码
			 */
			MailSend mailUtil = new MailSend("27.17.37.34",
					"zcsl@china-cpp.com", "扣叮网络科技有限公司", "zcsl", "zcsl123");// 设置发件人相关

			String subject = "验证码";// 邮件标题
			// 生成随机6位数字验证码
			String SendContent = Integer
					.toString((int) (Math.random() * 1000000));// 邮件内容
			
			// 准备要存入数据库的验证码信息
			Map<String,Object> parm = new HashMap<>();
			parm.put("userId", userId);
			parm.put("SendContent", SendContent);
			
			String receiveAddress[] = { email };// 接收邮箱
			if (email != null || email != "") {
				//向用户邮箱发送验证码
				mailUtil.send(receiveAddress, true, subject, SendContent, false);
				//将验证码信息存到数据库
				passwordUnlockerService.add(parm);
				return "fscg";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "";
	}

	// 邮箱验证
	@RequestMapping("aqrz")
	@ResponseBody
	public String aqrz(HttpServletRequest request) {
		try {
			//获取用户ID
			String userCode = (String)request.getSession().getAttribute("userCode");
			Users user = userService.findUsers(userCode);
			Integer userId = user.getId();
			//根据用户ID查询其接收到的验证码信息
			PasswordUnlocker p = passwordUnlockerService.findByUserId(userId);
			// 获取页面用户输入的邮箱验证码
			String emailYzm = request.getParameter("yzm");
			//获取存在数据库的验证码信息
			String code = p.getVerifiCode();
				if(code.equals(emailYzm)){
					return "success";
				}else{
					return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}
	
	//手机验证
	@RequestMapping("phoneCheck")
	@ResponseBody
	public String phoneCheck(HttpServletRequest request){
		//获取用户ID
		String userCode = (String)request.getSession().getAttribute("userCode");
		Users user = userService.findUsers(userCode);
		Integer userId = user.getId();
			//获取用户输入的手机号
			String mobile = request.getParameter("phone");
			try {
				/*校验手机验证码*/
				//获取用户输入的验证码
				String yzm = request.getParameter("yzm2");
				//根据用户ID查询其接收到的验证码信息
				PasswordUnlocker p = passwordUnlockerService.findByUserId(userId);
				String code = p.getVerifiCode();
				if(code.equals(yzm)){
					return "success";
				}else{
					return "fail";
				}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 跳转重置密码页面
	@RequestMapping("toReset")
	public String toReset(HttpServletRequest request) {
		try {
			return "website/reset";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 重置密码
	@RequestMapping("reset")
	@ResponseBody
	public String reset(HttpServletRequest request) {
		try {
			// 获取用户输入的重置密码
			String czmm = request.getParameter("czmm");
			// 获取用户输入的确认密码
			String qrmm = request.getParameter("qrmm");

			// 获取用户名(用于修改密码)
			String userCode = (String) request.getSession().getAttribute(
					"userCode");
			if (czmm == null || czmm == "") {
				// 请输入密码
				return "nullError";
			} else if (qrmm == null || qrmm == "") {
				// 请确认密码
				return "null2Error";
			} else if (qrmm.equals(czmm) == false) {
				// 两次输入的密码不一致
				return "pwdError";
			} else {
				Map<String, Object> parm = new HashMap<>();
				parm.put("userCode", userCode);
				// 将修改的密码加密存入数据库
				parm.put("userPwd", Common.md5(czmm));
				userService.updateUserPwd(parm);
				return "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 修改成功
	@RequestMapping("xgcg")
	public String xgcg(HttpServletRequest request) {
		try {
			return "website/xgcg";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 到注册用户页面
	@RequestMapping("toReg")
	public String toReg() {
		return "website/reg";
	}

	// 注册用户
	@RequestMapping("reg")
	@ResponseBody
	public String reg(HttpServletRequest request) {
		// 获取隐藏的用户类型(后面要根据类型区分注册)
		Integer userType = Integer.parseInt(request.getParameter("userType"));
		// 获取用户注册的账号名称(用户编码，邮箱，电话)
		String userCode = request.getParameter("userCode");
		String email = userCode;
		//如果用户注册的用户名包含@ 则认为是邮箱
		if (userCode.contains("@")) {
			email = userCode;
			userCode = null;
		} else {
			email = null;
		}
		// 获取用户电话
		String tel = request.getParameter("tel");
		// 获取用户输入的密码
		String userPwd = request.getParameter("userPsw");
		//对用户输入的密码进行加密
		String userPsw = Common.md5(userPwd);
		// 获取确认密码
		String qrmm = request.getParameter("qrmm");
		//获取用户输入的验证码
		String yzm = request.getParameter("yzm");
		
		//数据库中该验证码
		String yzCode = request.getParameter("yzCode");
		
		// 根据用户名查找用户信息
		Users user = userService.findUsers(userCode);
		Users user2 = userService.findUsers(tel);
		Users user3 = userService.findUsers(email);
		
		//用于校验手机号码
		Pattern pTel = Pattern.compile("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$3|5|6|7|8|9])\\d{8}$"); 
	    Matcher mTel = pTel.matcher(tel);
//	    System.out.println(tel+","+m.matches());
	    
	    //用于校验用户名
	    Pattern pUserCode=Pattern.compile("^[a-zA-Z0-9]{5,15}$");
	    Pattern pUserCode3=Pattern.compile("^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$");
	    Pattern pUserCode2=Pattern.compile("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|^(13[0-9]|14[0|1|2|3|5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$3|5|6|7|8|9])\\d{8}$");
		Matcher mUserCode=pUserCode.matcher(userCode);
		Matcher mUserCode2=pUserCode2.matcher(userCode);
		Matcher mUserCode3=pUserCode3.matcher(userCode);
		
	    try {
			//使用正则表达式来校验手机号的合法性：必须是以13,14,15,18开头的11位数字
			
			//帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：
	    	//^[a-zA-Z][a-zA-Z0-9_]{4,15}$ 
//	    	if (user != null) {
//	    		//用户名已注册
//	    		return "nameError";
//	    	} 
//			if(user2 != null){
//				//手机号已注册
//				return "telError";
//			}
//			if(user3 != null){
//				//邮箱已注册
//				return "emailError";
//			}else {
//				if ((userCode == null || userCode == "") 
//						&& (email == null || email == "")) {
//					// 请输入用户名
//					return "nullError";
//				} else if (!mUserCode.matches()) {
//					//用户名格式不正确
//					return "nameError2";
//				} else if (tel == null || tel == "") {
//					// 请输入电话
//					return "null2Error";
//				} else if (!mTel.matches()) {
//					//手机号格式不正确
//					return "telError2";
//				} else if (userPwd == null || userPwd == "") {
//					// 请输入密码
//					return "null3Error";
//				} else if (qrmm == null || qrmm == "") {
//					// 请确认密码
//					return "null4Error";
//				} else if (userPwd.equals(qrmm) == false) {
//					// 两次输入的密码不一致
//					return "pwdError";
//				} else{
//					//商户用户注册
//					userService.savePurchaser(parm);
//					//注册成功
//					return "success";
//				}
//			}
	    	 
				if ((userCode == null || userCode == "") 
						&& (email == null || email == "")) {
					// 请输入用户名
					return "nullError";
				} else {
					if (!mUserCode.matches() && !mUserCode2.matches() && !mUserCode3.matches()) {
						//用户名格式不正确
					return "nameError2";
					}else{
						if (user != null) {
				    		//用户名已注册
				    		return "nameError";
				    	}
					}
				}
			    if (tel == null || tel == "") {
					// 请输入电话
					return "null2Error";
				} else{
					if (!mTel.matches()) {
						//手机号格式不正确
						return "telError2";
					}else{
						if(user2 != null){
							//手机号已注册
							return "telError";
						}
					}
				}
			    if(user3 != null){
					//邮箱已注册
					return "emailError";
				} else if(yzm == null || yzm == ""){
					//请输入验证码
					return "yzError";
				} else if(yzm.equals(yzCode) == false){
					//验证码错误
					return "yzError2";
				}else if (userPwd == null || userPwd == "") {
					// 请输入密码
					return "null3Error";
				} else if (qrmm == null || qrmm == "") {
					// 请确认密码
					return "null4Error";
				
				}else if (userPwd.equals(qrmm) == false) {
					// 两次输入的密码不一致
					return "pwdError";
				}else{
					//插入公司实体类获取公司ID
					Map<String, Object> parm = new HashMap<>();
					Companys c = new Companys();
					companyService.add(c);
					Integer companyId = c.getId();
					parm.put("userCode", userCode);
					parm.put("tel", tel);
					parm.put("userPsw", userPsw);
					parm.put("email", email);
					parm.put("companyId", companyId);
					//商户用户注册
					userService.savePurchaser(parm);
					//注册成功
					return "success";
				}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 注册成功立即登录
	@RequestMapping("ljdl")
	public String lgjl() {
		return "website/login";
	}
	
	//注销用户
	@RequestMapping("cancel")
	public String cancel(HttpServletRequest request){
		try {
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			return "website/login";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}
	
	//页面展示常见问题信息
	@RequestMapping("commonProblem")
	public String commonProblem(Integer id,HttpServletRequest request){
		try {
			FAQ faq = null;
			Cache tmpCache = CacheManager.getCacheInfo("commonProblem"+id.toString());
			if(tmpCache != null){
				faq = (FAQ)(tmpCache.getValue());
			}else{
				faq = faqService.findById(id);
			}
			tmpCache = new Cache();
			tmpCache.setKey(id.toString());
			tmpCache.setValue(faq);
			CacheManager.putCache(
					"commonProblem"+id.toString(), tmpCache);
			request.setAttribute("faq", faq);
			return "website/commonProblem";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}
	
	/**
	 * 下载文件页面
	 * 
	 * @param filePath
	 * @param request
	 * @param response
	 * @return
	 * @return
	 */

	@RequestMapping("/downloadPDF")
	public void downloadPDF(String filePath, HttpServletRequest request,
			HttpServletResponse response) {

		try {
			 
			String Name = request.getParameter("filePath").replace('/', '\\');
			String realFilePath = request.getSession().getServletContext()
					.getRealPath(File.separator);

			// String fileName = new String(a.getBytes("iso-8859-1"), "UTF-8");

			File f = new File(realFilePath, Name.substring(1));
			if (f.exists()) {
				response.setContentType("application/x-msdownload");
				response.setCharacterEncoding("gb2312");
				response.setHeader(
						"Content-disposition",
						"attachment;filename="
								+ new String(Name.getBytes("GB2312"),
										"ISO-8859-1"));
				FileInputStream in = new FileInputStream(f);
				OutputStream o = response.getOutputStream();

				byte b[] = new byte[2048];
				int n = 0;
				while ((n = in.read(b)) != -1)
					o.write(b, 0, n);
				in.close();
				o.flush();
				o.close();

			} else {
				response.setCharacterEncoding("GBK");
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript'>alert('文件不存在！');history.go(-1);</script>");
				out.flush();
				out.close();

			}

		} catch (Exception e) {
			e.printStackTrace();

			/*
			 * model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" +
			 * e.getMessage());
			 */

		}
	}
}
