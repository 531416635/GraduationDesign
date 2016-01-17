package com.wit.service;


import com.wit.model.Menus;
import com.wit.model.Page;

import java.util.List;
import java.util.Map;

/**
 * 菜单管理
 * @author Administrator
 *
 */
public interface MenusService {
	//查找
	List<Menus>getAll(Page page);
	List<Menus>getAll(Page page,String patform, String strMenuName);
	//删除
	void  delete(Integer id);
	void  deleteByIDs(String id);
	//添加
	void add(Menus menus);
	//根据id查找
	Menus findById(Integer id);
	//修改
	void update(Menus menus);
	//根據用戶ID獲取菜單列表
	List<Menus> getMenusByUser(int userID, int strPatform,
			int menuType,int status);
	
	List<Menus> getAllMenu();
	
	List<Menus> findAll();
	
	int findRows();
	
    int findRow(String patform, String strMenuName);
    
	List<Menus> getMenusByMenuUrl(Map<String, Object> parm);
}
