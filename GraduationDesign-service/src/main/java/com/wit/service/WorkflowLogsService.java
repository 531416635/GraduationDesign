package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Page;
import com.wit.model.WorkflowLogs;
/**
 * 流程日志
 * @author Administrator
 *
 */
public interface WorkflowLogsService {
	// 查找
	List<WorkflowLogs> getAll(Page page);

	// 根据id查找
	List<Map<String, Object>> findbyRefId(Map<String,Object> parm);

	// 修改
	void update(WorkflowLogs workflowLogs);

	// 添加
	void insert(WorkflowLogs workflowLogs);
	
	int findRows();
}
