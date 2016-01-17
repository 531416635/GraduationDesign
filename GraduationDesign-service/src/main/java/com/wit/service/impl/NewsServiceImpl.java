package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.NewsDao;
import com.wit.model.News;
import com.wit.service.NewsService;
@Service
public class NewsServiceImpl implements NewsService {
	
	@Resource
	private NewsDao newsDao;

	@Override
	public void deleteNew(Integer id) {
		// TODO Auto-generated method stub
		 newsDao.deleteNew(id);
	}

	@Override
	public void addNew(News news) {
		// TODO Auto-generated method stub
		newsDao.addNew(news);
		
	}

	@Override
	public News findbyId(Integer id) {
		// TODO Auto-generated method stub
		return newsDao.findbyId(id);
	}

	@Override
	public void updateNew(News news) {
		// TODO Auto-generated method stub
		newsDao.updateNew(news);
	}


	@Override
	public int findRows(Integer newType) {
	
		return newsDao.findRows(newType);
	}

	@Override
	public void deleteByIds(String ids) {
		newsDao.deleteByIds(ids);
		
	}

	@Override
	public List<News> findNews(Map<String, Object> maps) {
		
		return newsDao.findNews(maps);
	}

	@Override
	public List<News> findNewsLimit(int top, int newsType)
	{
		return newsDao.findNewsLimit( top,  newsType);
	}

	@Override
	public List<News> findNewsTitle(Map<String, Object> parm) {
		return newsDao.findNewsTitle(parm);
	}

	@Override
	public int findTitleRows(Integer newType) {	
		return newsDao.findTitleRows(newType);
	}

	@Override
	public List<News> findAllNews() {
		
		return newsDao.findAllNews();
	}

	@Override
	public List<News> searchNewsInfo(Map<String, Object> parm) {
		return newsDao.searchNewsInfo(parm);
	}

	@Override
	public int searchNewsRows(Map<String, Object> parm) {
		return newsDao.searchNewsRows(parm);
	}
}
