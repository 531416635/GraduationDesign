package com.wit.dao;

import java.util.List;

import com.wit.model.QuestionType;

/**
 * 问题类别
 * @author lj
 *
 */
public interface QuestionTypeDao {
	
		//查询
		List<QuestionType> getAll();
		//删除数据
		void delete(Integer id);
		//添加
		void add(QuestionType questionType);
		//根据ID查询
		QuestionType findbyId (Integer id);
		//更新
		void update(QuestionType questionType);
		int findRows();
		void deleteByIds(String ids);
		List<QuestionType> getFaqType(int top);
}
