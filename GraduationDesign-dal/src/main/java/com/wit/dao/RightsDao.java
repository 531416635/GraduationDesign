package com.wit.dao;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.Rights;



public interface RightsDao {
	    //查询所有新闻信息
		List<Rights>  findAll(Page page);
		//删除新闻信息
		void deleteRight(Integer id);
		//增加新闻公告
		void addRight(Rights rights);
		//根据Id查询新闻公告信息
		Rights findById(Integer id);
		//更新新闻公告
		void updateRight(Rights rights);
		//查询菜单ID
		List<Integer> findMenusId();
		
		int findRows();
		
		//关联查询 --》 分配权限 
		List<Rights> allocationRight(Integer id);
}
