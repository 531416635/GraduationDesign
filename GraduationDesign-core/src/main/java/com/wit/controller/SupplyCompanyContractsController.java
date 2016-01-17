package com.wit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyContracts;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.CompanyContractService;

@Controller
@RequestMapping("/supplyCompanyContracts")
public class SupplyCompanyContractsController {
	@Autowired
	private CompanyContractService companyContractService;
	
	@RequestMapping("companyContractsList")
	public String companyContractsList(Page page,HttpServletRequest request){
		try {
			Users user = (Users) request.getSession().getAttribute("userInfo");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("companyId", user.getCompanyId());
			map.put("page", page);
			List<CompanyContracts> companyContractss = companyContractService.findByCompanyIds(map);
			int rows = companyContractService.findRows(user.getCompanyId());
			page.setRows(rows);
			request.setAttribute("page", page);
			request.setAttribute("companyContractss", companyContractss);
		return "Manager/products/supplyCompanyContractsList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

}
