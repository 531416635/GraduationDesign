package com.wit.model;
import java.sql.Date;

public class MyOrderPage extends Page{
	private Integer orderId;
	private String companyName;
	private String productName;
	private Date startOrderTime;
	private Date endOrderTime;
	private Integer status;
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Date getStartOrderTime() {
		return startOrderTime;
	}
	public void setStartOrderTime(Date startOrderTime) {
		this.startOrderTime = startOrderTime;
	}
	public Date getEndOrderTime() {
		return endOrderTime;
	}
	public void setEndOrderTime(Date endOrderTime) {
		this.endOrderTime = endOrderTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "MyOrderPage [orderId=" + orderId + ", companyName="
				+ companyName + ", productName=" + productName
				+ ", startOrderTime=" + startOrderTime + ", endOrderTime="
				+ endOrderTime + ", status=" + status + "]";
	}
	
	
}
