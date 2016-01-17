package com.wit.dao;

import java.util.List;

import com.wit.model.DictionaryType;

public interface DictionnaryTypeDao {
	List<DictionaryType> findAllDicType();//查询所有字典类型
}
