package com.wit.service;

import java.util.Map;

import com.wit.model.PasswordUnlocker;

/**
 * 密码找回  存放验证码
 * @author tangxiaoqing
 *
 */
public interface PasswordUnlockerService {

	 //添加
	 void add(Map<String,Object> parm);
	 
	 //根据用户ID查询验证码信息
	 PasswordUnlocker findByUserId(Integer userId);
}
