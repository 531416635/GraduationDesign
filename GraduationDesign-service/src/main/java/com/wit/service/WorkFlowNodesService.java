package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.WorkflowNodes;

/**
 * 流程节点
 * 
 * @author lj
 * 
 */
public interface WorkFlowNodesService {

	// 查找
	List<WorkflowNodes> getAll(Page page);

	// 删除
	void delete(Integer id);

	// 添加
	void add(WorkflowNodes workFlowNodes);

	// 根据id查找
	WorkflowNodes findById(Integer id);

	// 修改
	void update(WorkflowNodes workFlowNodes);

	int findRows();

}
