package com.wit.service;

import java.util.List;

import com.wit.model.Page;
import com.wit.model.SystemLogs;


/**
 * 系统日志
 * @author Administrator
 *
 */
public interface SystemLogsService {
	//查找
	List<SystemLogs> getAll(Page page);
	
	int findRows();

	void AddLog(SystemLogs form);
}
