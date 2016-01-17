package com.wit.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Page;
import com.wit.model.Settlement;

public interface SettlementDao {
		//查询供应商结算信息
		List<Map<String,Object>>  findSupplierSettlement(Page page);
		//查询采购商
		List<Map<String,Object>>  findBuyerSettlement(Page page);
		//删除结算信息
		void deleteSettlement(Integer id);
		//增加结算信息
		void addSettlement(Settlement settlement);
		//根据Id查询结算信息
		Settlement findbyId(Integer id);
		//更新结算信息
		void updateSettlement(Settlement settlement);
		//查询供应商行数
		int supplierRows();
		//查询采购商行数
		int buyerRows();
		//修改状态为发起结算
		void updateStatus(String settlementId);
		
		//往期账单信息展示 
		List<Map<String,Object>> pastAccountInfo(Integer companyId);
		List<Map<String,Object>> pastAccountInfo2(@Param(value="companyId")Integer companyId, @Param(value="sqlDateStart")Date sqlDateStart,@Param(value="sqlDateEnd") Date sqlDateEnd);
		
		//查询结算单信息
		List<Map<String,Object>> findSettlementInfo(Map<String, Object> parm);
		
		List<Map<String,Object>> findWeChatSettlementInfo(Map<String, Object> parm); //微信端查询结算单
		
		Integer findWeChatSettlementInfoRow(Map<String, Object> parm);//微信端查询结算单总条数
		
		//结算单信息行数
		int rows (Integer companyId);
		
		//查询往期结算单信息行数
		int pastRows(Map<String,Object> parm);
}
