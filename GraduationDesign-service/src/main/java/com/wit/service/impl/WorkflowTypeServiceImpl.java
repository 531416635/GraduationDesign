package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.WorkflowTypeDao;
import com.wit.model.Page;
import com.wit.model.WorkflowType;
import com.wit.service.WorkflowTypeService;

@Service
public class WorkflowTypeServiceImpl implements WorkflowTypeService {

	@Resource
	private WorkflowTypeDao workflowTypeDao;

	@Override
	public List<WorkflowType> getAll(Page page) {
		return workflowTypeDao.getAll(page);
	}

	@Override
	public void delete(Integer id) {
		workflowTypeDao.delete(id);
	}

	@Override
	public void add(WorkflowType workflowType) {
		workflowTypeDao.add(workflowType);
	}

	@Override
	public WorkflowType findById(Integer id) {
		return workflowTypeDao.findbyId(id);
	}

	@Override
	public void update(WorkflowType workflowType) {
		workflowTypeDao.update(workflowType);
	}
	
	@Override
	public int findRows() {
		return workflowTypeDao.findRows();
	}

}
