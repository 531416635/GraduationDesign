package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.InquirySheet;
import com.wit.model.Page;

/**
 * 询价单
 * @author Administrator
 *
 */
public interface InquirySheetService{		
		
		List<InquirySheet> getAll(Page page);//查找
	   
	    String delete(int id); //刪除
	   
	    void add(InquirySheet inquirySheet); //添加
	    	    
	    InquirySheet findById(Integer id);//根据id查找
	   
	    void update(InquirySheet inquirySheet); //修改
	     
	    int findRows();
	    
		List<InquirySheet> findAll(Map<String,Object> parm);//根据用户ID分页显示其询价单	
		
		int rows(Integer userId);//根据用户ID查询行数

		List<Map<String,Object>> findAllByIds(Map<String,Object> parm);
			
		List<Map<String,Object>> weChatFindAllByIds(Map<String,Object> parm);//微信端查询询价单信息
		
		int weChatFindAllRowsByIds(Map<String,Object> parm);//微信端查询询价单信息总条数
				
		void updateInquirySheetInfo(InquirySheet inquirySheet);//修改询价单信息
		
		InquirySheet findByInquiryId(String inquiryId);	//根据询价单号获取信息
			
		void deleteInquirySheetInfo(String inquiryId);//逻辑删除议价单信息
				
		void updateStatusByIds(String ids, Integer status);//更改询价单状态
		
		int findAllByIdsRows(Map<String, Object> parm);
		
}
