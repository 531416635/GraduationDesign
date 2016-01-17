package com.wit.service;

import java.util.List;
import com.wit.model.FAQ;
import com.wit.model.Page;

public interface FAQService {
	// 查询数据
	List<FAQ> findAll(Page page);

	// 删除数据
	void deleteById(Integer id);

	// 增加数据
	void insertData(FAQ db);

	// 修改数据
	void updateById(FAQ db);

	// 通过id查找数据
	FAQ findById(Integer id);
	int findRows();

	void deleteByIds(String ids);

	List<FAQ> getFaqByType(int faqType);
}
