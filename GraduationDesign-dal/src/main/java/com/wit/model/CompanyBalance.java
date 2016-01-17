package com.wit.model;
import java.math.BigDecimal;
/**
 * 公司资金账户实体类
 * @author Jason-Tang
 *
 */
public class CompanyBalance {
	//公司资金账户id
	private Integer id;
	//公司id
	private Integer companyId;
	//币种
	private String currency;
	//账户金额
	private BigDecimal balance;
	//账户状态
	private Integer status;
	//关联公司
	private Companys companys;
	
	public Companys getCompanys() {
		return companys;
	}
	public void setCompanys(Companys companys) {
		this.companys = companys;
	}
	@Override
	public String toString() {
		return "id=" + id + ", companyId=" + companyId
				+ ", currency=" + currency + ", balance=" + balance
				+ ", status=" + status;
	}
	public CompanyBalance() {
	}
	public CompanyBalance(Integer id, Integer companyId, String currency,
			BigDecimal balance, Integer status) {
		super();
		this.id = id;
		this.companyId = companyId;
		this.currency = currency;
		this.balance = balance;
		this.status = status;
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
