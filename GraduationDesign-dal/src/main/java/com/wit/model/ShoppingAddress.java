package com.wit.model;
/**
 * 配送地址实体类
 * @author Jason-Tang
 *
 */
public class ShoppingAddress {
	//配送地址id
	private Integer id;
	//配送地址
	private String shoppingAddress="";
	//地址简称
	private String adderssName="";
	//状态
	private Integer status;
	//公司id
	private Integer companyId;
	//用户id
	private Integer userId;
	
	private Integer province;//省份
	
	private Integer city;//城市	
	
	private Integer district;//地区
	
	private String provinceName;//省份
	
	private String cityName;//城市	
	
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	private String districtName;//地区
	
	private Integer addressType;//地址类型
	
	private String address;
	
	@Override
	public String toString() {
		return "ShoppingAddress [id=" + id + ", shoppingAddress="
				+ shoppingAddress + ", adderssName=" + adderssName
				+ ", status=" + status + ", companyId=" + companyId
				+ ", userId=" + userId + "]";
	}
	public ShoppingAddress() {
	}
	public ShoppingAddress(Integer id, String shoppingAddress,
			String adderssName, Integer status, Integer companyId,
			Integer userId) {
		super();
		this.id = id;
		this.shoppingAddress = shoppingAddress;
		this.adderssName = adderssName;
		this.status = status;
		this.companyId = companyId;
		this.userId = userId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getShoppingAddress() {
		return shoppingAddress;
	}
	public void setShoppingAddress(String shoppingAddress) {
		this.shoppingAddress = shoppingAddress;
	}
	public String getAdderssName() {
		return adderssName;
	}
	public void setAdderssName(String adderssName) {
		this.adderssName = adderssName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getProvince() {
		return province;
	}
	public void setProvince(Integer province) {
		this.province = province;
	}
	public Integer getCity() {
		return city;
	}
	public void setCity(Integer city) {
		this.city = city;
	}
	public Integer getDistrict() {
		return district;
	}
	public void setDistrict(Integer district) {
		this.district = district;
	}
	public Integer getAddressType() {
		return addressType;
	}
	public void setAddressType(Integer addressType) {
		this.addressType = addressType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
