package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * 公司账户流水实体类
 * @author Jason-Tang
 *
 */
public class CompanyBalanceLog {
	//公司账户流水id
	private Integer id;
	//公司id
	private Integer companyId;
	//币种
	private String currency;
	//账户金额
	private BigDecimal balance;
	//账户变更
	private BigDecimal balanceChange;
	//变更时间
	private Date changeDate;
	@Override
	public String toString() {
		return "CompanyBalanceLog [id=" + id + ", companyId=" + companyId
				+ ", currency=" + currency + ", balance=" + balance
				+ ", balanceChange=" + balanceChange + ", changeDate="
				+ changeDate + "]";
	}
	public CompanyBalanceLog() {
	}
	public CompanyBalanceLog(Integer id, Integer companyId, String currency,
			BigDecimal balance, BigDecimal balanceChange, Date changeDate) {
		super();
		this.id = id;
		this.companyId = companyId;
		this.currency = currency;
		this.balance = balance;
		this.balanceChange = balanceChange;
		this.changeDate = changeDate;
	}
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
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public BigDecimal getBalance() {
		return balance;
	}
	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}
	public BigDecimal getBalanceChange() {
		return balanceChange;
	}
	public void setBalanceChange(BigDecimal balanceChange) {
		this.balanceChange = balanceChange;
	}
	public Date getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}
	
}
