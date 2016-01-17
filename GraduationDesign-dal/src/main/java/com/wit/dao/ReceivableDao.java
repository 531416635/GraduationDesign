package com.wit.dao;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.Settlement;
/**
 * @author ljj
 * time: 2015/3/26
 */
public interface ReceivableDao {
	
	//查询数据
	List<Settlement> findAll(Page page);
	//删除数据
	void deleteById(Integer id);
	//增加数据
	void insert(Settlement db);
	//修改数据
	void update(Settlement db);
	//通过id查找数据
	Settlement findById(Integer id);
	
	int findRows();
	//查询银行账号
	List<Integer> findBankAccount();

}
