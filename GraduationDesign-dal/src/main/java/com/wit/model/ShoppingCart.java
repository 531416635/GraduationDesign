package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;
//购物车
public class ShoppingCart {
	private Integer id;
	private Integer userId;
	private Integer productId;
	private BigDecimal productQuantity;
	private String productUnit;
	private BigDecimal refPrice; //参考单价
	private BigDecimal expectPrice;  //期望单价
	private Date deliveryDate;
	private String address;//
	private String productName;
	private String productCategoryName;
	private int shopType;
	
	public String getProductCategoryName() {
		return productCategoryName;
	}
	public void setProductCategoryName(String productCategoryName) {
		this.productCategoryName = productCategoryName;
	}
	public BigDecimal getProductQuantity() {
		return productQuantity;
	}
	public void setProductQuantity(BigDecimal productQuantity) {
		this.productQuantity = productQuantity;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	private Integer status;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public String getProductUnit() {
		return productUnit;
	}
	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
	}
	public BigDecimal getRefPrice() {
		return refPrice;
	}
	public void setRefPrice(BigDecimal refPrice) {
		this.refPrice = refPrice;
	}
	public BigDecimal getExpectPrice() {
		return expectPrice;
	}
	public void setExpectPrice(BigDecimal expectPrice) {
		this.expectPrice = expectPrice;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
		public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getShopType() {
		return shopType;
	}
	public void setShopType(int shopType) {
		this.shopType = shopType;
	}
	@Override
	public String toString() {
		return "ShoppingCart [id=" + id + ", userId=" + userId + ", productId="
				+ productId + ", productQuantity=" + productQuantity
				+ ", productUnit=" + productUnit + ", refPrice=" + refPrice
				+ ", expectPrice=" + expectPrice + ", deliveryDate="
				+ deliveryDate + ", address=" + address + ", productName="
				+ productName + ", productCategoryName=" + productCategoryName
				+ ", shopType=" + shopType + ", status=" + status + "]";
	}

	

}
