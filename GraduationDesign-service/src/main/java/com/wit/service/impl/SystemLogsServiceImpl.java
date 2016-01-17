package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.SystemLogsDao;
import com.wit.model.Page;
import com.wit.model.SystemLogs;
import com.wit.service.SystemLogsService;

@Service
public class SystemLogsServiceImpl implements
		SystemLogsService {
	@Resource
	private SystemLogsDao systemLogsDao;

	@Override
	public List<SystemLogs> getAll(Page page) {
		return systemLogsDao.getAll(page);
	}

	@Override
	public int findRows() {
		return systemLogsDao.findRows();
	}

	@Override
	public void AddLog(SystemLogs form)
	{
		 systemLogsDao.add(form);
	}
}
