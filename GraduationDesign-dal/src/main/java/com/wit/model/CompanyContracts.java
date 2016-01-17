package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * 供应商合同实体类
 * @author Jason-Tang
 *
 */
public class CompanyContracts {
	//供应商合同id
	private Integer id;
	//公司id
	private Integer companyId;
	//合同起始时间
	private Date contractTime;
	//合同截止时间
	private Date contractExpirationTime;
	
	//合同账期
	private String contractTerms;
	//供应品类
	private String supplyCategory;
	//合同内容
	private String contractContent;
	//合同状态
	private Integer status;
	//合同类型
	private Integer contractType;
	//单笔定金
	private BigDecimal earnest;
	
	
	public Date getContractTime() {
		return contractTime;
	}
	public void setContractTime(Date contractTime) {
		this.contractTime = contractTime;
	}
	public Date getContractExpirationTime() {
		return contractExpirationTime;
	}
	public void setContractExpirationTime(Date contractExpirationTime) {
		this.contractExpirationTime = contractExpirationTime;
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
	
	public String getContractTerms() {
		return contractTerms;
	}
	public void setContractTerms(String contractTerms) {
		this.contractTerms = contractTerms;
	}
	public String getSupplyCategory() {
		return supplyCategory;
	}
	public void setSupplyCategory(String supplyCategory) {
		this.supplyCategory = supplyCategory;
	}
	public String getContractContent() {
		return contractContent;
	}
	public void setContractContent(String contractContent) {
		this.contractContent = contractContent;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getContractType() {
		return contractType;
	}
	public void setContractType(Integer contractType) {
		this.contractType = contractType;
	}
	public BigDecimal getEarnest() {
		return earnest;
	}
	public void setEarnest(BigDecimal earnest) {
		this.earnest = earnest;
	}
	
	
}
