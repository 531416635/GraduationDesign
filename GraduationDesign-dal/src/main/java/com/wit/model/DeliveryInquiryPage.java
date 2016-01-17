package com.wit.model;

public class DeliveryInquiryPage extends Page{
	private String shoppingAddressName;
	private String dispatchBillId;
	private String deliveryUserName;
	private String status;
	public String getShoppingAddressName() {
		return shoppingAddressName;
	}
	public void setShoppingAddressName(String shoppingAddressName) {
		this.shoppingAddressName = shoppingAddressName;
	}
	public String getDispatchBillId() {
		return dispatchBillId;
	}
	public void setDispatchBillId(String dispatchBillId) {
		this.dispatchBillId = dispatchBillId;
	}
	public String getDeliveryUserName() {
		return deliveryUserName;
	}
	public void setDeliveryUserName(String deliveryUserName) {
		this.deliveryUserName = deliveryUserName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "DeliveryInquiryPage [shoppingAddressName="
				+ shoppingAddressName + ", dispatchBillId=" + dispatchBillId
				+ ", deliveryUserName=" + deliveryUserName + ", status="
				+ status + "]";
	}
	
}
