package com.wit.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.AuthenticationManager;

public interface AuthenticationManagerService {

	// 查询所有
	List<AuthenticationManager> findAll();

	// 根据公司IDs查找所有
	List<AuthenticationManager> findByCompanyId(Map<String,Object> parm);

	// 根据ID查找
	AuthenticationManager findById(Integer id);
	
	// 修改
	void update(AuthenticationManager authenticationManager);

	// 删除
	void delete(Integer id);

	// 增加
	void insert(AuthenticationManager authenticationManager);
	
	//认证信息分行
	int rows(Integer companyId);
	
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//商户认证
	void merchantAuthentication(Integer tmpCompanyId);
}
