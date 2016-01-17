package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.Groupon;
import com.wit.model.Page;

/**
 * @author ljj time: 2015/3/26
 */

public interface GrouponDao {
	// 查询数据
	List<Groupon> findAll(Map<String, Object> parm);

	// 删除数据
	void deleteById(Integer id);

	// 根据ID字符数组删除数据
	void deleteByIds(String ids);

	// 增加数据
	void insert(Groupon db);

	// 修改数据
	void update(Groupon db);

	// 通过id查找数据
	List<Map<String, Object>> findById(Integer id);

	// 通过productId查找数据
	Groupon findByProductId(Integer productId);

	// 团购商品显示
	List<Map<String, Object>> findGroupon(Map<String, Object> parm);

	// 更新团购状态
	void checkStatus(Groupon groupon);

	int findRows(Map<String, Object> parm);
	//更新售出数量
	void addSoldOut(Map<String, Object> parm);
	// 团购热销商品显示
	List<Map<String, Object>> findGrouponHot(Map<String, Object> parm1);

}
