package com.wit.dao;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.WorkflowType;
/**
 * 流程类型
 * @author Administrator
 *
 */
public interface WorkflowTypeDao {
		//查询
		List<WorkflowType> getAll(Page page);
		//删除数据
		void delete(Integer id);
		//添加
		void add(WorkflowType workflowType);
		//根据ID查询
		WorkflowType findbyId (Integer id);
		//更新
		void update(WorkflowType workflowType);
		int findRows();
}
