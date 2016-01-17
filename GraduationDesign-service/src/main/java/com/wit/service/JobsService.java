package com.wit.service;

import java.util.List;

import com.wit.model.Jobs;
import com.wit.model.Page;

public interface JobsService {
	//查看所有部门岗位信息
		List<Jobs> findAll(Page page);
		
		//根据ID查找
	    Jobs findById(Integer id); 
		
		//更新
		void updateJob(Jobs jobs);
		
		//删除
		void deleteJob(Integer id);
		
		//增加
		void insertJob(Jobs jobs);
		
		int findRows();

		//根据部门ID查找岗位名称
		List<Jobs>  findByDeptId(Integer id);
		//查询部门ID
		List<Integer> findDeptId();

		void updateJobName(Jobs dbl);
}
