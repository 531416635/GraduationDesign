package com.wit.model;
/**
 * 公司表实体类
 * @author Jason-Tang
 *
 */
public class Companys {
	//公司id
	private Integer id;
	//公司名称
	private String companyName;
	//公司地址
	private String companyAddress;
	//公司规模
	private Integer companyScale;
	//注册资本
	private Integer registeredCapital;
	//公司电话
	private String companyTel;
	//邮政编码
	private String companyZipCode;
	//公司简介
	private String companyInfo;
	//销售人员
	private String salesMan;
	//公司网址
	private String companyWebsite;
	//公司联系人
	private String companyContact;
	//公司类别
	private Integer companyType;
	//状态
	private Integer status;
	//
	private Integer maxAccount = 50;
	//
	private Integer isDefault = 0;
	//
	private Integer isLock = 0;
	//
	private Integer maxPic = 20;
	//食堂数量
	private Integer diningRoomNumber;
	//配送车辆
	private Integer distributionCar;
	//公司传真
	private String companyFax;
	
	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	public String getCompanyFax() {
		return companyFax;
	}
	/*public void setCompanyFax(String companyFax) {
		this.companyFax = companyFax;
	}
	public String getCompanyTypeName() {
		return companyTypeName;
	}*/
	public Integer getMaxAccount() {
		return maxAccount;
	}
	public void setMaxAccount(Integer maxAccount) {
		this.maxAccount = maxAccount;
	}
	public Integer getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(Integer isDefault) {
		this.isDefault = isDefault;
	}
	public Integer getIsLock() {
		return isLock;
	}
	public void setIsLock(Integer isLock) {
		this.isLock = isLock;
	}
	public Integer getMaxPic() {
		return maxPic;
	}
	public void setMaxPic(Integer maxPic) {
		this.maxPic = maxPic;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	//公司类别名称
	private String companyTypeName;
	public String getcompanyTypeName() {
		switch (companyType) {
		case 1:
			companyTypeName="供应商";
			break;
		case 2:
			companyTypeName="采购商";
		default:
			break;
		}
		return companyTypeName;
	}
	public void setCompanyTypeName(String companyTypeName) {
		this.companyTypeName = companyTypeName;
	}
	@Override
	public String toString() {
		return "Companys [id=" + id + ", companyName=" + companyName
				+ ", companyAddress=" + companyAddress + ", companyScale="
				+ companyScale + ", registeredCapital=" + registeredCapital
				+ ", companyTel=" + companyTel + ", CompanyZipCode=" + companyZipCode
				+ ", companyInfo=" + companyInfo + ", salesMan=" + salesMan
				+ ", companyWebsite=" + companyWebsite + ", companyContact="
				+ companyContact + ", companyType=" + companyType + "]";
	}
	
	public Companys() {
	}

	public Companys(Integer id, String companyName, String companyAddress,
			int companyScale, Integer registeredCapital, String companyTel,
			String companyZipCode, String companyInfo, String salesMan,
			String companyWebsite, String companyContact, Integer companyType) {
		super();
		this.id = id;
		this.companyName = companyName;
		this.companyAddress = companyAddress;
		this.companyScale = companyScale;
		this.registeredCapital = registeredCapital;
		this.companyTel = companyTel;
		this.companyZipCode = companyZipCode;
		this.companyInfo = companyInfo;
		this.salesMan = salesMan;
		this.companyWebsite = companyWebsite;
		this.companyContact = companyContact;
		this.companyType = companyType;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	/*public String getcompanyAddress() {
		return companyAddress;
	}

	public void setcompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}*/

	public Integer getDiningRoomNumber() {
		return diningRoomNumber;
	}
	public void setDiningRoomNumber(Integer diningRoomNumber) {
		this.diningRoomNumber = diningRoomNumber;
	}
	public Integer getDistributionCar() {
		return distributionCar;
	}
	public void setDistributionCar(Integer distributionCar) {
		this.distributionCar = distributionCar;
	}
	public Integer getCompanyScale() {
		return companyScale;
	}

	public void setCompanyScale(Integer companyScale) {
		this.companyScale = companyScale;
	}

	public Integer getRegisteredCapital() {
		return registeredCapital;
	}

	public void setRegisteredCapital(Integer registeredCapital) {
		this.registeredCapital = registeredCapital;
	}

	public String getCompanyTel() {
		return companyTel;
	}

	public void setCompanyTel(String companyTel) {
		this.companyTel = companyTel;
	}

	public String getCompanyZipCode() {
		return companyZipCode;
	}

	public void setCompanyZipCode(String CompanyZipCode) {
		this.companyZipCode = CompanyZipCode;
	}

	public String getCompanyInfo() {
		return companyInfo;
	}

	public void setCompanyInfo(String companyInfo) {
		this.companyInfo = companyInfo;
	}

	public String getSalesMan() {
		return salesMan;
	}

	public void setSalesMan(String salesMan) {
		this.salesMan = salesMan;
	}

	public String getCompanyWebsite() {
		return companyWebsite;
	}

	public void setCompanyWebsite(String companyWebsite) {
		this.companyWebsite = companyWebsite;
	}

	public String getCompanyContact() {
		return companyContact;
	}

	public void setCompanyContact(String companyContact) {
		this.companyContact = companyContact;
	}

	public Integer getCompanyType() {
		return companyType;
	}

	public void setCompanyType(Integer companyType) {
		this.companyType = companyType;
	}
	
	
}
