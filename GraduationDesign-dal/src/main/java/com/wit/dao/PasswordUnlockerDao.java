package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.PasswordUnlocker;

/**
 * 密码找回
 * @author lj
 *
 */
public interface PasswordUnlockerDao {
	 //查询
	 List<PasswordUnlocker> getAll();
	 //删除数据
	 void delete(Integer id);
	 //添加
	 void add(Map<String,Object> parm);
	 //根据ID查询
	 PasswordUnlocker findbyId (Integer id);
	 //更新
	 void update(PasswordUnlocker passwordUnlocker);
	 
	 //根据用户ID查询最近一条验证码信息
	 PasswordUnlocker findByUserId(Integer userId);
	
	
	
	
}
