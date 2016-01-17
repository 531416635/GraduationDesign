package com.wit.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;


//发货单
public class DispatchBill implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String dispatchBillId;// 发货单号
	private Integer orderId; // 订单ID
	private String orderCode; // 订单ID
	private Integer companyProductId;
	private String ProductName;
	private BigDecimal packagesNumber;// DECIMAL,
	private BigDecimal purchaseQuantity;
	private String productUnit;
	private BigDecimal unitPrice; // 单价
	private BigDecimal amount; // 金额小计
	private Integer storageId; // 仓储ID
	private String storageName;
	private Integer shoppingAddressId;// " INT,
	private String shoppingAddressName;
	private Integer deliveryUser;// " INT,
	private String deliveryUserName;// " INT,
	private Timestamp deliveryTime;// " Timestamp,
	private Integer accepter;// " INT,
	private String accepterUserName;// " INT,
	private Timestamp acceptTime;// " Timestamp,
	private Integer checkUser;// " INT,
	private String checkUserName;// " INT,
	private Timestamp checkTime;// " Timestamp,
	private Timestamp dispatchBillTime;
	private String productPic;
	private String supplierName;
	private String productModel;//商品规格
	
	
	public BigDecimal getPackagesNumber() {
		return packagesNumber;
	}

	public String getProductPic() {
		return productPic;
	}

	public void setProductPic(String productPic) {
		this.productPic = productPic;
	}

	public void setPackagesNumber(BigDecimal packagesNumber) {
		this.packagesNumber = packagesNumber;
	}

	public BigDecimal getPurchaseQuantity() {
		return purchaseQuantity;
	}

	public void setPurchaseQuantity(BigDecimal purchaseQuantity) {
		this.purchaseQuantity = purchaseQuantity;
	}

	public Integer getShoppingAddressId() {
		return shoppingAddressId;
	}

	public void setShoppingAddressId(Integer shoppingAddressId) {
		this.shoppingAddressId = shoppingAddressId;
	}

	public Integer getDeliveryUser() {
		return deliveryUser;
	}

	public void setDeliveryUser(Integer deliveryUser) {
		this.deliveryUser = deliveryUser;
	}

	public Timestamp getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(Timestamp deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public Integer getAccepter() {
		return accepter;
	}

	public void setAccepter(Integer accepter) {
		this.accepter = accepter;
	}

	public Timestamp getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(Timestamp acceptTime) {
		this.acceptTime = acceptTime;
	}

	public Integer getCheckUser() {
		return checkUser;
	}

	public void setCheckUser(Integer checkUser) {
		this.checkUser = checkUser;
	}

	public Timestamp getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Timestamp checkTime) {
		this.checkTime = checkTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	private Integer status;// " INT,

	public String getStorageName() {
		return storageName;
	}

	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDispatchBillId() {
		return dispatchBillId;
	}

	public void setDispatchBillId(String dispatchBillId) {
		this.dispatchBillId = dispatchBillId;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}



	public Integer getCompanyProductId() {
		return companyProductId;
	}

	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}

	public String getProductUnit() {
		return productUnit;
	}

	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
	}

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Integer getStorageId() {
		return storageId;
	}

	public void setStorageId(Integer storageId) {
		this.storageId = storageId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	public Timestamp getDispatchBillTime() {
		return dispatchBillTime;
	}

	public void setDispatchBillTime(Timestamp dispatchBillTime) {
		this.dispatchBillTime = dispatchBillTime;
	}

	public String getProductName() {
		return ProductName;
	}

	public void setProductName(String productName) {
		ProductName = productName;
	}

	public String getShoppingAddressName() {
		return shoppingAddressName;
	}

	public void setShoppingAddressName(String shoppingAddressName) {
		this.shoppingAddressName = shoppingAddressName;
	}

	public String getDeliveryUserName() {
		return deliveryUserName;
	}

	public void setDeliveryUserName(String deliveryUserName) {
		this.deliveryUserName = deliveryUserName;
	}

	public String getCheckUserName() {
		return checkUserName;
	}

	public void setCheckUserName(String checkUserName) {
		this.checkUserName = checkUserName;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getAccepterUserName() {
		return accepterUserName;
	}

	public void setAccepterUserName(String accepterUserName) {
		this.accepterUserName = accepterUserName;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getProductModel() {
		return productModel;
	}

	public void setProductModel(String productModel) {
		this.productModel = productModel;
	}

	@Override
	public String toString() {
		return "DispatchBill [id=" + id + ", dispatchBillId=" + dispatchBillId
				+ ", orderId=" + orderId + ", orderCode=" + orderCode
				+ ", companyProductId=" + companyProductId + ", ProductName="
				+ ProductName + ", packagesNumber=" + packagesNumber
				+ ", purchaseQuantity=" + purchaseQuantity + ", productUnit="
				+ productUnit + ", unitPrice=" + unitPrice + ", amount="
				+ amount + ", storageId=" + storageId + ", storageName="
				+ storageName + ", shoppingAddressId=" + shoppingAddressId
				+ ", shoppingAddressName=" + shoppingAddressName
				+ ", deliveryUser=" + deliveryUser + ", deliveryUserName="
				+ deliveryUserName + ", deliveryTime=" + deliveryTime
				+ ", accepter=" + accepter + ", accepterUserName="
				+ accepterUserName + ", acceptTime=" + acceptTime
				+ ", checkUser=" + checkUser + ", checkUserName="
				+ checkUserName + ", checkTime=" + checkTime
				+ ", dispatchBillTime=" + dispatchBillTime + ", productPic="
				+ productPic + ", supplierName=" + supplierName
				+ ", productModel=" + productModel + ", status=" + status + "]";
	}
	
	
	
}
