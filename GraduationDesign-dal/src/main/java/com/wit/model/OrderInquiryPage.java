package com.wit.model;
import java.sql.Date;

public class OrderInquiryPage extends Page{
	private Integer orderId;
	private String userName;
	private String productName;
	private Date startOrderTime;
	private Date endOrderTime;
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	@Override
	public String toString() {
		return "OrderInquiryPage [orderId=" + orderId + ", userName="
				+ userName + ", productName=" + productName
				+ ", startOrderTime=" + startOrderTime + ", endOrderTime="
				+ endOrderTime + "]";
	}
	
	
	
	
}
