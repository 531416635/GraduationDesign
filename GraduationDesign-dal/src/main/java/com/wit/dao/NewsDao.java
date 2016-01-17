package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.News;

public interface NewsDao {
	//查询所有新闻信息
	List<News>  findNews(Map<String,Object> maps);
	//查询所有新闻标题
	List<News>findNewsTitle(Map<String,Object> parm);
	//查询新闻标题数量
	int findTitleRows(Integer newType);
	//删除新闻信息
	void deleteNew(Integer id);
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	//增加新闻公告
	void addNew(News news);
	//根据Id查询新闻公告信息
	News findbyId(Integer id);
	//更新新闻公告
	void updateNew(News news);
	
	int findRows(Integer newType);
	
	List<News> findNewsLimit(@Param(value = "top")   int top,@Param(value = "newsType")  int newsType);
	
	List<News> findAllNews(); //门户商户控制台
	
	//新闻搜索
	List<News> searchNewsInfo(Map<String,Object> parm);
	
	//新闻搜索行数
	int searchNewsRows(Map<String,Object> parm);
}
