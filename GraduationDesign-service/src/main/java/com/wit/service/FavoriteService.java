package com.wit.service;

import java.util.List;
import java.util.Map;

import com.wit.model.Favorite;

public interface FavoriteService {
		//查询
		List<Favorite>getAll();
		//根据userID查询
		List<Favorite>getAlls(Map<String, Object> param);
		//删除数据
		void delete(Integer id);
		//添加
		void add(Favorite favorite);
		//根据ID查询
		Favorite findbyId (Integer id);
		//根据ProductID查询
		Favorite findbyProdcutId (Map<String, Object> param);
		//更新
		void update(Favorite favorite);

		int findRows(Integer userId);
		//根据ID字符数组删除数据
		void deleteByIds(String ids);
		
		//根据用户ID查看商品收藏
		List<Map<String,Object>> findFavoriteInfo(Map<String, Object> parm);
		int findFavoriteInfoRows(Map<String, Object> parm);
}