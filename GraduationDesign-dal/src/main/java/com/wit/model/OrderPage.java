package com.wit.model;

import java.sql.Date;

public class OrderPage extends Page{
	
	private String orderId;
	private String productName;
	private Date orderTimeStart;
	private Date orderTimeStop;
	private Integer orderStatus;
	private Integer orderType;
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Date getOrderTimeStart() {
		return orderTimeStart;
	}
	public void setOrderTimeStart(Date orderTimeStart) {
		this.orderTimeStart = orderTimeStart;
	}
	public Date getOrderTimeStop() {
		return orderTimeStop;
	}
	public void setOrderTimeStop(Date orderTimeStop) {
		this.orderTimeStop = orderTimeStop;
	}
	public Integer getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Integer getOrderType() {
		return orderType;
	}
	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}
	@Override
	public String toString() {
		return "OrderPage [orderId=" + orderId + ", productName=" + productName
				+ ", orderTimeStart=" + orderTimeStart + ", orderTimeStop="
				+ orderTimeStop + ", orderStatus=" + orderStatus
				+ ", orderType=" + orderType + "]";
	}
	
	
}
