package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.OrdersDao;
import com.wit.model.Orders;
import com.wit.model.Page;
import com.wit.service.OrdersService;

//业务层
@Service
public class OrdersServiceImpl implements OrdersService {
	@Resource
	private OrdersDao ordersDao;

	@Override
	public List<Orders> getAll(Page page) {
		return ordersDao.getAll(page);
	}

	@Override
	public void delete(Integer id) {
		ordersDao.delete(id);
	}

	@Override
	public int add(Orders orders) {
		return ordersDao.add(orders);
	}

	@Override
	public Orders getOrderByID(String ids) {
		return ordersDao.getOrderByID(ids);
	}

	@Override
	public Orders findById(Integer id) {
		return ordersDao.findbyId(id);
	}

	@Override
	public Integer findbyOrderId(Integer ids) {
		return ordersDao.findbyOrderId(ids);
	}

	@Override
	public void update(Orders orders) {
		ordersDao.update(orders);
	}

	@Override
	public int findRows() {
		return ordersDao.findRows();
	}

	@Override
	public List<Orders> findAll(Map<String, Object> parm) {
		return ordersDao.findAll(parm);
	}

	@Override
	public int rows(Integer userId) {
		return ordersDao.rows(userId);
	}

	@Override
	public List<Orders> getAlljExcel(Integer id) {

		return ordersDao.getAlljExcel(id);
	}

	@Override
	public List<Orders> findOrderInfo(Map<String, Object> parm) {
		return ordersDao.findOrderInfo(parm);
	}

	@Override
	public int OrderAddressNum(Integer userId) {
		return ordersDao.OrderAddressNum(userId);
	}

	@Override
	public int OrderSendNum(Integer userId) {
		return ordersDao.OrderSendNum(userId);
	}

	@Override
	public int findOrderInfoRows(Map<String, Object> parm) {

		return ordersDao.findOrderInfoRows(parm);
	}

	// 微信订单查询
	@Override
	public List<Map<String, Object>> findOrders(Map<String, Object> parm) {
		return ordersDao.findOrders(parm);
	}

	// 微信订单查询分页
	public int findRowsOrder(Map<String, Object> parm) {
		return ordersDao.findRowsOrder(parm);
	}

	// 微信订单查询条件改变(查询字段名称)
	@Override
	public List<Map<String, Object>> findOrderInquiry(Map<String, Object> parm) {
		return ordersDao.findOrderInquiry(parm);
	}
	
	//微信订单查询条件改变分页(查询字段名称)
		public int findRowsOrderInquiry(Map<String, Object> parm) {
			return ordersDao.findRowsOrderInquiry(parm);
		}

		@Override
		public int findOldOrderRows(Map<String, Object> parm) {
		   return ordersDao.findOldOrderRows(parm);
		}
		
}
