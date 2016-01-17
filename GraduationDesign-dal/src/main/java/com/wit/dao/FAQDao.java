package com.wit.dao;

import java.util.List;

import com.wit.model.FAQ;
import com.wit.model.Page;

/**
 * 常见问题
 * @author lj
 *
 */
public interface FAQDao {
		//查询
		List<FAQ> getAll();
		//删除数据
		void delete(Integer id);
		//添加
		void add(FAQ faq);
		//根据ID查询
		FAQ findbyId (Integer id);
		//更新
		void updateById(FAQ faq);
		List<FAQ> findAll(Page page);
		int findRows();
		void  deleteByIds(String ids);
		List<FAQ> getFaqByType(int faqType);
		
}
