package com.wit.controller;

/**
 * 与合同相关的控制
 * @author tangxiaoqing
 */
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.DateTime;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wit.model.CompanyContracts;
import com.wit.model.Companys;
import com.wit.model.Page;
import com.wit.service.CompanyContractService;
import com.wit.service.CompanysService;

/**
 * 与供应商合同相关的控制
 * 
 * @author tangxiaoqing
 * 
 */
@Controller
public class CompanyContractController extends BaseController {

	@Autowired
	private CompanyContractService companyContractService;

	@Autowired
	private CompanysService companysService;

	// 显示供应商合同基本信息
	@RequestMapping("findSupplierContract")
	public String findSupplierContract(Page page, HttpServletRequest request) {
		try {
			List<Companys> companys = companysService.findSupplier(page);
			request.setAttribute("companys", companys);
			int rows = companysService.findSupplierRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			return "Manager/companys/supplierContractList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示采购商合同基本信息
	@RequestMapping("findBuyerContract")
	public String findBuyerContract(Page page, HttpServletRequest request) {
		String json="";
		try {
			List<Companys> companys = companysService.findBuyer(page);
			request.setAttribute("companys", companys);
			int rows = companysService.findBuyerRows();
			page.setRows(rows);
			request.setAttribute("page", page);
			json=JSONObject.fromObject(page).toString();
			request.setAttribute("json", json);
			return "Manager/companys/buyerContractList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示供应商合同电子档资料
	@RequestMapping("supplierContractInfo")
	public String supplierContractInfo(Integer companyId,Page page,
			HttpServletRequest request) {
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("page", page);
			List<CompanyContracts> companyContracts = companyContractService
					.findByCompanyIds(parm);
//			System.out.println(companyId+" "+companyContracts.size());
			request.setAttribute("companyContracts", companyContracts);
			request.setAttribute("companyId", companyId);
			int rows = companyContractService.findRows(companyId);
			page.setRows(rows);
			request.setAttribute("page", page);
			System.out.println(companyId);
			System.out.println(companyContracts);
			return "Manager/companys/supplierContractInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 显示采购商合同电子档资料
	@RequestMapping("buyerContractInfo")
	public String buyerContractInfo(Integer companyId,Page page,
			HttpServletRequest request) {
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("companyId", companyId);
			parm.put("page", page);
			List<CompanyContracts> companyContracts = companyContractService
					.findByCompanyIds(parm);
			request.setAttribute("companyContracts", companyContracts);
			request.setAttribute("companyId", companyId);
			int rows = companyContractService.findRows(companyId);
			page.setRows(rows);
			request.setAttribute("page", page);
			request.setAttribute("companyId", companyId);
			return "Manager/companys/buyerContractInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 到添加供应商合同页面
	@RequestMapping("toAddSupplierContract")
	public String toAddSupplierContract(HttpServletRequest request,
			Integer companyId) {
		//到添加供应商合同页面：先将合同信息中的合同状态设置为：2 供应商
		try {
			//System.out.println(companyId);
			request.setAttribute("contractType","2");
			request.setAttribute("companyId", companyId);
			return "Manager/companys/addSupplierContract";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/*// 添加供应商合同信息
	@RequestMapping("addSupplierContract")
	public String addSupplierContract(@RequestParam(value="status")Integer status,
			@RequestParam(value="companyId")Integer companyId,
			@RequestParam(value="contractType")Integer contractType,
			@RequestParam(value="contractTerms")String contractTerms,
			@RequestParam(value="contractContent")String contractContent,
			@RequestParam(value="contractTime")String contractTime,
			@RequestParam(value="contractExpirationTime")String contractExpirationTime,
			HttpServletRequest request) {
		try {
			//通过参数的形式来获取页面上多个radio下取得被选中的radio的值
			CompanyContracts companyContracts=new CompanyContracts();
			
			companyContracts.setContractExpirationTime(contractExpirationTime);
			companyContracts.setContractTime(contractTime);
			companyContracts.setContractContent(java.net.URLDecoder.decode(contractContent,"UTF-8"));
			companyContracts.setContractTerms(java.net.URLDecoder.decode(contractTerms,"UTF-8"));
			companyContracts.setContractType(contractType);
			companyContracts.setStatus(status);
			companyContracts.setCompanyId(companyId);
			
			companyContractService.insert(companyContracts);
			//System.out.println(companyContracts.getCompanyId());
			return "redirect:supplierContractInfo.do?companyId="
					+ companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}*/

	// 到添加采购商合同页面
	@RequestMapping("toAddBuyerContract")
	public String toAddBuyerContract(HttpServletRequest request,
			Integer companyId) {
		try {
			/*//合同类型为：1 采购商
			request.setAttribute("contractType","1");*/
			request.setAttribute("companyId", companyId);
			return "Manager/companys/addBuyerContract";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 添加采购商合同信息
	@RequestMapping(value="addBuyerContract")
	public String addBuyerContract(CompanyContracts companyContracts,HttpServletRequest request) {
		try {
			
			companyContractService.insert(companyContracts);
			return "redirect:buyerContractInfo.do?companyId="
					+ companyContracts.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转修改供应商合同页面
	@RequestMapping("toUpdateSupplierContract")
	public String toUpdateSupplierContract(Integer id,
			HttpServletRequest request) {
		try {
			CompanyContracts CompanyContracts = companyContractService
					.findById(id);
			request.setAttribute("c", CompanyContracts);
			return "Manager/companys/updateSupplierContract";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改供应商合同
	@RequestMapping("updateSupplierContract")
	public String updateSupplierContract(CompanyContracts companyContracts,
			HttpServletRequest request) {
		try {
			companyContractService.updateCompanyContracts(companyContracts);
			System.out.println(companyContracts.getCompanyId());
			return "redirect:supplierContractInfo.do?companyId="
					+ companyContracts.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 跳转修改采购商合同页面
	@RequestMapping("toUpdateBuyerContract")
	public String toUpdateBuyerContract(Integer id, HttpServletRequest request) {
		try {
			List<CompanyContracts> CompanyContracts = companyContractService
					.findByCompanyId(id);
			request.setAttribute("c", CompanyContracts);
			return "Manager/companys/updateBuyerContract";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 修改采购商合同
	@RequestMapping("updateBuyerContract")
	public String updateBuyerContract(CompanyContracts companyContracts,
			HttpServletRequest request) {
		try {
			companyContractService.updateCompanyContracts(companyContracts);
			System.out.println(companyContracts.getCompanyId());
			return "redirect:buyerContractInfo.do?companyId="
					+ companyContracts.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除供应商合同
	@RequestMapping("deleteSupplierContract")
	public String deleteCompanyContract(Integer id,
			CompanyContracts companyContracts, HttpServletRequest request) {
		try {
			companyContractService.deleteCompanyContracts(id);
			return "redirect:supplierContractInfo.do?companyId="
					+ companyContracts.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 删除采购商合同
	@RequestMapping("deleteBuyerContract")
	public String deleteBuyerContract(Integer id,
			CompanyContracts companyContracts, HttpServletRequest request) {
		try {
			companyContractService.deleteCompanyContracts(id);
			System.out.println(companyContracts.getCompanyId());
			return "redirect:buyerContractInfo.do?companyId="
					+ companyContracts.getCompanyId();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	// 批量删除
	@RequestMapping("/deleteMoreContract")
	public void deleteMoreContract(HttpServletRequest request, HttpServletResponse response) { 
		try {
		String sid = request.getParameter("Uid");
		companyContractService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	} 
	
	//修改合同状态
	@RequestMapping("updateContractStatus")
	public String updateContractStatus(Integer id,Integer companyId,HttpServletRequest request){
		try {
			companyContractService.updateContractStatus(id);
			return "redirect:buyerContractInfo.do?companyId="+companyId;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	//合同详情
	@RequestMapping("contractInfo")
	public String contractInfo(Integer id,HttpServletRequest request){
		try {
			CompanyContracts companyContracts = companyContractService.findById(id);
			request.setAttribute("companyContracts", companyContracts);
			return "Manager/companys/contractInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
