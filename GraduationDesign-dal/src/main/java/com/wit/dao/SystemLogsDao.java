package com.wit.dao;

import java.util.List;


import com.wit.model.Page;
import com.wit.model.SystemLogs;

/**
 * 系统日志
 * @author Administrator
 *
 */

public interface SystemLogsDao {
	//查询
	List<SystemLogs> getAll(Page page);
	//删除数据
	void delete(Integer id);
	//添加
	void add(SystemLogs systemLogs);
	//根据ID查询
	SystemLogs findbyId (Integer id);
	//更新
	void update(SystemLogs systemLogs);
	
	int findRows();
}
