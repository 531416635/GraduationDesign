package com.wit.dao;

import java.util.List;

import com.wit.model.MaterialOutboundOrder;
/**
 * @author ljj
 * time: 2015/3/26
 */

public interface MaterialOutboundOrderDao {
	    //查询数据
		List<MaterialOutboundOrder> findAll();
		//删除数据
		void deleteById(Integer id);
		//增加数据
		void insert(MaterialOutboundOrder db);
		//修改数据
		void update(MaterialOutboundOrder db);
		//通过id查找数据
		MaterialOutboundOrder findById(Integer id);

}
