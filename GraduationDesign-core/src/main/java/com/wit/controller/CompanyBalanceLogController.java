package com.wit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyBalanceLog;
import com.wit.model.Page;
import com.wit.service.CompanyBalanceLogService;

/**
 * 与公司账户流水相关的控制
 * @author Jason-Tang
 *
 */
@Controller
public class CompanyBalanceLogController extends BaseController{

	@Autowired
	private CompanyBalanceLogService companyBalanceLogService;
	
	//供应商资金账户历史流水
	@RequestMapping("companyBalanceLog")
	public String supplierBalanceLog(Page page,Integer id,HttpServletRequest request){
		try {
			Map<String,Object> parm = new HashMap<String, Object>();
			parm.put("Page", page);
			parm.put("companyId", id);
			List<CompanyBalanceLog> companyBalanceLog = companyBalanceLogService.findById(parm);
			request.setAttribute("companyBalanceLog1", companyBalanceLog);
			int rows = companyBalanceLogService.rows(id);
			page.setRows(rows);
			request.setAttribute("page", page);
			request.setAttribute("companyId", id);
			return "Manager/companys/companyBalanceLogInfo";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
}
