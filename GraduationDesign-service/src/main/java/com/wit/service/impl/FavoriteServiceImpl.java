package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.FavoriteDao;
import com.wit.model.Favorite;
import com.wit.service.FavoriteService;
@Service
public class FavoriteServiceImpl implements FavoriteService{
	
	@Resource
	private FavoriteDao favoriteDao;
	@Override
	public List<Favorite> getAll() {
		
		return favoriteDao.getAll();
	}

	@Override
	public void delete(Integer id) {
		favoriteDao.delete(id);
		
	}

	@Override
	public void add(Favorite favorite) {
		favoriteDao.add(favorite);
	}

	@Override
	public Favorite findbyId(Integer id) {
		
		return favoriteDao.findbyId(id);
	}

	@Override
	public void update(Favorite favorite) {
		favoriteDao.update(favorite);	
	}

	@Override
	public List<Favorite> getAlls(Map<String, Object> param) {
		return favoriteDao.getAlls(param) ;
	}

	@Override
	public int findRows(Integer userId) {
		
		return favoriteDao.findRows(userId) ;
	}

	@Override
	public void deleteByIds(String ids) {
		favoriteDao.deleteByIds(ids);
		
	}


	@Override
	public List<Map<String, Object>> findFavoriteInfo(Map<String, Object> parm) {
		return favoriteDao.findFavoriteInfo(parm);
	}

	@Override
	public Favorite findbyProdcutId(Map<String, Object> param) {
		
		return favoriteDao.findbyProdcutId(param);
	}
	@Override
	public int findFavoriteInfoRows(Map<String, Object> parm){
		return favoriteDao.findFavoriteInfoRows(parm);
	}

}
