package com.wit.dao;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.WorkflowNodes;

/**
 * 流程节点
 * 
 * @author lj
 * 
 */
public interface WorkFlowNodesDao {
	// 查询
	List<WorkflowNodes> getAll(Page page);

	// 删除数据
	void delete(Integer id);

	// 添加
	void add(WorkflowNodes workFlowNodes);

	// 根据ID查询
	WorkflowNodes findbyId(Integer id);

	// 更新
	void update(WorkflowNodes workFlowNodes);

	int findRows();

}
