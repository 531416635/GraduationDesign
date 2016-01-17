package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;
/**
 * 询价单
 * @author Administrator
 *
 */
public class InquirySheet {
	private Integer id;//ID
	private Integer userId;//用户ID
	private String inquiryId;//询价单编号
	private String currency;//币种
	private Integer deliveryType;//交易方式
	private Integer productModel;//产品型号
	private Integer productID;//产品编号
	private BigDecimal  productQuantity;//产品数量
	private String productUnit;//数量单位
	private BigDecimal refPrice;//参考单价
	private BigDecimal expectPrice;//期望单价
	private Date expectTime;//期望交期
	private Date orderTime;//订单时间
	private Integer status;//状态 
	private Users users;
	private String address;
	private String productName;//产品编号
	private Date inquiryTimeStart;
	private Date inquiryTimeStop;
	
	public Date getInquiryTimeStart() {
		return inquiryTimeStart;
	}
	public void setInquiryTimeStart(Date inquiryTimeStart) {
		this.inquiryTimeStart = inquiryTimeStart;
	}
	public Date getInquiryTimeStop() {
		return inquiryTimeStop;
	}
	public void setInquiryTimeStop(Date inquiryTimeStop) {
		this.inquiryTimeStop = inquiryTimeStop;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	
	@Override
	public String toString() {
		return "InquirySheet [id=" + id + ", userId=" + userId + ", inquiryId="
				+ inquiryId + ", currency=" + currency + ", deliveryType="
				+ deliveryType + ", productModel=" + productModel
				+ ", productID=" + productID + ", productQuantity="
				+ productQuantity + ", productUnit=" + productUnit
				+ ", refPrice=" + refPrice + ", expectPrice=" + expectPrice
				+ ", expectTime=" + expectTime + ", orderTime=" + orderTime
				+ ", status=" + status + ", users=" + users + ", address="
				+ address + ", productName=" + productName
				+ ", inquiryTimeStart=" + inquiryTimeStart
				+ ", inquiryTimeStop=" + inquiryTimeStop + "]";
	}
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
	public String getInquiryId() {
		return inquiryId;
	}
	public void setInquiryId(String inquiryId) {
		this.inquiryId = inquiryId;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public Integer getDeliveryType() {
		return deliveryType;
	}
	public void setDeliveryType(Integer deliveryType) {
		this.deliveryType = deliveryType;
	}
	public Integer getProductModel() {
		return productModel;
	}
	public void setProductModel(Integer productModel) {
		this.productModel = productModel;
	}

	public BigDecimal getProductQuantity() {
		return productQuantity;
	}
	public void setProductQuantity(BigDecimal productQuantity) {
		this.productQuantity = productQuantity;
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
	public Date getExpectTime() {
		return expectTime;
	}
	public void setExpectTime(Date expectTime) {
		this.expectTime = expectTime;
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
	public Integer getProductID() {
		return productID;
	}
	public void setProductID(Integer productID) {
		this.productID = productID;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	
	
	
	
}
