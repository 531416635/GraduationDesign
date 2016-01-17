package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * 商品小样实体类
 * @author Administrator
 *
 */
public class ProductSample {
	private Integer id;//ID
	private Integer supplierId;//供应商ID
	private Integer companyProductId;//申请人ID
	
	private Integer status;//状态
	private Date requestTime;//申请时间
	private BigDecimal requestNum;//申请数量
	private String requestUnit;//申请单位
	
	
	
	
	@Override
	public String toString() {
		return "ProductSample [id=" + id + ", supplierId=" + supplierId
				+ ", companyProductId=" + companyProductId + ", status=" + status
				+ ", requestTime=" + requestTime + ", requestNum=" + requestNum
				+ ", requestUnit=" + requestUnit + "]";
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	
	
	
	

	public Integer getCompanyProductId() {
		return companyProductId;
	}

	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}

	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getRequestTime() {
		return requestTime;
	}
	public void setRequestTime(Date requestTime) {
		this.requestTime = requestTime;
	}
	public BigDecimal getRequestNum() {
		return requestNum;
	}
	public void setRequestNum(BigDecimal requestNum) {
		this.requestNum = requestNum;
	}
	public String getRequestUnit() {
		return requestUnit;
	}
	public void setRequestUnit(String requestUnit) {
		this.requestUnit = requestUnit;
	}
	
	
}
