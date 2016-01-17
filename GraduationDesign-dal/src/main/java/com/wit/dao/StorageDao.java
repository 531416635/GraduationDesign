package com.wit.dao;

import java.util.List;

import com.wit.model.Storage;
/**
 * @author ljj
 * time: 2015/3/26
 */

public interface StorageDao {
	       /* //查询数据
			List<Storage> findAll();
			//删除数据
			void deleteById(Integer id);*/
			
			void insert(Storage db); //增加数据
			/*//修改数据
			void update(Storage db);
			//通过id查找数据
			Storage findById(Integer id);*/

}
