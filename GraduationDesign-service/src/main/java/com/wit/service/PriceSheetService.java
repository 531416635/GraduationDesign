package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Page;
import com.wit.model.PriceSheet;

/**
 * 报价单
 * 
 * @author Administrator
 * 
 */
public interface PriceSheetService {
	// 查找
	List<PriceSheet> getAll(Page page);

	// 刪除
	String delete(int id);

	// 添加
	void add(PriceSheet priceSheet);

	int addByIds(Map<String, Object> parm);

	// 根据id查找
	PriceSheet findById(Integer id);

	// 修改
	void update(PriceSheet priceSheet);

	int findRows();

	// 根据用户ID显示其报价单
	List<PriceSheet> findAll(Map<String, Object> parm);

	// 根据用户ID查询行数
	int rows(Integer userId);

	// 门户报价单信息
	// List<Map<String,Object>> priceSheetInfo(String ids);
	List<Map<String, Object>> getPriceSheetInfo(Map<String, Object> parm);  	
	
	List<Map<String, Object>> getWeChatPriceSheetInfo(Map<String, Object> parm); //微信端查询报价单
	
	Integer getWeChatPriceSheetInfoRow(Map<String, Object> parm);  	//微信端查询报价单总条数
	
  	//议价单数据展示
  	List<Map<String,Object>> getBargainingInfo(Map<String,Object> parm);
  	
	List<Map<String, Object>> getCompanyBargainingInfo(Map<String, Object> parm);
  	
	Integer getPriceSheetInfoRow(Map<String, Object> parm);  	
  	//议价单数据展示
	Integer getBargainingInfoRow(Map<String,Object> parm);
  	
	Integer getCompanyBargainingInfoRow(Map<String, Object> parm);
	
  	//议价
  	void bargaining(PriceSheet priceSheet);
  	
  	//逻辑删除报价单信息
  	void deletePriceSheetInfo(PriceSheet priceSheet);

	void updateByIds(Map<String, Object> parm);
	
	//议价供应商已响应
	int bargainingResponse(Integer userId);
	
	//议价等待处理
	int bargainingWait(Integer companyId);
	
}
