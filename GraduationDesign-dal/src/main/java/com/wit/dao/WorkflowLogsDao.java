package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.WorkflowLogs;

/**
 * 流程日志
 * 
 * @author lj
 * 
 */
public interface WorkflowLogsDao {
	// 查询
	List<WorkflowLogs> getAll(Page page);

	// 删除数据
	void delete(Integer id);

	// 添加
	void add(WorkflowLogs workflowLogs);

	// 根据ID查询
	List<Map<String, Object>> findbyRefId(Map<String,Object> parm);

	// 更新
	void update(WorkflowLogs workflowLogs);

	int findRows();

	// 添加
	void insert(WorkflowLogs workflowLogs);
	
}
