package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.WorkflowLogsDao;
import com.wit.model.Page;
import com.wit.model.WorkflowLogs;
import com.wit.service.WorkflowLogsService;

@Service
public class WorkflowLogsServiceImpl implements WorkflowLogsService{
	@Resource
	private WorkflowLogsDao workflowLogsDao;

	@Override
	public List<WorkflowLogs> getAll(Page page) {
		return workflowLogsDao.getAll(page);
	}

	@Override
	public void update(WorkflowLogs workflowLogs) {
		workflowLogsDao.update(workflowLogs);
	}

	@Override
	public int findRows() {
		return workflowLogsDao.findRows();
	}


	@Override
	public void insert(WorkflowLogs workflowLogs) {
		workflowLogsDao.insert(workflowLogs);
	}

	public List<Map<String, Object>> findbyRefId(Map<String, Object> parm) {
		return workflowLogsDao.findbyRefId(parm);
	}

}
