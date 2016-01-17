package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.InvoiceDao;
import com.wit.model.Invoice;
import com.wit.model.Page;
import com.wit.service.InvoiceService;

@Service("InvoiceService")
public class InvoiceServiceImpl implements InvoiceService{
    @Resource
	private InvoiceDao invoiceDao;
    
    
    @Override
	public List<Map<String,Object>> findAll(Page page) {
		return invoiceDao.findAll(page);
	}
	
    @Override
	public void deleteById(Integer id) {
    	invoiceDao.deleteById(id);
	}
    
    @Override
   	public void insert(Invoice db) {
       	invoiceDao.insert(db);
   	}
    
    @Override
   	public void update(Invoice db){
       	invoiceDao.update(db);
   	}
    
    @Override
   	public Invoice findById(Integer statementId) {
   		return invoiceDao.findById(statementId);
   	}
    @Override
   	public int findRows() {
   		return invoiceDao.findRows();
   	}

	@Override
	public List<Invoice> getAll(Map<String, Object> parm) {
		return invoiceDao.getAll(parm);
	}

	@Override
	public int rows() {
		return invoiceDao.rows();
	}

	@Override
	public List<Invoice> findByCompanyId(Integer companyId) {
		return invoiceDao.findByCompanyId(companyId);
	}

	@Override
	public void buyerInvoiceApply(Map<String, Object> parm) {
		invoiceDao.buyerInvoiceApply(parm);
		
	}

	@Override
	public void updateInvoiceStatus(Integer tmpStatementId) {
		invoiceDao.updateInvoiceStatus(tmpStatementId);
	}

	@Override
	public void signInvoice(Integer tmpStatementId) {
		invoiceDao.signInvoice(tmpStatementId);
	}

	@Override
	public void addSupplierInvoice(Map<String, Object> parm) {
		invoiceDao.addSupplierInvoice(parm);
	}

	@Override
	public void addTitle(Map<String,Object> parm) {
		invoiceDao.addTitle(parm);
	}
    
}
