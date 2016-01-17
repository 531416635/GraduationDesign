package com.wit.model;

import java.sql.Date;

public class CompanyBankAccount {
	private Integer id;// 银行账户ID
	private Integer companyId;// 公司ID
	private String bankAccount;// 银行账户
	private String bankAddress;// 开户行地址
	private String bankName;// 银行名称
	private Integer status;// 状态
	private Date createTime;// 创建时间

	public CompanyBankAccount() {
	}

	public CompanyBankAccount(Integer id, Integer companyId,
			String bankAccount, String bankAddress, String bankName,
			Integer status, Date createTime) {
		super();
		this.id = id;
		this.companyId = companyId;
		this.bankAccount = bankAccount;
		this.bankAddress = bankAddress;
		this.bankName = bankName;
		this.status = status;
		this.createTime = createTime;
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

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getBankAddress() {
		return bankAddress;
	}

	public void setBankAddress(String bankAddress) {
		this.bankAddress = bankAddress;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "CompanyBankAccount [id=" + id + ", companyId=" + companyId
				+ ", bankAccount=" + bankAccount + ", bankAddress="
				+ bankAddress + ", bankName=" + bankName + ", status=" + status
				+ ", createTime=" + createTime + "]";
	}
}
