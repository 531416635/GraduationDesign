package com.wit.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.wit.dao.FAQDao;
import com.wit.model.FAQ;
import com.wit.model.Page;
import com.wit.service.FAQService;

@Service("FAQService")
public class FAQServiceImpl implements FAQService {
	@Resource
	private FAQDao faqDao;

	// 查询数据
	@Override
	public List<FAQ> findAll(Page page) {
		return faqDao.findAll(page);
	}

	// 删除数据
	@Override
	public void deleteById(Integer id) {
		faqDao.delete(id);
	}

	// 增加数据
	@Override
	public void insertData(FAQ faq) {
		faqDao.add(faq);
	}

	// 修改数据
	@Override
	public void updateById(FAQ faq) {
		faqDao.updateById(faq);
	}

	// 通过id查找数据
	@Override
	public FAQ findById(Integer id) {
		return faqDao.findbyId(id);
	}

	@Override
	public int findRows() {
		return faqDao.findRows();
	}

	@Override
	public void deleteByIds(String ids) {
		 faqDao.deleteByIds(ids);
	}
	@Override
	public List<FAQ> getFaqByType(int faqType)
	{
		return faqDao.getFaqByType(faqType);
	}
}
