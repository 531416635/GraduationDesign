package com.wit.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.wit.comm.Common;
import com.wit.comm.JavaSmsApi;
import com.wit.comm.MailSend;
import com.wit.model.AuthenticationManager;
import com.wit.model.CompanyBankAccount;
import com.wit.model.CompanyContracts;
import com.wit.model.Companys;
import com.wit.model.Departments;
import com.wit.model.Dictionarys;
import com.wit.model.Jobs;
import com.wit.model.Page;
import com.wit.model.PasswordUnlocker;
import com.wit.model.Products;
import com.wit.model.Roles;
import com.wit.model.ShoppingAddress;
import com.wit.model.Users;
import com.wit.service.AuthenticationManagerService;
import com.wit.service.CompanyBankAccountService;
import com.wit.service.CompanyContractService;
import com.wit.service.CompanysService;
import com.wit.service.DepartmentsService;
import com.wit.service.DictionaryService;
import com.wit.service.JobsService;
import com.wit.service.PasswordUnlockerService;
import com.wit.service.RolesService;
import com.wit.service.ShoppingAddressService;
import com.wit.service.UserManagerService;
import com.wit.service.UserService;

/**
 * 门户账户管理相关控制
 * 
 * @author tangxiaoqing
 * 
 */
@Controller
@RequestMapping("/merchant")
public class WebAccountController {
	// 编码格式。发送编码格式统一用UTF-8
	private static String ENCODING = "UTF-8";

	@Autowired
	private CompanysService companyService;

	@Autowired
	private CompanyContractService companyContractService;

	@Autowired
	private ShoppingAddressService shoppingAddressService;

	@Autowired
	private UserManagerService userManagerService;

	@Autowired
	private DictionaryService dictionaryService;

	@Autowired
	private AuthenticationManagerService authenticationManagerService;

	@Resource
	private DepartmentsService departmentsService;
	@Resource
	private RolesService rolesService;
	@Resource
	private UserService userService;

	@Autowired
	private PasswordUnlockerService passwordUnlockerService;

	@Autowired
	private CompanyBankAccountService companyBankAccountService;

	@Autowired
	private JobsService jobsService;

	// 跳转企业认证页面
	@RequestMapping("toCompanyAuthentication")
	public String toCompanyAuthentication(HttpServletRequest request) {
		try {
			return "merchant/companyAuthentication";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 合同列表
	@RequestMapping("contractList")
	public String contractList(Page page, HttpServletRequest request) {
		String json = "";
		try {
			// 获取用户登录基本信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("page", page);
			Companys companys = companyService.findById(companyId);
			request.setAttribute("companyType", companys.getCompanyType());
			List<CompanyContracts> companyContracts = companyContractService
					.findByCompanyIds(parm);
			int rows = companyContractService.findRows(companyId);
			json = JSONObject.fromObject(page).toString();
			request.setAttribute("companyContracts", companyContracts);
			request.setAttribute("json", json);
			return "merchant/merchantSupplierContract";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转显示供应商合作协议
	@RequestMapping("merchantSupplierContract")
	public String merchantSupplierContract(Integer id,
			HttpServletRequest request) {
		try {
			CompanyContracts companyContracts = companyContractService
					.findById(id);
			request.setAttribute("companyContracts", companyContracts);
			return "merchant/contractInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转显示采购商合作协议
	@RequestMapping("merchantBuyerContract")
	public String merchantBuyerContract(HttpServletRequest request) {
		try {
			/* 基本信息 */
			// 获取用户登录基本信息
			Users user = (Users) request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			// //通过公司id获取CompanyContract中合同信息
			// List<CompanyContracts>
			// companyContracts=companyContractService.findByCompanyId(companyId);
			// request.setAttribute("companyContracts", companyContracts);
			return "merchant/merchantBuyerContract";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "";
		}
	}

	// 跳转商户账户管理页面
	@RequestMapping("merchantAccountManager")
	public String merchantAccountManager(Page page, HttpServletRequest request) {
		String jsonAddrs = "";
		try {
			/* 基本信息 */
			// 获取用户登录基本信息
			Users user = (Users) request.getSession().getAttribute("user");
			request.setAttribute("user", user);
			// 获取用户ID
			if (user != null) {
				Integer id = user.getId();
				Integer companyId = user.getCompanyId();
				Companys companys = companyService.findLoginStatus(companyId);
				request.setAttribute("companys", companys);
				request.setAttribute("id", id);

				// 查询省份信息（用户选择地区）
				List<Dictionarys> dictionarys = dictionaryService
						.findProvinceInfo();
				request.setAttribute("dictionarys", dictionarys);
				List<Dictionarys> addrs = dictionaryService.getDicsByDicType(1);
				jsonAddrs = JSONArray.fromObject(addrs).toString();
				request.setAttribute("jsonAddrs", jsonAddrs);

				// 获取用户地址
				String address = user.getAddress();
				if (address != null && address.trim().length() != 0) {
					String[] tt = address.split(",");
					if (tt.length >= 4) {
						Integer proviceId = Integer.parseInt(tt[0]);
						Integer cityId = Integer.parseInt(tt[1]);
						Integer districtId = Integer.parseInt(tt[2]);
						String detail0 = tt[3];
						request.setAttribute("detail0", detail0);
						Dictionarys provice = dictionaryService
								.findById(proviceId);
						Dictionarys city = dictionaryService.findById(cityId);
						Dictionarys district = dictionaryService
								.findById(districtId);
						request.setAttribute("provice", provice);
						request.setAttribute("city", city);
						request.setAttribute("district", district);
						request.setAttribute("proviceId", proviceId);
						request.setAttribute("cityId", cityId);
						request.setAttribute("districtId", districtId);
					}else{
						request.setAttribute("address", address);
					}

				}

				// 获取公司地址
				String companyAddress = companys.getcompanyAddress();
				if (companyAddress != null
						&& companyAddress.trim().length() != 0) {
					String[] ss = companyAddress.split(",");
					if (ss.length >= 4) {
						Integer proviceId2 = Integer.parseInt(ss[0]);
						Integer cityId2 = Integer.parseInt(ss[1]);
						Integer districtId2 = Integer.parseInt(ss[2]);
						String detail1 = ss[3];
						request.setAttribute("detail1", detail1);
						Dictionarys provice2 = dictionaryService
								.findById(proviceId2);
						Dictionarys city2 = dictionaryService.findById(cityId2);
						Dictionarys district2 = dictionaryService
								.findById(districtId2);
						request.setAttribute("provice2", provice2);
						request.setAttribute("city2", city2);
						request.setAttribute("district2", district2);
						request.setAttribute("proviceId2", proviceId2);
						request.setAttribute("cityId2", cityId2);
						request.setAttribute("districtId2", districtId2);
					}else{
						request.setAttribute("companyAddress", companyAddress);
					}
				}
			}
			return "merchant/merchantAccountManager";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 进入完善供应地域
	@RequestMapping("toaddSupplyArea")
	public String toaddSupplyArea(Page page, HttpServletRequest request) {
		String json = "";
		try {
			/* 基本信息 */
			// 获取用户登录基本信息
			Users user = (Users) request.getSession().getAttribute("user");
			request.setAttribute("user", user);
			// 获取用户ID
			Integer id = user.getId();
			Integer companyId = user.getCompanyId();
			request.setAttribute("id", id);
			request.setAttribute("companyId", companyId);
			// 查询省份信息（用户选择地区）
			List<Dictionarys> dictionarys = dictionaryService
					.findProvinceInfo();
			request.setAttribute("dictionarys", dictionarys);
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("userId", id);
			parm.put("page", page);
			parm.put("addressType", 2);
			List<ShoppingAddress> shoppingAddress = shoppingAddressService
					.getShoppingAddressByCompanyID(parm);
			page.setRows(shoppingAddressService
					.getShoppingAddressRowsByCompanyID(parm));
			request.setAttribute("shoppingAddress", shoppingAddress);
			json = JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "merchant/supplyArea";
	}

	// 完善供应地域
	@RequestMapping("addSupplyArea")
	public String addSupplyArea(HttpServletRequest request) {
		String result = "'true'";
		try {
			// 获取登录用户ID，公司ID信息
			Users user = (Users) request.getSession().getAttribute("user");
			String address = request.getParameter("address");
			// 多个供应地址
			// 判断是否为多个地址
			if (address.indexOf(";") != -1) {
				String[] addr1 = address.split(";");
				for (int i = 0; i < addr1.length; i++) {
					// 省市区及详情
					String[] addr2 = addr1[i].split(",");
					ShoppingAddress shoppingAddress = new ShoppingAddress();
					for (int j = 0; j < addr2.length; j++) {
						Integer num = null;
						String addrs = "";
						if (j <= 2) {
							num = Integer.valueOf(addr2[j]);
						} else {
							addrs = addr2[j];
						}
						switch (j) {
						case 0:
							shoppingAddress.setProvince(num);
							break;
						case 1:
							shoppingAddress.setCity(num);
							break;
						case 2:
							shoppingAddress.setDistrict(num);
							break;
						case 3:
							shoppingAddress.setShoppingAddress(addrs);
							break;
						case 4:
							shoppingAddress.setAdderssName(addrs);
						}
					}
					shoppingAddress.setUserId(user.getId());
					shoppingAddress.setCompanyId(user.getCompanyId());
					// 添加供应地域
					shoppingAddressService
							.insertSupplierAddress(shoppingAddress);
					if (shoppingAddress.getId() == null) {
						result = "'false'";
					}
				}
			} else {
				// 只有一个地址时
				String[] addr3 = address.split(",");
				ShoppingAddress shoppingAddress = new ShoppingAddress();
				for (int j = 0; j < addr3.length; j++) {
					Integer num = null;
					String addrs = "";
					if (j <= 2) {
						num = Integer.valueOf(addr3[j]);
					} else {
						addrs = addr3[j];
					}
					switch (j) {
					case 0:
						shoppingAddress.setProvince(num);
						break;
					case 1:
						shoppingAddress.setCity(num);
						break;
					case 2:
						shoppingAddress.setDistrict(num);
						break;
					case 3:
						shoppingAddress.setShoppingAddress(addrs);
						break;
					case 4:
						shoppingAddress.setAdderssName(addrs);
					}
				}
				shoppingAddress.setUserId(user.getId());
				shoppingAddress.setCompanyId(user.getCompanyId());
				// 添加供应地域
				shoppingAddressService.insertSupplierAddress(shoppingAddress);
				if (shoppingAddress.getId() == null) {
					result = "'false'";
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "redirect:toaddSupplyArea.do?result=" + result;
	}

	/**
	 * 删除供应地址
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("deleteSupplyAddress")
	public String deleteAddress(HttpServletRequest request) {
		try {
			Integer addressId = Integer.valueOf(request
					.getParameter("addressId"));
			shoppingAddressService.delete(addressId);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "redirect:toaddSupplyArea.do";
	}

	/**
	 * 删除收货地址
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("deleteDeliveryAddress")
	public String deleteDeliveryAddress(HttpServletRequest request) {
		try {
			Integer addressId = Integer.valueOf(request
					.getParameter("addressId"));
			shoppingAddressService.delete(addressId);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "redirect:toaddDeliveryAddress.do";
	}

	// 进入完善收货地址
	@RequestMapping("toaddDeliveryAddress")
	public String toaddDeliveryAddress(Page page, HttpServletRequest request) {
		try {
			/* 基本信息 */
			// 获取用户登录基本信息
			Users user = (Users) request.getSession().getAttribute("user");
			request.setAttribute("user", user);
			// 获取用户ID
			Integer id = user.getId();
			Integer companyId = user.getCompanyId();
			request.setAttribute("id", id);
			request.setAttribute("companyId", companyId);
			// 查询省份信息（用户选择地区）
			List<Dictionarys> dictionarys = dictionaryService
					.findProvinceInfo();
			request.setAttribute("dictionarys", dictionarys);
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("userId", id);
			parm.put("page", page);
			parm.put("addressType", 1);
			List<ShoppingAddress> shoppingAddress = shoppingAddressService
					.getShoppingAddressByCompanyID(parm);
			page.setRows(shoppingAddressService
					.getShoppingAddressRowsByCompanyID(parm));
			request.setAttribute("shoppingAddress", shoppingAddress);
			request.setAttribute("json", JSONObject.fromObject(page).toString());
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "merchant/deliveryAddress";
	}

	// 完善收货地址
	@RequestMapping("addDeliveryAddress")
	public String addDeliveryAddress(HttpServletRequest request) {
		String result = "'false'";
		try {// 获取登录用户ID，公司ID信息
			Users user = (Users) request.getSession().getAttribute("user");
			String address = request.getParameter("address");
			// 多个供应地址
			if (address.indexOf(";") != -1) {
				String[] addr1 = address.split(";");
				for (int i = 0; i < addr1.length; i++) {
					// 省市区
					String[] addr2 = addr1[i].split(",");
					ShoppingAddress shoppingAddress = new ShoppingAddress();
					for (int j = 0; j < addr2.length; j++) {
						Integer num = null;
						String addrs = "";
						if (j <= 2) {
							num = Integer.valueOf(addr2[j]);
						} else {
							addrs = addr2[j];
						}
						switch (j) {
						case 0:
							shoppingAddress.setProvince(num);
							break;
						case 1:
							shoppingAddress.setCity(num);
							break;
						case 2:
							shoppingAddress.setDistrict(num);
							break;
						case 3:
							shoppingAddress.setShoppingAddress(addrs);
							break;
						case 4:
							shoppingAddress.setAdderssName(addrs);
						}
					}
					shoppingAddress.setUserId(user.getId());
					shoppingAddress.setCompanyId(user.getCompanyId());
					// 添加供应地域
					shoppingAddressService
							.insertPurchaserAddress(shoppingAddress);
					if (shoppingAddress.getId() != null) {
						result = "'true'";
					}
				}
			} else {
				String[] addr3 = address.split(",");
				ShoppingAddress shoppingAddress = new ShoppingAddress();
				for (int j = 0; j < addr3.length; j++) {
					Integer num = null;
					String addrs = "";
					if (j <= 2) {
						num = Integer.valueOf(addr3[j]);
					} else {
						addrs = addr3[j];
					}
					switch (j) {
					case 0:
						shoppingAddress.setProvince(num);
						break;
					case 1:
						shoppingAddress.setCity(num);
						break;
					case 2:
						shoppingAddress.setDistrict(num);
						break;
					case 3:
						shoppingAddress.setShoppingAddress(addrs);
						break;
					case 4:
						shoppingAddress.setAdderssName(addrs);
					}
				}
				shoppingAddress.setUserId(user.getId());
				shoppingAddress.setCompanyId(user.getCompanyId());

				// 添加供应地域
				shoppingAddressService.insertPurchaserAddress(shoppingAddress);
				if (shoppingAddress.getId() != null) {
					result = "'true'";
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "redirect:toaddDeliveryAddress.do?result=" + result;
	}

	// 完善商户管理信息
	@RequestMapping("completeMerchantAccountInfo")
	public String completeUserInfo(Users users, Companys companys,
			ShoppingAddress shoppingAddress, HttpServletRequest request) {
		String json = "";
		HttpSession session = request.getSession();
		try {
			// 获取登录用户ID，公司ID信息
			Users user = (Users) request.getSession().getAttribute("user");
			// 完善用户基本信息
			String address = request.getParameter("address");
			users.setAddress(address);
			userManagerService.completeUserInfo(users);
			// 如果是父账户，填写公司基本信息
			// 设置公司ID
			if (user.getParentID() == null || user.getParentID().SIZE == 0) {
				Integer companyId = Integer.parseInt(request
						.getParameter("companyId"));
				String companyAddress = request.getParameter("companyAddress");
				Integer companyStatus = Integer.valueOf(request.getParameter("status"));
				companys.setId(companyId);
				// 点击完成的时将状态改为3(后台认证审核中)
				if(companyStatus == 0){
					companys.setStatus(3);
					companys.setcompanyAddress(companyAddress);
					companyService.completeCompanyInfo(companys);
					session.setAttribute("user", users);
					return "redirect:authenticationInfoList.do";
				}else{
					//之前填写过，修改信息
					companys.setcompanyAddress(companyAddress);
					companyService.completeCompanyInfo(companys);
					session.setAttribute("user", users);
					return "redirect:toPurchaserList.do";
				}
			} else {
				session.setAttribute("user", users);
				return "redirect:toPurchaserList.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 省市区三级联动关联查询
	@RequestMapping(value = "/provinceUrbanLinkage", produces = { "application/json;charset=UTF-8" })
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
			return "error";
		}
		return json;
	}

	// 认证资料列表
	@RequestMapping("authenticationInfoList")
	public String authenticationInfoList(Page page, HttpServletRequest request) {
		try {
			String json = "";
			Users user = (Users) request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			// 获取资料认证信息
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("companyId", companyId);
			List<AuthenticationManager> authenticationManagers = authenticationManagerService
					.findByCompanyId(parm);
			request.setAttribute("authenticationManagers",
					authenticationManagers);
			int rows = authenticationManagerService.rows(companyId);
			page.setRows(rows);
			request.setAttribute("rows", rows);
			request.setAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "merchant/authenticationInfoList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 上传认证资料
	@RequestMapping(value = "uploadAuthenticationfile", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String uploadAuthenticationfile(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "{'result':'false'}";
		Users user = (Users) request.getSession().getAttribute("user");
		Integer companyId = user.getCompanyId();

		// 创建一个通用的多部分解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			int flag = 1;
			Iterator<String> iter = multiRequest.getFileNames();
			Integer isDef = 1;
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					if (myFileName.trim() != "") {
						// 定义上传路径
						String filePath = request.getSession()
								.getServletContext()
								.getRealPath(File.separator);
						File webrootPath = new File(filePath + "\\companyimg\\"
								+ companyId + "\\");
						if (!webrootPath.isDirectory()) {
							webrootPath.mkdirs();
						}
						AuthenticationManager authenticationpic = new AuthenticationManager();
						String authenticationName = request
								.getParameter("authenticationName");
						authenticationpic
								.setAuthenticationName(authenticationName);
						authenticationpic.setCompanyId(companyId);
						authenticationpic.setStatus(2);
						authenticationpic.setUploadBy(user.getId());
						String fileName = Common
								.getDateTimeNow("yyyyMMddHHmmss");
						filePath = webrootPath + File.separator + fileName
								+ ".jpg";
						String path = "E:/" + fileName;
						authenticationpic.setFilePath("/companyimg/"
								+ companyId + "/" + fileName + ".jpg");
						authenticationManagerService.insert(authenticationpic);
						File localFile = new File(filePath);
						try {
							json = "{'rsult':'true'}";
							file.transferTo(localFile);
						} catch (IllegalStateException | IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return json;
	}

	// 删除认证信息
	@RequestMapping("deleteAuthenticationInfo")
	public String deleteAuthenticationInfo(Integer id,
			HttpServletRequest request) {
		try {
			// 逻辑删除认证信息
			authenticationManagerService.delete(id);
			return "redirect:authenticationInfoList.do?";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转子账户管理页面
	@RequestMapping("toSonAccountManagement")
	public String toSonAccountManagement(Page page, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			if (user == null) {
				return "redirect:/web/toIndex.do";
			}
			Integer companyId = user.getCompanyId();
			if (companyId == null) {
				return "redirect:/web/toIndex.do";
			}
			Companys company = companyService.findById(companyId);
			Integer maxAccount = company.getMaxAccount();
			request.setAttribute("maxAccount", maxAccount);
			int status0 = userService.findSonAccount0(companyId);
			int status1 = userService.findSonAccount1(companyId);
			int status2 = userService.findSonAccount2(companyId);
			int status3 = userService.findSonAccount3(companyId);
			request.setAttribute("status0", status0);
			request.setAttribute("status1", status1);
			request.setAttribute("status2", status2);
			request.setAttribute("status3", status3);
			// List<Users> list = userService.findSumByCompanyId(companyId);

			/*
			 * int count = 1; for (int i = 0; i < list.size(); i++) { switch
			 * (list.get(i).getStatus()) { case 0:
			 * request.setAttribute("userStatus0", list.get(i) .getMaxNum());
			 * request.setAttribute("userStatus0", count++); break; case 1:
			 * request.setAttribute("userStatus1", list.get(i) .getMaxNum());
			 * request.setAttribute("userStatus1", count++); break; case 2:
			 * request.setAttribute("userStatus2", list.get(i) .getMaxNum());
			 * request.setAttribute("userStatus2", count++); break; case 3:
			 * request.setAttribute("userStatus3", list.get(i) .getMaxNum());
			 * request.setAttribute("userStatus3", count++); break; } }
			 */

			// 子账户列表
			List<Map<String, Object>> sonAccountInfo = userManagerService
					.findSonAccountByCompanyId(companyId, page);
			Integer Id = user.getId();
			int rows = userService.findSonAccountRowsById(Id);
			page.setRows(rows);
			request.setAttribute("page", page);
			request.setAttribute("sonAccountInfo", sonAccountInfo);
			return "merchant/accountProfile";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 到子账户列表修改
	@RequestMapping("toUpdateSonAccount")
	public String toUpdateSonAccount(Page page, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			String userId = request.getParameter("userId");
			Users dbl = userManagerService.findById(Integer.parseInt(userId));
			Integer rid = dbl.getRoleId();
			Roles rs = rolesService.findById(rid);
			List<Roles> roles = rolesService.findByCompanyId(user
					.getCompanyId());// 获取角色
			List<Map<String, Object>> lists = userManagerService.findAll(page);
			List<Departments> department = departmentsService
					.findDepartmentByCompanyId(dbl.getCompanyId());

			List<Jobs> jobsU = jobsService.findByDeptId(dbl.getDepartmentId());
			request.setAttribute("departmentsU", department);
			request.setAttribute("jobsU", jobsU);
			request.setAttribute("users", lists);
			request.setAttribute("db", dbl);
			request.setAttribute("roles", rs);
			request.setAttribute("roleListss", roles);
			return "merchant/updateSonAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 根据部门ID，动态获取相应的岗位

	@RequestMapping(value = "/toUpdateJobs", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String toUpdateJobs( HttpServletRequest request) {
		String json = "false";
		try {
			Integer departmentId=Integer.parseInt(request.getParameter("departmentId"));
			List<Jobs> jobsU = jobsService.findByDeptId(departmentId);
			json = JSONArray.fromObject(jobsU).toString();
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return json;
		}
	}

	// 修改子账户
	@RequestMapping("/sonAccountUpdate")
	public String sonAccountUpdate(Users db) {
		userManagerService.updateUsers(db);
		return "redirect:toSonAccountManagement.do";
	}

	// 子账户列表删除
	@RequestMapping("deleteSonAccount")
	public String deleteSonAccount(HttpServletRequest request) {
		try {
			// 通过获取ID来删除一条数据
			String userId = request.getParameter("userId");
			Map<String, Integer> maps = new HashMap<String, Integer>();
			maps.put("userId", Integer.parseInt(userId));
			maps.put("status", 3);
			userManagerService.updateStatus(maps);
			return "redirect:toSonAccountManagement.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 新建子账户
	@RequestMapping("buildSonAccount")
	public String buildSonAccount(HttpServletRequest request, Model model,
			Page page) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			Integer companyId = user.getCompanyId();
			// 获取部门
			List<Departments> list = departmentsService
					.findDepartmentByCompanyId(companyId);
			model.addAttribute("departments", list);
			int rows = departmentsService.findRows();
			page.setRows(rows);
			model.addAttribute("page", page);
			// 获取角色
			List<Roles> roles = rolesService.findByCompanyId(companyId);
			model.addAttribute("roles", roles);
			return "merchant/sonAccountManagement";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转账户安全页面
	@RequestMapping("toSafeAccount")
	public String toSafeAccount(HttpServletRequest request, Model model) {
		try {
			Users userinfo = (Users) request.getSession().getAttribute("user");
			// 设置显示安全的Tel
			String tel = userinfo.getTel();
			if (tel != null && tel.length() > 0) {
				String prefixTel = tel.substring(0, 3);
				String suffixTel = tel.substring(tel.length() - 2);
				String safeTel = prefixTel.concat("******").concat(suffixTel);
				userinfo.setTel(safeTel);
			}

			// 设置显示安全的Email
			String email = userinfo.getEmail();
			if (email != null && email.length() > 0) {
				String prefixEmail = email.substring(0, 3);
				String suffixEmail = email.substring(email.length() - 9);
				String safecode = "********";
				String safEmail = prefixEmail.concat(safecode).concat(
						suffixEmail);
				userinfo.setEmail(safEmail);
			}
			model.addAttribute("userinfo", userinfo);
			return "merchant/safeAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 发送手机验证码
	@RequestMapping("telCode")
	@ResponseBody
	public String telCode(HttpServletRequest request) {
		// 获取用户信息
		Users user = (Users) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		try {
			// 获取用户输入的手机号
			String mobile = request.getParameter("phone");
			// 设置发送模板号
			long tpl_id = 1;
			// 发送相关信息
			String text = Integer.toString((int) (Math.random() * 1000000));// 生成随机6位数字验证码
			String apikey = "68865566df0b8cd417cd9703b1a79c8c";
			String codeValue = URLEncoder.encode(text, ENCODING);
			String tpl_value = "#code#=" + codeValue + "&#company#=" + "一起采";

			// 准备要存入数据库的验证码信息
			Map<String, Object> parm = new HashMap<>();
			parm.put("userId", userId);
			parm.put("SendContent", text);
			request.setAttribute("yzm", text);
			// 发送短信验证码
			JavaSmsApi.tplSendSms(apikey, tpl_id, tpl_value, mobile);
			// 将验证码信息存到数据库
			passwordUnlockerService.add(parm);
			return "done";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "error";
	}

	// 检验手机验证码
	@RequestMapping("checkTel")
	@ResponseBody
	public String checkTel(HttpServletRequest request) {
		Users user = (Users) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		// 获取用户输入的手机号
		String mobile = request.getParameter("phone");
		try {
			/* 校验手机验证码 */
			// 获取用户输入的验证码
			String yzm = request.getParameter("telCode");
			// 根据用户ID查询其接收到的验证码信息
			PasswordUnlocker p = passwordUnlockerService.findByUserId(userId);
			String code = p.getVerifiCode();
			if (code.equals(yzm)) {
				// 更换安全手机号为用户填写的手机号
				user.setTel(mobile);
				userService.updateUser(user);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "error";
	}

	// 发送邮箱验证码
	@RequestMapping("sendMail")
	@ResponseBody
	public String sendMail(HttpServletRequest request) {
		// 获取登录用户信息
		Users user = (Users) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		try {
			// 获取用户填写的邮箱地址
			String email = request.getParameter("mail");
			MailSend mailUtil = new MailSend("27.17.37.34",
					"zcsl@china-cpp.com", "扣叮网络科技有限公司", "zcsl", "zcsl123");// 设置发件人相关

			String subject = "验证码";// 邮件标题
			// 生成随机6位数字验证码
			String SendContent = Integer
					.toString((int) (Math.random() * 1000000));// 邮件内容

			// 准备要存入数据库的验证码信息
			Map<String, Object> parm = new HashMap<>();
			parm.put("userId", userId);
			parm.put("SendContent", SendContent);

			String receiveAddress[] = { email };// 接收邮箱
			if (email != null || email != "") {
				// 向用户邮箱发送验证码
				mailUtil.send(receiveAddress, true, subject, SendContent, false);
				// 将验证码信息存到数据库
				passwordUnlockerService.add(parm);
				return "fscg";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "error";
	}

	// 验收邮箱验证码
	@RequestMapping("checkMail")
	@ResponseBody
	public String checkMail(HttpServletRequest request) {
		Users user = (Users) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		// 获取用户填写的邮箱地址
		String email = request.getParameter("mail");
		try {
			// 校验邮箱验证码
			// 获取用户输入的验证码
			String yzm = request.getParameter("mailCode");
			// 根据用户ID查询其接收到的验证码信息
			PasswordUnlocker p = passwordUnlockerService.findByUserId(userId);
			String code = p.getVerifiCode();
			if (code.equals(yzm)) {
				// 更换安全邮箱为用户填写的邮箱
				user.setEmail(email);
				userService.updateUser(user);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
		return "error";
	}

	// 跳转上传用户头像
	@RequestMapping("toUploadAvatar")
	public String toUploadAvatar(HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			String userPhoto = user.getUserPhoto();
			request.setAttribute("up", userPhoto);
			return "uploadAvatar";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 上传用户头像
	@RequestMapping("uploadAvatar")
	public String uploadAvatar(HttpServletRequest request) {
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
						String userPhoto = request.getSession()
								.getServletContext()
								.getRealPath(File.separator);
						Users user = (Users) request.getSession().getAttribute(
								"user");
						Integer userid = user.getId();
						/*
						 * StringBuilder sb = new StringBuilder();
						 * sb.append(userPhoto); sb.append("\\userimg\\");
						 * 
						 * File webrootPath = new File(sb.toString()); if
						 * (!webrootPath.isDirectory()) { webrootPath.mkdir(); }
						 * 
						 * sb.append(userid); sb.append("\\");
						 */
						File webrootPath = new File(userPhoto + "\\userimg\\");
						if (!webrootPath.exists()) {
							webrootPath.mkdir();
						}
						// Users users = new Users();
						// 获取登录用户ID

						String fileName = Common
								.getDateTimeNow("yyyyMMddHHmmss");
						// users.setId(id);
						StringBuilder usersb = new StringBuilder();
						usersb.append("userimg/");
						/*
						 * usersb.append(userid); usersb.append("/");
						 */
						usersb.append(fileName);
						usersb.append(".jpg");
						user.setUserPhoto(usersb.toString());
						// 重命名上传后的文件名
						userPhoto = webrootPath + File.separator + fileName
								+ ".jpg";
						HttpSession session = request.getSession();
						session.setAttribute("user", user);
						userService.uploadAvatar(userid, user.getUserPhoto());

						File localFile = new File(userPhoto);

						try {
							file.transferTo(localFile);
						} catch (IllegalStateException | IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		// 重新登录
		return "redirect:toPurchaserList.do";
	}

	// 账户安全（修改账户密码）
	@RequestMapping("chageAccountPsw")
	@ResponseBody
	public String chageAccountPsw(HttpServletRequest request) {
		// 获取用户信息
		Users user = (Users) request.getSession().getAttribute("user");
		// 获取用户密码
		String userPsw = user.getUserPsw();
		try {
			// 获取用户填写的原始密码
			String psw = request.getParameter("psw");
			// 获取用户填写的新密码
			String newPsw = request.getParameter("newPsw");
			// 获取用户填写的确认密码
			String rNewPsw = request.getParameter("rNewPsw");
			// 将用户填写的原始密码与数据库保存的密码比较
			if (psw == null || psw == "") {
				// 原始密码不能为空
				return "nullError";
				// 原始密码加密与数据库密码比较
			} else if (userPsw.equals(Common.md5(psw)) == false) {
				// 原始密码不正确
				return "pwdError";
			} else if (newPsw == null || newPsw == "") {
				// 新密码不能为空
				return "null2Error";
			} else if (rNewPsw == null || rNewPsw == "") {
				// 确认密码不能为空
				return "null3Error";
			} else if (newPsw.equals(rNewPsw) == false) {
				// 两次输入的密码不一致
				return "confirmError";
			} else {
				Map<String, Object> parm = new HashMap<>();
				parm.put("id", user.getId());
				parm.put("userPsw", Common.md5(newPsw));
				// 将加密后的新密码和用户id传给配置文件
				userService.updatePwd(parm);
				// 修改密码成功
				return "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 到子账户密码初始化页面
	@RequestMapping("toInitSonAccount")
	public String toInitSonAccount(Page page, HttpServletRequest request) {
		try {
			Users user = (Users) request.getSession().getAttribute("user");
			// 获取父账户公司ID
			Integer companyId = user.getCompanyId();
			// 获取该账号下所有子账户以列表形式展示
			List<Map<String, Object>> users = userManagerService
					.findSonAccountByCompanyId(companyId, page);
			int rows = users.size();
			page.setRows(rows);
			request.setAttribute("page", page);
			request.setAttribute("users", users);
			return "merchant/initSonAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 子账户密码初始化页面
	@RequestMapping("initSonAccount")
	public String initSonAccount(Integer id, HttpServletRequest request) {
		try {
			// 初始化选中子账户密码为123
			String Psw = "123";
			// 对密码加密
			String userPsw = Common.md5(Psw);
			userService.initSonAccount(userPsw, id);
			return "redirect:toSonAccountManagement.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// userCode校验用户的唯一性
	@RequestMapping("checkUser")
	@ResponseBody
	public String checkUser(String userCode, HttpServletRequest request) {
		String json = "{'result':'null'}";
		Users user = new Users();
		try {

			user = userService.checkUser(userCode);
			json = "{'result':'" + user.getUserCode() + "'}";
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return json;
		}
	}

	// 到新增银行账号页面
	@RequestMapping("toAddBankAccount")
	public String toAddBankAccount(Integer companyId, HttpServletRequest request) {
		try {
			request.setAttribute("companyId", companyId);
			return "merchant/addBankAccount";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 到新增银行账号页面
	@RequestMapping("addBankAccount")
	public String addBankAccount(CompanyBankAccount companyBankAccount,
			HttpServletRequest request) {
		try {
			companyBankAccountService.addBankAccount(companyBankAccount);
			return "redirect:statement.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
