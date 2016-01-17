package com.wit.dao;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.Workflows;

/**
 * 用户流程
 * 
 * @author lj
 * 
 */
public interface WorkflowsDao {
	// 查询
	List<Workflows> getAll(Page page);

	// 删除数据
	void delete(Integer id);

	// 添加
	void add(Workflows workflows);

	// 根据ID查询
	Workflows findbyId(Integer id);

	// 更新
	void update(Workflows workflows);

	int findRows();

}
