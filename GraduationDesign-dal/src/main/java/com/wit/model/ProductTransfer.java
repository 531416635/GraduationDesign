package com.wit.model;

import java.sql.Date;

/**
 * 商品追溯实体类
 * @author Jason-Tang
 *
 */
public class ProductTransfer {
	//商品追溯id
	private Integer id;
	//供应商商品id
	private Integer companyProductId;
	//中转地
	private String transitShipment;
	//联系人
	private String linkMan;
	//联系电话
	private String linkTel;
	//到达时间
	private Date arrivalTime;
	//批次
	private String batch;
	@Override
	public String toString() {
		return "ProductTransfer [id=" + id + ", companyProductId="
				+ companyProductId + ", transitShipment=" + transitShipment
				+ ", linkMan=" + linkMan + ", linkTel=" + linkTel
				+ ", arrivalTime=" + arrivalTime + ", batch=" + batch + "]";
	}
	public ProductTransfer() {
	}
	public ProductTransfer(Integer id, Integer companyProductId,
			String transitShipment, String linkMan, String linkTel,
			Date arrivalTime, String batch) {
		super();
		this.id = id;
		this.companyProductId = companyProductId;
		this.transitShipment = transitShipment;
		this.linkMan = linkMan;
		this.linkTel = linkTel;
		this.arrivalTime = arrivalTime;
		this.batch = batch;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCompanyProductId() {
		return companyProductId;
	}
	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}
	public String getTransitShipment() {
		return transitShipment;
	}
	public void setTransitShipment(String transitShipment) {
		this.transitShipment = transitShipment;
	}
	public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	public String getLinkTel() {
		return linkTel;
	}
	public void setLinkTel(String linkTel) {
		this.linkTel = linkTel;
	}
	public Date getArrivalTime() {
		return arrivalTime;
	}
	public void setArrivalTime(Date arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	public String getBatch() {
		return batch;
	}
	public void setBatch(String batch) {
		this.batch = batch;
	}
	
}
