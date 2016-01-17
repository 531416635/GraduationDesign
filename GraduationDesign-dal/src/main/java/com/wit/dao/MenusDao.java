package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Menus;
import com.wit.model.Page;

public interface MenusDao {
	// 查询
	List<Menus> getAll(Page page);

	List<Menus> findAll();

	// 删除
	int delete(int menusID);

	// 删除
	int deleteByIDs(String menusID);

	// 添加
	void add(Menus menus);

	// 根据Id查询
	Menus findbyId(Integer id);

	// 更新
	void update(Menus menus);

	int findRows();

	int findRow(	@Param(value = "patform") String patform,
			@Param(value = "menuName") String menuName);

	List<Menus> getAllMenu();

	// 根据用户ID获取菜单
	List<Menus> getMenusByUser(@Param(value = "userID") int userID,
			@Param(value = "strPatform") int strPatform,
			@Param(value = "menuType") int menuType,
			@Param(value = "status") int status);

	List<Menus> getAllByPatform(@Param(value = "page") Page page,
			@Param(value = "patform") String patform,
			@Param(value = "menuName") String menuName);

	List<Menus> getMenusByMenuUrl(Map<String, Object> parm);
}
