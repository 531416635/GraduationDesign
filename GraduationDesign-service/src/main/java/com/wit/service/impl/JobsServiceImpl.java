package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.JobsDao;
import com.wit.model.Jobs;
import com.wit.model.Page;
import com.wit.service.JobsService;
@Service("JobsService")
public class JobsServiceImpl implements JobsService{
	@Resource
	private JobsDao jobs;
	
	@Override
	public List<Jobs> findAll(Page page) {
		return jobs.findAll(page);
	}
	
    @Override
	public void deleteJob(Integer id) {
    	jobs.deleteJob(id);
	}
    
    @Override
   	public void insertJob(Jobs db) {
    	jobs.insertJob(db);
   	}
    
    @Override
   	public void updateJob(Jobs db){
    	jobs.updateJob(db);
   	}
    @Override
   	public void updateJobName(Jobs db){
    	jobs.updateJobName(db);
   	}
    @Override
   	public Jobs findById(Integer id) {
   		return jobs.findById(id);
   	}
    
    @Override
   	public int findRows() {
   		return jobs.findRows();
   	}

	@Override
	public List<Jobs> findByDeptId(Integer id) {
		return jobs.findByDeptId(id);
	}
	
	@Override
	public List<Integer> findDeptId() {
		return jobs.findDeptId();
	}

}
