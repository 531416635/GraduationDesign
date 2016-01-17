package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Groupon;
import com.wit.model.Page;

/**
 * 
 * 
 */

public interface GrouponService {

	// 增加数据
	void insert(Groupon db);

	// 通过productId查找数据
	Groupon findByProductId(Integer productId);

	// 团购商品显示
	List<Map<String, Object>> findGroupon(Map<String, Object> parm);

	// 更新团购状态
	void checkStatus(Groupon groupon);

	// 查询数据
	List<Groupon> findAll(Map<String, Object> parm);

	int findRows(Map<String, Object> parm);

	// 通过id查找数据
	List<Map<String, Object>> findById(Integer id);

	// 删除数据
	void deleteById(Integer id);

	// 根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	// 修改数据
	void update(Groupon db);
	//更新售出数量
	void addSoldOut(Map<String, Object> parm);
	// 团购热销商品显示
	List<Map<String, Object>> findGrouponHot(Map<String, Object> parm1);
}
