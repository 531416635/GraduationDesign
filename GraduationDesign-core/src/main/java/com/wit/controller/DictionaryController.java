package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.DictionaryPage;
import com.wit.model.DictionaryType;
import com.wit.model.Dictionarys;
import com.wit.service.DictionaryService;
import com.wit.service.DictionaryTypeService;

@Controller
@RequestMapping("dictionary")
public class DictionaryController {
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private DictionaryTypeService typeService;
	
	
	/**
	 * 字典列表
	 * @param page
	 * @param request
	 * @return
	 */
	@RequestMapping("dictionaryList")
	public String dictionaryList(DictionaryPage page,HttpServletRequest request){
		String json="";
		List<Dictionarys> dictionary=dictionaryService.findAll(page);
		int rows = dictionaryService.findRows(page);
		page.setRows(rows);
		request.setAttribute("dictionaryPage", page);
		request.setAttribute("page", page);
		request.setAttribute("dictionary", dictionary);
		json=JSONObject.fromObject(page).toString();
		request.setAttribute("json", json);
		return "Manager/dictionary/dictionaryList";
	}
	/**
	 * 进入添加界面
	 * @return
	 */
	@RequestMapping("toDictionaryAdd")
	public String toDictionaryAdd(HttpServletRequest request){
		List<Dictionarys> dictionarys=dictionaryService.findParentDic();
		request.setAttribute("dictionarys", dictionarys);
		List<DictionaryType> dictionaryTypes = typeService.findAllDicType();
		request.setAttribute("dictionaryTypes", dictionaryTypes);
		return "Manager/dictionary/dictionaryAdd";
	}
	/**
	 * 添加字典
	 * @param dictionary
	 * @return
	 */
	@RequestMapping("dictionaryAdd")
	public String dictionaryAdd(Dictionarys dictionary){
		dictionaryService.insert(dictionary);
		return "redirect:dictionaryList.do";
	}
	/**
	 * 进入更新页面
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("toDictionaryUpdate")
	public String toDictionaryUpdate(Integer id,HttpServletRequest request){
		Dictionarys dictionary=dictionaryService.findById(id);
		request.setAttribute("dictionary", dictionary);
		List<Dictionarys> dictionarys=dictionaryService.findParentDic();
		request.setAttribute("dictionarys", dictionarys);
		List<DictionaryType> dictionaryTypes = typeService.findAllDicType();
		request.setAttribute("dictionaryTypes", dictionaryTypes);
		System.out.println("dictionaryTypes:"+dictionaryTypes);
		System.out.println("dictionarys:"+dictionarys);
		return "Manager/dictionary/dictionaryUpdate";
	}
	/**
	 * 更新字典
	 * @param dictionary
	 * @return
	 */
	@RequestMapping("dictionaryUpdate")
	public String dictionaryUpdate(Dictionarys dictionary){

		dictionaryService.update(dictionary);
		return "redirect:dictionaryList.do";
	}
	/**
	 *删除字典 
	 * @param id
	 * @return
	 */
	@RequestMapping("dictionaryDelete")
	public String dictionaryDelete(Integer id){
		dictionaryService.deleteById(id);
		return "redirect:dictionaryList.do";
	}

}
