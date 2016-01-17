package com.wit.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
public class CompanyBalanceStatement {
private Integer id;//资金对账单ID
private Integer companyId;//公司ID
private Timestamp startTime;//开始时间
private Timestamp endTime;//结束时间
private BigDecimal amount;//金额
private String currency;//币种
private BigDecimal settledAmount;//已结算金额
private Integer stateType;
public Integer getStateType() {
	return stateType;
}
public void setStateType(Integer stateType) {
	this.stateType = stateType;
}
public BigDecimal getSettledAmount() {
	return settledAmount;
}
public void setSettledAmount(BigDecimal settledAmount) {
	this.settledAmount = settledAmount;
}
private BigDecimal discount;//折扣
private Integer status;//状态
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public Integer getCompanyId() {
	return companyId;
}
public void setCompanyId(Integer companyId) {
	this.companyId = companyId;
}
public Timestamp getStartTime() {
	return startTime;
}
public void setStartTime(Timestamp startTime) {
	this.startTime = startTime;
}
public Timestamp getEndTime() {
	return endTime;
}
public void setEndTime(Timestamp endTime) {
	this.endTime = endTime;
}
public BigDecimal getAmount() {
	return amount;
}
public void setAmount(BigDecimal amount) {
	this.amount = amount;
}
public String getCurrency() {
	return currency;
}
public void setCurrency(String currency) {
	this.currency = currency;
}
public BigDecimal getDiscount() {
	return discount;
}
public void setDiscount(BigDecimal discount) {
	this.discount = discount;
}
public Integer getStatus() {
	return status;
}
public void setStatus(Integer status) {
	this.status = status;
}
@Override
public String toString() {
	return "CompanyBalanceStatement [id=" + id + ", companyId=" + companyId
			+ ", startTime=" + startTime + ", endTime=" + endTime + ", amount="
			+ amount + ", currency=" + currency + ", discount=" + discount
			+ ", status=" + status + "]";
}

}
