package com.wit.service.impl;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wit.dao.SettlementDao;
import com.wit.model.Page;
import com.wit.model.Settlement;
import com.wit.service.SettlementService;

@Service("SettlementService")
public class SettlementServiceImpl implements SettlementService{
	
	@Autowired
	private SettlementDao dao;
	public SettlementDao getDao() {
		return dao;
	}
	public void setDao(SettlementDao dao) {
		this.dao = dao;
	}
	@Override
	public List<Map<String, Object>> findBuyerSettlement(Page page) {
		return dao.findBuyerSettlement(page);
	}
	@Override
	public void deleteSettlement(Integer id) {
		dao.deleteSettlement(id);
	}
	@Override
	public void addSettlement(Settlement settlement) {
		dao.addSettlement(settlement);
	}
	@Override
	public Settlement findbyId(Integer id) {
		return dao.findbyId(id);
	}
	@Override
	public void updateSettlement(Settlement settlement) {
		dao.updateSettlement(settlement);
	}
	@Override
	public List<Map<String, Object>> findSupplierSettlement(Page page) {
		return dao.findSupplierSettlement(page);
	}
	@Override
	public int supplierRows() {
		return dao.supplierRows();
	}
	@Override
	public int buyerRows() {
		return dao.buyerRows();
	}
	@Override
	public void updateStatus(String settlementId) {
		dao.updateStatus(settlementId);
		
	}
	@Override
	public List<Map<String, Object>> pastAccountInfo(Integer companyId) {
		return dao.pastAccountInfo(companyId);
	}
	public List<Map<String, Object>> pastAccountInfo2(Integer companyId, Date sqlDateStart, Date sqlDateEnd) {
		return dao.pastAccountInfo2(companyId,sqlDateStart,sqlDateEnd);
	}
	@Override
	public List<Map<String, Object>> findSettlementInfo(Map<String, Object> parm) {
		return dao.findSettlementInfo(parm);
	}
	@Override
	public int rows(Integer companyId) {
		return dao.rows(companyId);
	}
	@Override
	public List<Map<String, Object>> findWeChatSettlementInfo(
			Map<String, Object> parm) {	
		return dao.findWeChatSettlementInfo(parm);
	}
	@Override
	public Integer findWeChatSettlementInfoRow(Map<String, Object> parm) {
		
		return dao.findWeChatSettlementInfoRow(parm);
	}
	@Override
	public int pastRows(Map<String, Object> parm) {
		return dao.pastRows(parm);
	}


}
