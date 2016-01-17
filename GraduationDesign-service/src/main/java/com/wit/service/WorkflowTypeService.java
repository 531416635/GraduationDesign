package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.WorkflowType;

/**
 * 流程类型
 * @author lj
 *
 */
public interface WorkflowTypeService {
	 //查找
	List<WorkflowType>getAll(Page page);
	//删除
	void delete(Integer id);
	//添加
	void add(WorkflowType workflowType);
	//根据id查找
	WorkflowType findById(Integer id);
	//修改
	void update(WorkflowType workflowType);
		
	int findRows();
	
}
