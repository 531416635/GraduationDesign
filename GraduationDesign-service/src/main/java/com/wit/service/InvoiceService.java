package com.wit.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.Invoice;
import com.wit.model.Page;

public interface InvoiceService {
	    //查询数据
		List<Map<String,Object>> findAll(Page page);
		//删除数据
		void deleteById(Integer id);
		//增加数据
		void insert(Invoice db);
		//修改数据
		void update(Invoice db);
		//通过id查找数据
		Invoice findById(Integer statementId);
		
		int findRows();

		//根据用户ID显示其发票信息
		List<Invoice> getAll(Map<String,Object> parm);
		
		//发票信息行数
		int rows();
		
		//根据公司ID查询发票信息
		List<Invoice> findByCompanyId(Integer companyId);
		
		//采购商发票申请
		void buyerInvoiceApply(Map<String,Object> parm);
		
		//修改发票状态为寄出
		void updateInvoiceStatus(Integer tmpStatementId);

		//采购商签收发票
		void signInvoice(Integer tmpStatementId);
		
		//平台向供应商申请发票
		void addSupplierInvoice(Map<String,Object> parm);
		
		//添加公司发票抬头
		void addTitle(Map<String,Object> parm);
}
