package com.wit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.GrossMarginDao;
import com.wit.model.GrossMargin;
import com.wit.service.GrossMarginService;
@Service
public class GrossMarginServiceImpl implements GrossMarginService{
	@Resource
	private GrossMarginDao grossMarginDao;
	@Override
	public List<GrossMargin> findGrossMargin() {
		
		return grossMarginDao.findGrossMargin();
	}

	@Override
	public void deleteGrossMargin(Integer id) {
		grossMarginDao.deleteGrossMargin(id);
		
	}

	@Override
	public void addGrossMarginr(GrossMargin grossMargin) {
		grossMarginDao.addGrossMarginr(grossMargin);
		
	}

	@Override
	public GrossMargin findbyId(GrossMargin id) {
		
		return grossMarginDao.findbyId(id);
	}

	@Override
	public void updateGrossMargin(GrossMargin grossMargin) {
		grossMarginDao.updateGrossMargin(grossMargin);
		
	}

	@Override
	public void deleteByIds(String ids) {
		grossMarginDao.deleteByIds(ids);
		
	}

}
