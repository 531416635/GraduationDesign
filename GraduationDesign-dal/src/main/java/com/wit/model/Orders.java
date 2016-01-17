package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * 订单
 * 
 * @author Administrator
 * 
 */
public class Orders {
	private Integer id;
	private Date orderTime;// 订单时间
	private Integer status;// 订单状态
	private String orderId;// 订单编号
	private Integer userId;// 用户ID
	private Integer companyProductId;
	private Integer quantity;// 数量
	private String productUnit;// 数量单位
	private BigDecimal unitPrice;// 单价
	private BigDecimal totolAmount;// 总价
	private BigDecimal earnestAmount;// 定金
	private Date deliveryDate;// 交货期
	private Date validUntil;// 有效期至
	private int orderType;// 订单类型
	private List<Integer> orderStatus; // 订单状态统计
	private String productName;// 关联产品表

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getProductUnit() {
		return productUnit;
	}

	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public Date getValidUntil() {
		return validUntil;
	}

	public void setValidUntil(Date validUntil) {
		this.validUntil = validUntil;
	}

	public int getOrderType() {
		return orderType;
	}

	public void setOrderType(int orderType) {
		this.orderType = orderType;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Orders [id=" + id + ", orderTime=" + orderTime + ", status="
				+ status + ", orderId=" + orderId + ", userId=" + userId + "]";
	}

	public Integer getCompanyProductId() {
		return companyProductId;
	}

	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}

	public BigDecimal getTotolAmount() {
		return totolAmount;
	}

	public void setTotolAmount(BigDecimal totolAmount) {
		this.totolAmount = totolAmount;
	}

	public BigDecimal getEarnestAmount() {
		return earnestAmount;
	}

	public void setEarnestAmount(BigDecimal earnestAmount) {
		this.earnestAmount = earnestAmount;
	}

	public List<Integer> getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(List<Integer> orderStatus) {
		this.orderStatus = orderStatus;
	}

}
