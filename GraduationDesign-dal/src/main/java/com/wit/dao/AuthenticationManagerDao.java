package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.AuthenticationManager;

/**
 * 与电子档相关的数据层访问
 * @author tangxiaoqing
 *
 */
public interface AuthenticationManagerDao {
	//查询所有
	List<AuthenticationManager> findAll();
	
	//根据公司ID查找
	List<AuthenticationManager> findByCompanyId(Map<String,Object> parm); 
	
	//修改
	void update(AuthenticationManager authenticationManager);
	
	//删除
	void delete(Integer id);
	
	//增加
	void insert(AuthenticationManager authenticationManager);
	
	//根据ID查找
	AuthenticationManager findById(Integer id);
	
	//认证信息分行
	int rows(Integer companyId);
	
	//根据ID字符数组删除数据
	void deleteByIds(String ids);
	
	//商户认证
	void merchantAuthentication(@Param (value="tmpCompanyId") Integer tmpCompanyId);

}
