package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.PayableDao;
import com.wit.model.Page;
import com.wit.model.Settlement;
import com.wit.service.PayableService;

@Service("payableService")
public class PayableServiceImpl implements PayableService{
    @Resource
	private PayableDao payable;
    
    
    @Override
	public List<Settlement> findAll(Page page) {
		return payable.findAll(page);
	}
	
    @Override
	public void deleteById(Integer id) {
    	payable.deleteById(id);
	}
    
    @Override
   	public Settlement findById(Integer id) {
   		return payable.findById(id);
   	}
	
   
       
   @Override
  	public void insert(Settlement db) {
	   payable.insert(db);
  	}

	@Override
  	public void update(Settlement db){
	   payable.update(db);
  	}
	@Override
   	public int findRows() {
   		return  payable.findRows();
   	}
	
	@Override
	public List<Integer> findBankAccount() {
		return payable.findBankAccount();
	}
}
