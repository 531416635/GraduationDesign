package com.wit.service;

import java.util.List;

import com.wit.model.QuestionType;

public interface QuestionTypeService {

	List<QuestionType> getAll(); // 查询

	void delete(Integer id); // 删除数据

	void deleteByIds(String ids); // 根据ID字符数组删除数据

	void add(QuestionType questionType); // 添加

	QuestionType findbyId(Integer id); // 根据ID查询

	void update(QuestionType questionType); // 更新

	int findRows(); // 记录信息条数

	List<QuestionType> getFaqType(int top);
}
