package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

//发票
public class Invoice {
	private Integer id;
	private String invoiceId;
	private Integer invoiceType;
	private String invoiceTitle; //发票抬头
	private BigDecimal amount;
	private Date createTime;
	private Integer companyId;
	//private String companyName;
	private Integer status;
	private Integer statementId;
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Invoice [id=" + id + ", invoiceId=" + invoiceId
				+ ", invoiceType=" + invoiceType + ", invoiceTitle="
				+ invoiceTitle + ", amount=" + amount + ", createTime="
				+ createTime + ", companyId=" + companyId + ", status="
				+ status + ", statementId=" + statementId + "]";
	}
	public Integer getStatementId() {
		return statementId;
	}
	public void setStatementId(Integer statementId) {
		this.statementId = statementId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getInvoiceId() {
		return invoiceId;
	}
	public void setInvoiceId(String invoiceId) {
		this.invoiceId = invoiceId;
	}
	public Integer getInvoiceType() {
		return invoiceType;
	}
	public void setInvoiceType(Integer invoiceType) {
		this.invoiceType = invoiceType;
	}
	public String getInvoiceTitle() {
		return invoiceTitle;
	}
	public void setInvoiceTitle(String invoiceTitle) {
		this.invoiceTitle = invoiceTitle;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	
	

}
