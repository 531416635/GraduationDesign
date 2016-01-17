package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.ReceivableDao;
import com.wit.model.Page;
import com.wit.model.Settlement;
import com.wit.service.ReceivableService;

@Service("receivableService")
public class ReceivableServiceImpl implements ReceivableService{
    @Resource
	private ReceivableDao receivable;
    
    
    @Override
	public List<Settlement> findAll(Page page) {
		return receivable.findAll(page);
	}
	
    @Override
	public void deleteById(Integer id) {
    	receivable.deleteById(id);
	}
    
    @Override
   	public Settlement findById(Integer id) {
   		return receivable.findById(id);
   	}
	
   
       
   @Override
  	public void insert(Settlement db) {
	   receivable.insert(db);
  	}

	@Override
  	public void update(Settlement db){
		receivable.update(db);
  	}
	@Override
   	public int findRows() {
   		return receivable.findRows();
   	}
	
	@Override
	public List<Integer> findBankAccount() {
		return receivable.findBankAccount();
	}
}
