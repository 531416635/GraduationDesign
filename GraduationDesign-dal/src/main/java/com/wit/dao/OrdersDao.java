package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.Orders;
import com.wit.model.Page;

/**
 * 订单
 * 
 * @author lj
 * 
 */
public interface OrdersDao {
	// 查询
	List<Orders> getAll(Page page);

	// 打印查询所有
	List<Orders> getAlljExcel(Integer id);

	// 删除数据
	void delete(Integer id);

	// 添加
	int add(Orders orders);

	Orders getOrderByID(String ids);

	// 根据ID查询
	Orders findbyId(Integer id);

	// 更新
	void update(Orders orders);

	int findRows();

	// 根据用户ID显示三个月前订单信息
	List<Orders> findAll(Map<String, Object> parm);
   
	//查询三个月前订单数量
	int findOldOrderRows(Map<String, Object> parm);
	
	// 根据用户ID分行
	int rows(Integer userId);

	// 根据用户ID显示近三个月订单信息
	List<Orders> findOrderInfo(Map<String, Object> parm);

	// 门户根据用户ID显示近三个月订单信息条数
	int findOrderInfoRows(Map<String, Object> parm);

	Integer findbyOrderId(Integer ids);

	// 订单等待分配地址条数
	int OrderAddressNum(Integer userId);

	// 订单等待发货配送条数
	int OrderSendNum(Integer userId);

	// 微信订单查询
	List<Map<String, Object>> findOrders(Map<String, Object> parm);

	// 微信订单查询分页
	int findRowsOrder(Map<String, Object> parm);

	// 微信订单查询条件改变(查询字段名称)
	List<Map<String, Object>> findOrderInquiry(Map<String, Object> parm);
	
	// 微信订单查询条件改变分页(查询字段名称)
	int findRowsOrderInquiry(Map<String, Object> parm);

}
