package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.DictionaryDao;
import com.wit.model.DictionaryPage;
import com.wit.model.Dictionarys;
import com.wit.service.DictionaryService;
@Service
public class DictionaryServiceImpl implements DictionaryService{
	@Resource
	private DictionaryDao dao;

	@Override
	public int findRows(DictionaryPage page) {	
		return dao.findRows(page);
	}

	@Override
	public List<Dictionarys> findAll(DictionaryPage page) {
		
		return dao.findAll(page);
	}

	// 根据字典类型查询字典
	@Override
	public List<Dictionarys> getDicsByDicType(int dicType){
		return dao.getDicsByDicType(dicType);
	}
	
	@Override
	public void insert(Dictionarys dictionary) {
		dao.insert(dictionary);
		
	}

	@Override
	public Dictionarys findById(Integer id) {
		
		return dao.findById(id);
	}

	@Override
	public void update(Dictionarys dictionary) {
		dao.update(dictionary);
		
	}

	@Override
	public void deleteById(Integer id) {
		dao.deleteById(id);
		
	}


	@Override
	public List<Dictionarys> findByParentId(Integer id) {
		return dao.findByParentId(id);
	}

	@Override
	public List<Dictionarys> findProvinceInfo() {
		return dao.findProvinceInfo();
	}


	@Override
	public List<Dictionarys> findParentDic() {
		
		return dao.findParentDic();
	}
	
}
