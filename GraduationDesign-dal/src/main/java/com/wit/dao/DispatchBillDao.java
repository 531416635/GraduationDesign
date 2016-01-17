package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.DispatchBill;
import com.wit.model.Page;

/**
 * 
 * @author ljj
 * time: 2013-3-22
 *
 */
public interface DispatchBillDao {
	//查询数据
	List<DispatchBill> findAll(Page page);
	//删除数据
	void deleteById(Integer id);
	//增加数据
	int insertData(DispatchBill db);
	//修改数据
	void updateById(DispatchBill db);
	//通过id查找数据
	DispatchBill findById(Integer id);
	//查询订单所有ID
	List<Integer> findOrdersId();
	//根据订单Id查询配送单
	List<DispatchBill> findOrderId(String orderId);
	//查询仓储所有ID
	List<Integer> findStorageId();
	int findRows();
	//根据公司ID显示所有配送单(微信端)
	List<DispatchBill> findBillByCompanyId(Map<String, Object> parm);
	//根据公司ID查询配送单条数(微信端)
			Integer findBillRowByCompanyId(Map<String,Object> parm);
	
	//根据用户ID显示其所有发货单
	List<DispatchBill> getAll(Map<String,Object> parm);
	
	//根据用户ID分行
	int rows(Integer userId);
	
	//门户根据用户ID展示验收结算信息
	List<Map<String,Object>> dispatchBillInfo(Integer userId);
	
	//修改配送状态
/*	void updateDispatchBillStatus(String ids);
	*/
	int getMyDispatchBillrows(Map<String, Object> parm);
	
	void updatePackagesNumber(@Param(value = "id")  String id, @Param(value = "num")  String num);
	
	void updateDispatchBillStatus(@Param(value = "ids") String ids,@Param(value = "status")  String status);
	
	void updateDispatchBillUser(Map<String, Object> parm);
	
	//统计采购业务发货单状态为未验收数量
	int purchaserCheckNum(Integer accepter);
	
	//统计供应业务发货单状态为未验收数量
	int supplierCheckNum(Integer deliveryUser);
}
