package com.wit.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Page;
import com.wit.model.Settlement;
import com.wit.service.PayableService;

/**
 * 
 * @author ljj
 * time: 2013-3-22
 *
 */
/*   应付管理     */
@Controller
@RequestMapping("/supplys")
public class PayableController extends BaseController{
	@Resource
	private PayableService payService;
	
	//查询数据
	@RequestMapping("/payable")
	public String linkPayable(HttpServletRequest request,Model model,Page page){
		String json="";
		//查询所有数据
		List<Settlement> list = payService.findAll(page);
		HttpSession session = request.getSession();
		session.setAttribute("pays", list);
		int rows = payService.findRows();
	     page.setRows(rows);
		 model.addAttribute("page", page);
		 json=JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
		return "Manager/supplys/payableList";
	}
	//跳转到增加页面
	@RequestMapping("/toPayableAdd")
	public String toSupplyAdd(Model model){
		List<Integer> bankAccountList = payService.findBankAccount();
		model.addAttribute("bankAccounts", bankAccountList);
		
		return "Manager/supplys/payableListAdd";
	}
	//增加数据
	@RequestMapping("/payableAdd")
	public String SupplyAdd(Settlement db){
		payService.insert(db);
		return "redirect:payable.do";
	}
	
	//跳转懂啊修改页面
	@RequestMapping("/toPayableUpdate")
	public String toSupplyUpdate(HttpServletRequest request,Model model){
		String eid = request.getParameter("id");
		Settlement dbl = payService.findById(Integer.parseInt(eid));
		model.addAttribute("db", dbl);
		List<Integer> bankAccountList = payService.findBankAccount();
		model.addAttribute("bankAccountU", bankAccountList);
		return "Manager/supplys/payableListUpdate";
	}
	//修改页面
	@RequestMapping("/payableUpdate")
	public String SupplyUpdate(Settlement db){
		payService.update(db);
		return "redirect:payable.do";
	}
	
	//删除数据
		@RequestMapping("/payableDelete")
		public String deleteData(HttpServletRequest request){
			//通过获取ID来删除一条数据
			String id = request.getParameter("id");
			if(id != null){
				payService.deleteById(Integer.parseInt(id));
			}
			return "redirect:payable.do";
		}
		
		//批量删除
		@RequestMapping("/allDeletePay") 
		public void deleteMore(HttpServletRequest request, HttpServletResponse response) { 
			String sid = request.getParameter("Uid");
			String[] item = sid.split("@"); 
			for (int i = 0; i < item.length; i++) { 
				payService.deleteById(Integer.parseInt(item[i])); 
			} 
		} 
	
   
}
