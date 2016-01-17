package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.DictionnaryTypeDao;
import com.wit.model.DictionaryType;
import com.wit.service.DictionaryTypeService;
@Service
public class DictionaryTypeServiceImpl implements DictionaryTypeService{
	@Resource
	private DictionnaryTypeDao dao;
	@Override
	public List<DictionaryType> findAllDicType() {
		return dao.findAllDicType();
	}

}
