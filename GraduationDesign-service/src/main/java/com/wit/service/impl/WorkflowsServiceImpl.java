package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.WorkflowsDao;
import com.wit.model.Page;
import com.wit.model.Workflows;
import com.wit.service.WorkflowsService;

@Service
public class WorkflowsServiceImpl implements WorkflowsService {
	@Resource
	private WorkflowsDao workflowsDao;
	
	@Override
	public List<Workflows> getAll(Page page){
		return workflowsDao.getAll(page);
	}
	
	@Override
	public void delete(Integer id){
		workflowsDao.delete(id);
	}	

	
	
	
	@Override
	public void add(Workflows workflows){
		workflowsDao.add(workflows);
	}
	
	@Override
	public Workflows findById(Integer id){
		return workflowsDao.findbyId(id);
	}
	
	@Override
	public void update(Workflows workflows){
		workflowsDao.update(workflows);
	}
	
	@Override
	 public int findRows(){
		 return workflowsDao.findRows();
	 }	
	
}
