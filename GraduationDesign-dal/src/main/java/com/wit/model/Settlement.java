package com.wit.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
/**
 * 
 * @author ljj
 * time: 2013-3-22
 *
 */

public class Settlement implements Serializable{
	
private static final long serialVersionUID = 1L;
private Integer id;//结算ID
private String settlementId;//结算编号
private String currency;//结算币种
private BigDecimal settleAmount;//结算金额
private BigDecimal settleFee;//结算手续费
private Integer settleBy;//结算人
private Date settleTime;//结算时间
private Integer status;//结算状态
private Integer bankAccountId;//银行账户ID
private Integer settleType;//结算类型
private Integer isInvoice;//是否开具过发票
private String bankAccount;
private Integer companyId;

public Integer getCompanyId() {
	return companyId;
}

public void setCompanyId(Integer companyId) {
	this.companyId = companyId;
}

public String getBankAccount() {
	return bankAccount;
}

public void setBankAccount(String bankAccount) {
	this.bankAccount = bankAccount;
}

public Integer getId() {
	return id;
}

public void setId(Integer id) {
	this.id = id;
}

public String getSettlementId() {
	return settlementId;
}

public void setSettlementId(String settlementId) {
	this.settlementId = settlementId;
}

public String getCurrency() {
	return currency;
}

public void setCurrency(String currency) {
	this.currency = currency;
}

public BigDecimal getSettleAmount() {
	return settleAmount;
}

public void setSettleAmount(BigDecimal settleAmount) {
	this.settleAmount = settleAmount;
}

public BigDecimal getSettleFee() {
	return settleFee;
}

public void setSettleFee(BigDecimal settleFee) {
	this.settleFee = settleFee;
}

public Integer getSettleBy() {
	return settleBy;
}

public void setSettleBy(Integer settleBy) {
	this.settleBy = settleBy;
}



public Date getSettleTime() {
	return settleTime;
}

public void setSettleTime(Date settleTime) {
	this.settleTime = settleTime;
}

public static long getSerialversionuid() {
	return serialVersionUID;
}

public Integer getStatus() {
	return status;
}

public void setStatus(Integer status) {
	this.status = status;
}

public Integer getBankAccountId() {
	return bankAccountId;
}

public void setBankAccountId(Integer bankAccountId) {
	this.bankAccountId = bankAccountId;
}

public Integer getSettleType() {
	return settleType;
}

public void setSettleType(Integer settleType) {
	this.settleType = settleType;
}

public Integer getIsInvoice() {
	return isInvoice;
}

public void setIsInvoice(Integer isInvoice) {
	this.isInvoice = isInvoice;
}

@Override
public String toString() {
	return "Settlement [id=" + id + ", settlementId=" + settlementId
			+ ", currency=" + currency + ", settleAmount=" + settleAmount
			+ ", settleFee=" + settleFee + ", settleBy=" + settleBy
			+ ", settleTime=" + settleTime + ", status=" + status
			+ ", bankAccountId=" + bankAccountId + ", settleType=" + settleType
			+ ", isInvoice=" + isInvoice + "]";
}

}
