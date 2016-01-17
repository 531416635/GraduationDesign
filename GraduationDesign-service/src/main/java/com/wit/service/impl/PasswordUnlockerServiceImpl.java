package com.wit.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.PasswordUnlockerDao;
import com.wit.model.PasswordUnlocker;
import com.wit.service.PasswordUnlockerService;

@Service("PasswordUnlockerService")
public class PasswordUnlockerServiceImpl implements PasswordUnlockerService{
	
	@Autowired
	private PasswordUnlockerDao dao;

	@Override
	public void add(Map<String,Object> parm) {
		dao.add(parm);
	}

	@Override
	public PasswordUnlocker findByUserId(Integer userId) {
		return dao.findByUserId(userId);
	}
	

}
