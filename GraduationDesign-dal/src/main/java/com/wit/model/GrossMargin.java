package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * 毛利实体类
 * @author Jason-Tang
 *
 */
public class GrossMargin {
	//毛利id
	private Integer id;
	//毛利
	private BigDecimal grossMargin;
	//商品id
	private Integer productId;
	//供应商id
	private Integer supplierId;
	//起始时间
	private Date startTime;
	//结束时间
	private Date endTime;
	//状态
	private Integer status;
	//操作人
	private Integer createBy;
	@Override
	public String toString() {
		return "GrossMargin [id=" + id + ", grossMargin=" + grossMargin
				+ ", productId=" + productId + ", supplierId=" + supplierId
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", status=" + status + ", createBy=" + createBy + "]";
	}
	public GrossMargin() {
	}
	public GrossMargin(Integer id, BigDecimal grossMargin, Integer productId,
			Integer supplierId, Date startTime, Date endTime, Integer status,
			Integer createBy) {
		super();
		this.id = id;
		this.grossMargin = grossMargin;
		this.productId = productId;
		this.supplierId = supplierId;
		this.startTime = startTime;
		this.endTime = endTime;
		this.status = status;
		this.createBy = createBy;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public BigDecimal getGrossMargin() {
		return grossMargin;
	}
	public void setGrossMargin(BigDecimal grossMargin) {
		this.grossMargin = grossMargin;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getCreateBy() {
		return createBy;
	}
	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}
	
}
