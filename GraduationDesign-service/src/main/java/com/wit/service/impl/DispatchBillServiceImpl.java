package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.DispatchBillDao;
import com.wit.model.DispatchBill;
import com.wit.model.Page;
import com.wit.service.DispatchBillService;

@Service("dispatchBillService")
public class DispatchBillServiceImpl implements DispatchBillService{
    @Resource
	private DispatchBillDao dispatchBill;
    
    
    @Override
	public List<DispatchBill> findAll(Page page) {
		return dispatchBill.findAll(page);
	}
	
    @Override
	public void deleteById(Integer id) {
    	dispatchBill.deleteById(id);
	}
    
    @Override
   	public int insertData(DispatchBill db) {
       	return dispatchBill.insertData(db);
   	}
    
    @Override
   	public void updateById(DispatchBill db){
       	dispatchBill.updateById(db);
   	}
    
    @Override
   	public DispatchBill findById(Integer id) {
   		return dispatchBill.findById(id);
   	}
    @Override
   	public int findRows() {
   		return dispatchBill.findRows();
   	}
    
    @Override
   	public List<Integer> findOrdersId() {
   		return dispatchBill.findOrdersId();
   	}
    @Override
   	public List<Integer> findStorageId() {
   		return dispatchBill.findStorageId();
   	}

	@Override
	public List<DispatchBill> getAll(Map<String, Object> parm) {
		return dispatchBill.getAll(parm);
	}

	@Override
	public int rows(Integer userId) {
		return dispatchBill.rows(userId);
	}

	@Override
	public List<Map<String, Object>> dispatchBillInfo(Integer userId) {
		return dispatchBill.dispatchBillInfo(userId);
	}

/*	@Override
	public void updateDispatchBillStatus(String ids) {
		dispatchBill.updateDispatchBillStatus(ids);
	}*/
	@Override
	public int getMyDispatchBillrows(Map<String, Object> parm)
	{
		return dispatchBill.getMyDispatchBillrows(parm);
	}
	@Override
	public void updatePackagesNumber(String id, String num)	{
		 dispatchBill.updatePackagesNumber(id,num);
	}
	@Override
	public void updateDispatchBillUser(Map<String, Object> parm){
		 dispatchBill.updateDispatchBillUser(parm);
	}
	@Override
	public void updateDispatchBillStatus(String ids, String status)
	{
		 dispatchBill.updateDispatchBillStatus( ids,  status);		
	}

	@Override
	public List<DispatchBill> findOrderId(String orderId) {
		
		return dispatchBill.findOrderId(orderId);
	}

	@Override
	public int purchaserCheckNum(Integer accepter) {
		return dispatchBill.purchaserCheckNum(accepter);
	}

	@Override
	public int supplierCheckNum(Integer deliveryUser) {
		return dispatchBill.supplierCheckNum(deliveryUser);
	}

	@Override
	public List<DispatchBill> findBillByCompanyId(Map<String,Object> parm) {
		return dispatchBill.findBillByCompanyId(parm);
	}

	@Override
	public Integer findBillRowByCompanyId(Map<String, Object> parm) {		
		return dispatchBill.findBillRowByCompanyId(parm);
	}
}
