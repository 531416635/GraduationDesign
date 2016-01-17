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
import com.wit.service.ReceivableService;
/**
 * 
 * @author ljj
 * time: 2013-3-23
 *
 */
/*   应收管理     */
@Controller
@RequestMapping("/supplys")
public class ReceivableController extends BaseController{
	@Resource
	private ReceivableService receivableService;
	
	//查询数据
	@RequestMapping("/receivable")
	public String linkReceivable(HttpServletRequest request,Model model,Page page){
		String json="";
		//查询所有数据
		List<Settlement> list = receivableService.findAll(page);
		HttpSession session = request.getSession();
		session.setAttribute("receivables", list);
		int rows = receivableService.findRows();
	     page.setRows(rows);
		 model.addAttribute("page", page);
		 json=JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
		return "Manager/supplys/receivableList";
	}
	
	//跳转到增加页面
	@RequestMapping("/toReceivableAdd")
	public String toSupplyAdd(Model model){
		List<Integer> bankAccountList = receivableService.findBankAccount();
		model.addAttribute("bankAccounts" 
				, bankAccountList);
		return "Manager/supplys/receivableListAdd";
	}
	//增加数据
	@RequestMapping("/receivableAdd")
	public String SupplyAdd(Settlement db){
		receivableService.insert(db);
		return "redirect:receivable.do";
	}
	
	//跳转到修改页面
	@RequestMapping("/toReceivableUpdate")
	public String toSupplyUpdate(HttpServletRequest request,Model model){
		String eid = request.getParameter("id");
		Settlement dbl = receivableService.findById(Integer.parseInt(eid));
		model.addAttribute("dbset", dbl);
		List<Integer> bankAccountList = receivableService.findBankAccount();
		model.addAttribute("bankAccountU", bankAccountList);
		return "Manager/supplys/receivableListUpdate";
	}
	//修改数据
	@RequestMapping("/receivableUpdate")
	public String SupplyUpdate(Settlement db){
		receivableService.update(db);
		return "redirect:receivable.do";
	}
	
	//删除数据
		@RequestMapping("/receivableDelete")
		public String deleteData(HttpServletRequest request){
			//通过获取ID来删除一条数据
			String id = request.getParameter("id");
			if(id != null){
				receivableService.deleteById(Integer.parseInt(id));
			}
			return "Manager/redirect:receivable.do";
		}
		
		//批量删除
		@RequestMapping("/allDeletereceivable") 
		public void deleteMore(HttpServletRequest request, HttpServletResponse response) { 
			String sid = request.getParameter("Uid");
			String[] item = sid.split("@"); 
			for (int i = 0; i < item.length; i++) { 
				receivableService.deleteById(Integer.parseInt(item[i])); 
			} 
		} 

}
