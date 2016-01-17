package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.GrouponDao;
import com.wit.model.Groupon;
import com.wit.model.Page;
import com.wit.service.GrouponService;

@Service
public class GrouponServiceImpl implements GrouponService {

	@Resource
	private GrouponDao grouponDao;

	// 团购商品显示
	@Override
	public List<Map<String, Object>> findGroupon(Map<String, Object> parm) {
		return grouponDao.findGroupon(parm);

	}

	// 更新团购状态
	@Override
	public void checkStatus(Groupon groupon) {
		// TODO Auto-generated method stub
		grouponDao.checkStatus(groupon);
	}

	// 通过productId查找数据
	@Override
	public Groupon findByProductId(Integer productId) {
		// TODO Auto-generated method stub
		return grouponDao.findByProductId(productId);
	}

	// 增加数据
	@Override
	public void insert(Groupon db) {
		// TODO Auto-generated method stub
		grouponDao.insert(db);
	}

	// 查询数据
	public List<Groupon> findAll(Map<String, Object> parm) {
		return grouponDao.findAll(parm);
	}

	@Override
	public int findRows(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return grouponDao.findRows(parm);
	}

	// 通过id查找数据
	@Override
	public List<Map<String, Object>> findById(Integer id) {
		return grouponDao.findById(id);
	}

	// 删除数据
	@Override
	public void deleteById(Integer id) {
		grouponDao.deleteById(id);
	}

	// 根据ID字符数组删除数据
	@Override
	public void deleteByIds(String ids) {
		grouponDao.deleteByIds(ids);
	}
	
	// 修改数据
	@Override
	public void update(Groupon db){
		grouponDao.update(db);
	}
	//更新售出数量
	@Override
	public void addSoldOut(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		grouponDao.addSoldOut(parm);
	}
	
	// 团购热销商品显示
	@Override
	public List<Map<String, Object>> findGrouponHot(Map<String, Object> parm1) {
		// TODO Auto-generated method stub
		return grouponDao.findGrouponHot(parm1);
	}
}
