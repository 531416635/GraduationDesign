package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.Workflows;

/**
 * 用户流程
 * @author lj
 *
 */

public interface WorkflowsService {
	//查找
	List<Workflows>getAll(Page page);
	//删除
	void delete(Integer id);
	//添加
	void add(Workflows workflows);
	//根据id查找
	Workflows findById(Integer id);
	//修改
	void update(Workflows workflows);
		
	int findRows();
	
}
