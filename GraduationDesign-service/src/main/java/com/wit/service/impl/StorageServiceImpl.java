package com.wit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.CompanyProductPicDao;
import com.wit.dao.StorageDao;
import com.wit.model.CompanyProductPic;
import com.wit.model.Storage;
import com.wit.service.CompanyProductPicService;
import com.wit.service.StorageService;
@Service
public class StorageServiceImpl implements StorageService{
	@Autowired
	private StorageDao dao;

	@Override
	public void insert(Storage db) {
		dao.insert(db);	
	}


}
