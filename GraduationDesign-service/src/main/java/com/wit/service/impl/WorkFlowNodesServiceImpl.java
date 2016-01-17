package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.WorkFlowNodesDao;
import com.wit.model.Page;
import com.wit.model.WorkflowNodes;
import com.wit.service.WorkFlowNodesService;

@Service
public class WorkFlowNodesServiceImpl implements WorkFlowNodesService {
	@Resource
	private WorkFlowNodesDao workFlowNodesDao;

	@Override
	public List<WorkflowNodes> getAll(Page page) {
		return workFlowNodesDao.getAll(page);
	}

	@Override
	public void delete(Integer id) {
		workFlowNodesDao.delete(id);
	}

	@Override
	public void add(WorkflowNodes workFlowNodes) {
		workFlowNodesDao.add(workFlowNodes);
	}

	@Override
	public WorkflowNodes findById(Integer id) {
		return workFlowNodesDao.findbyId(id);
	}

	@Override
	public void update(WorkflowNodes workFlowNodes) {
		workFlowNodesDao.update(workFlowNodes);
	}

	@Override
	public int findRows() {
		return workFlowNodesDao.findRows();
	}

}
