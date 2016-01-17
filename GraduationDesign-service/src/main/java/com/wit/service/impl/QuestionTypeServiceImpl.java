package com.wit.service.impl;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.QuestionTypeDao;
import com.wit.model.QuestionType;
import com.wit.service.QuestionTypeService;
@Service
public class QuestionTypeServiceImpl implements QuestionTypeService  {
	@Resource
	private QuestionTypeDao questionTypedao;
	@Override
	public List<QuestionType> getAll() {
		
		return questionTypedao.getAll();
	}

	@Override
	public void delete(Integer id) {
		questionTypedao.delete(id);
		
	}

	@Override
	public void add(QuestionType QuestionType) {
		questionTypedao.add(QuestionType);
		
	}

	@Override
	public QuestionType findbyId(Integer id) {
		
		return questionTypedao.findbyId(id);
	}

	@Override
	public void update(QuestionType QuestionType) {
		questionTypedao.update(QuestionType);
		
	}
	
	@Override
	public int findRows() {
	
		return questionTypedao.findRows();
	}

	@Override
	public void deleteByIds(String ids) {
		questionTypedao.deleteByIds(ids);
		
	}

	@Override
	public List<QuestionType> getFaqType(int top)	
	{
		return questionTypedao.getFaqType( top);
	}
	
}
