package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.MenusDao;
import com.wit.model.Menus;
import com.wit.model.Page;
import com.wit.service.MenusService;

@Service
public class MenusServiceImpl implements MenusService {
	@Resource
	private MenusDao menusDao;

	@Override
	public List<Menus> getAll(Page page) {
		return menusDao.getAll(page);
	}

	@Override
	public List<Menus> findAll() {
		return menusDao.findAll();
	}

	@Override
	public List<Menus> getAll(Page page, String patform,String menuName) {
		return menusDao.getAllByPatform(page, patform,menuName);
	}

	@Override
	public List<Menus> getAllMenu() {
		return menusDao.getAllMenu();
	}

	@Override
	public void delete(Integer id) {
		menusDao.delete(id);
	}

	@Override
	public void deleteByIDs(String id) {
		menusDao.deleteByIDs(id);
	}

	@Override
	public void add(Menus menus) {
		menusDao.add(menus);
	}

	@Override
	public Menus findById(Integer id) {
		return menusDao.findbyId(id);
	}

	@Override
	public void update(Menus menus) {
		menusDao.update(menus);
	}

	@Override
	public int findRows() {
		return menusDao.findRows();
	}

	@Override
	public int findRow(String patform,String menuName) {
		return menusDao.findRow(patform,menuName);
	}

	@Override
	public List<Menus> getMenusByUser(int userID, int patform, int menuType,
			int status) {
		return menusDao.getMenusByUser(userID, patform, menuType, status);
	}
	
	@Override
	public List<Menus> getMenusByMenuUrl(Map<String, Object> parm) {
		return menusDao.getMenusByMenuUrl(parm);
	}
}
