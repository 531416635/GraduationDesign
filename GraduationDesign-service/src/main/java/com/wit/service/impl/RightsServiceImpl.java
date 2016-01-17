package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.RightsDao;
import com.wit.model.Page;
import com.wit.model.Rights;
import com.wit.service.RightsService;

@Service("RightsService")
public class RightsServiceImpl implements RightsService{
	@Resource
	private RightsDao Rights;
	
	    @Override
		public List<Rights> findAll(Page page) {
			return Rights.findAll(page);
		}
	    
	    @Override
		public List<Rights> allocationRight(Integer id) {
			return Rights.allocationRight(id);
		}
		
	    @Override
		public void deleteRight(Integer id) {
	    	Rights.deleteRight(id);
		}
	    
	    @Override
	   	public void addRight(Rights db) {
	       	Rights.addRight(db);
	   	}
	    
	    @Override
	   	public void updateRight(Rights db){
	       	Rights.updateRight(db);
	   	}
	    
	    @Override
	   	public Rights findById(Integer id) {
	   		return Rights.findById(id);
	   	}
	    @Override
	   	public int findRows() {
	   		return Rights.findRows();
	   	}
	    @Override
	   	public List<Integer> findMenusId() {
	   		return Rights.findMenusId();
	   	}
	    

}
