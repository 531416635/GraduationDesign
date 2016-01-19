package com.wit.controller;

/**
 * 与公司(采购商/供应商)相关的控制
 * @author tangxiaoqing
 */

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.http.client.AuthenticationStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyBalance;
import com.wit.model.Companys;
import com.wit.model.Dictionarys;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.AuthenticationManagerService;
import com.wit.service.CompanyBalanceService;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.UserService;

@Controller
public class CompanyController {

	@Autowired
	private CompanysService companysService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CompanyBalanceService companyBalanceService;
	
	@Autowired
	private AuthenticationManagerService authenticationManagerService;
	
	@Autowired
	private DictionaryService dictionaryService;

	public CompanysService getCompanysService() {
		return companysService;
	}

	public void setCompanysService(CompanysService companysService) {
		this.companysService = companysService;
	}

	// 显示供应商档案基本信息
	@RequestMapping("findSupplier")
	public String companyList(Page page, HttpServletRequest request) {
		try {
			List<Companys> companys = companysService.findSupplier(page);
			request.setAttribute("companys", companys);
			int rows = companysService.findSupplierRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/supplierList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示采购商档案基本信息
	@RequestMapping("findBuyer")
	public String findBuyer(Page page, HttpServletRequest request) {
		String json="";
		try {
			List<Companys> companys = companysService.findBuyer(page);
			request.setAttribute("buyer", companys);
			int rows = companysService.findBuyerRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Manager/companys/buyerList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示详细信息
	@RequestMapping("/findSupplierInfo")
	public String findSupplierInfo(Integer id, HttpServletRequest request) {
		try {
			Companys companys = companysService.findById(id);
			request.setAttribute("c", companys);
			return "Manager/companys/supplierInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除供应商
	@RequestMapping("/deleteSupplier")
	public String deletesupplier(Integer id, HttpServletRequest request) {
		try {
			companysService.delete(id);
			return "redirect:findSupplier.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 删除采购商
	@RequestMapping("/deleteBuyer")
	public String deleteBuyer(Integer id, HttpServletRequest request) {
		try {
			companysService.delete(id);
			return "redirect:findBuyer.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 跳转添加供应商页面
	@RequestMapping("/toAddSupplier")
	public String toSupplier(HttpServletRequest request) {
		try {
			return "Manager/companys/addSupplier";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 添加供应商信息
	@RequestMapping("/addSupplier")
	public String addSupplier(Companys companys, HttpServletRequest request) {
		try {
			companysService.add(companys);
			return "redirect:findSupplier.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 跳转添加供应商页面
	@RequestMapping("/toAddBuyer")
	public String toAddBuyer(HttpServletRequest request) {
		try {
			return "Manager/companys/addBuyer";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 添加采购商信息
	@RequestMapping("addBuyer")
	public String addBuyer(Companys companys, HttpServletRequest request) {
		try {
			companysService.add(companys);
			return "redirect:findBuyer.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转到修改供应商页面
	@RequestMapping("/toUpdateSupplier")
	public String toUpdate(Integer id, HttpServletRequest request) {
		try {
			Companys companys = companysService.findById(id);
			request.setAttribute("cp", companys);
			return "Manager/companys/updateSupplier";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 跳转到修改采购商页面
	@RequestMapping("/toUpdateBuyer")
	public String toUpdateBuyer(Integer id, HttpServletRequest request) {
		try {
			Companys companys = companysService.findById(id);
			// 获取公司地址
			String companyAddress = companys.getCompanyAddress();
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
			request.setAttribute("cp", companys);
			return "Manager/companys/updateBuyer";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 修改供应商信息
	@RequestMapping("/updateSupplier")
	public String updateSupplier(Companys companys, HttpServletRequest request) {
		try {
			companysService.updateCompany(companys);
			return "redirect:findSupplier.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	// 修改采购商信息
	@RequestMapping("/updateBuyer")
	public String updateBuyer(Companys companys, HttpServletRequest request) {
		try {
			companysService.updateCompany(companys); 
			//根据公司类型修改用户角色
			userService.updateUserRole(companys.getId());
			return "redirect:findBuyer.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}
	


	// 根据公司ID查找公司及关联商品价位
	public List<Map<String, Object>> findCompanyProductPriceByIds(Integer id) {
		List<Map<String, Object>> lists = companysService.findByIds(id);
		return lists;
	}

	/**
	 * 批量删除company
	 * @param request
	 * @param response
	 */
	@RequestMapping("/allDelete") 
	public void allDelete(HttpServletRequest request, HttpServletResponse response) { 
		try {
		String sid = request.getParameter("Uid");
		companysService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	} 

	// 根据公司名称搜索供应商信息
	@RequestMapping("searchSupplierInfo")
	public String searthSupplierInfo(String companyName, Page page,
			HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyName", companyName.trim());
			parm.put("page", page);
			List<Companys> companys = companysService.findSupplierInfo(parm);
			request.setAttribute("companys", companys);
			request.setAttribute("companyName", companyName);
			// 一个名称对应一条记录
			int rows = companysService.supplierRows(companyName.trim());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/searchSupplierInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 根据公司名称搜索采购商信息
	@RequestMapping("searchBuyerInfo")
	public String searthBuyerInfo(String companyName, Page page,
			HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyName", companyName.trim());
			parm.put("page", page);
			List<Companys> companys = companysService.findBuyerInfo(parm);
			request.setAttribute("companys", companys);
			request.setAttribute("companyName", companyName);
			// 一个名称对应一条记录
			int rows = companysService.buyerRows(companyName.trim());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/searchBuyerInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 根据公司名称搜索采购商认证信息
	@RequestMapping("searchBuyerAuthenticationInfo")
	public String searthBuyerAuthenticationInfo(String companyName, Page page,
			HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyName", companyName.trim());
			parm.put("page", page);
			List<Companys> companys = companysService.findBuyerInfo(parm);
			request.setAttribute("companys", companys);
			request.setAttribute("companyName", companyName);
			// 一个名称对应一条记录
			int rows = companysService.buyerRows(companyName.trim());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/searchBuyerAuthenticationInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 根据公司名称搜索供应商认证信息
	@RequestMapping("searchSupplierAuthenticationInfo")
	public String searthSupplierAuthenticationInfo(String companyName,
			Page page, HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyName", companyName.trim());
			parm.put("page", page);
			List<Companys> companys = companysService.findSupplierInfo(parm);
			request.setAttribute("companys", companys);
			request.setAttribute("companyName", companyName);
			// 一个名称对应一条记录
			int rows = companysService.supplierRows(companyName.trim());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/searchSupplierAuthenticationInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 根据公司名称搜索供应商合同信息
	@RequestMapping("searchSupplierContractInfo")
	public String searthSupplierContractInfo(String companyName, Page page,
			HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyName", companyName.trim());
			parm.put("page", page);
			List<Companys> companys = companysService.findSupplierInfo(parm);
			request.setAttribute("companys", companys);
			request.setAttribute("companyName", companyName);
			// 一个名称对应一条记录
			int rows = companysService.supplierRows(companyName.trim());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/searchSupplierContractInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 根据公司名称搜索采购商合同信息
	@RequestMapping("searchBuyerContractInfo")
	public String searthBuyerContractInfo(String companyName, Page page,
			HttpServletRequest request) {
		try {
			Map<String, Object> parm = new HashMap<>();
			parm.put("companyName", companyName.trim());
			parm.put("page", page);
			List<Companys> companys = companysService.findBuyerInfo(parm);
			request.setAttribute("companys", companys);
			request.setAttribute("companyName", companyName);
			// 一个名称对应一条记录
			int rows = companysService.buyerRows(companyName.trim());
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/searchBuyerContractInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
