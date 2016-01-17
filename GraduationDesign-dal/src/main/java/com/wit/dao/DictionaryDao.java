package com.wit.dao;

import java.util.List;

import com.wit.model.DictionaryPage;
import com.wit.model.Dictionarys;

public interface DictionaryDao {
	
	List<Dictionarys> findAll(DictionaryPage page);	  //查询数据
	
	List<Dictionarys> getDicsByDicType(int dicType); // 根据字典类型查询字典
	
	List<Dictionarys> findParentDic(); // 查询所有父类字典 
	
	int findRows(DictionaryPage page); //记录信息条数
	
	void insert(Dictionarys dictionary);
	
	Dictionarys findById(Integer id);
	
	void deleteById(Integer id);
	
	void update(Dictionarys dictionary);
	
	//省市区三级联动查询
	List<Dictionarys> findByParentId(Integer id);
	
	//查询所有省的信息
	List<Dictionarys> findProvinceInfo();
	
	
	

}
