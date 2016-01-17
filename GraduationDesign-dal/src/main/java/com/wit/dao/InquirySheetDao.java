package com.wit.dao;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.InquirySheet;
import com.wit.model.Page;




/**
 * 询价单
 * @author 林建
 *
 */
public interface InquirySheetDao {
	
	//查询
	List<InquirySheet> getAll(Page page);
    //删除
     int delete(int inquirySheetID);
    //添加
     void add(InquirySheet inquirySheet);
    //根据Id查询
     InquirySheet findbyId(Integer id);
     //更新
 	void update(InquirySheet inquirySheet);
    
	int findRows();
	
	//根据用户ID显示其询价单(系统后台)
	List<InquirySheet> findAll(Map<String,Object> parm);
	
	//根据用户ID查询行数
	int rows(Integer userId);
	
	//展示询价单信息
	List<Map<String,Object>> findAllByIds(Map<String,Object> parm);
	
	//微信端查询询价单信息
	List<Map<String,Object>> weChatFindAllByIds(Map<String,Object> parm);

	//微信端查询询价单信息总条数
	int weChatFindAllRowsByIds(Map<String,Object> parm);	
	
	//修改询价单信息
	void updateInquirySheetInfo(InquirySheet inquirySheet);
	//根据询价单号获取信息
	InquirySheet findByInquiryId(String inquiryId);
	
	//逻辑删除询价单信息
	void deleteInquirySheetInfo(String inquiryId);
	
	void updateStatusByIds(@Param(value = "ids")String ids,@Param(value = "status") Integer status);
	
	int findAllByIdsRows(Map<String, Object> parm);
}











