package com.wit.model;

//import java.io.Serializable;
import java.util.Date;

public class Users {
	/**
	 * 
	 */
	//private static final long serialVersionUID = 1L;
	private Integer id;  //用户ID;
	private String userCode; // 用户编号
	private String userName; //用户名
	private String userPsw; //用户密码
	private Integer userType; //用户类型
	private String userPhoto;//用户头像
	private String userUnits;
	private Date regTime; //注册时间
	private String email; //Email
	private String tel; // 电话
	private String address; //联系地址
	private String addressName;//地址(显示)
	private String zipCode; // 邮编
	private String fixedLineTel; //固定电话
	private String fax; // 传真
	private Integer status; //状态
	private Integer roleId; //角色ID
	private Integer isEmailVerify; //邮箱验证 
	private Integer isTelVerify; // 电话验证
	private Integer companyId; //公司ID
	private Integer departmentId; //部门ID
	private Integer jobsId; //岗位ID
	private String roleName;
	private Integer gender;
	private String companyName; //公司ID
	private String departmentName; //部门ID
	private String jobName; //岗位ID
	private Integer companyStatus; //状态
	private Integer companyType; //公司类型
	private Integer maxNum;//汇总账户数
	private Integer parentID;//父ID
	private String companyPlant;//公司职务
	public String getCompanyPlant() {
		return companyPlant;
	}

	public void setCompanyPlant(String companyPlant) {
		this.companyPlant = companyPlant;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public Integer getCompanyType() {
		return companyType;
	}

	public void setCompanyType(Integer companyType) {
		this.companyType = companyType;
	}

	public Integer getCompanyStatus() {
		return companyStatus;
	}

	public void setCompanyStatus(Integer companyStatus) {
		this.companyStatus = companyStatus;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}



	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getUserUnits() {
		return userUnits;
	}

	public void setUserUnits(String userUnits) {
		this.userUnits = userUnits;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPsw() {
		return userPsw;
	}

	public void setUserPsw(String userPsw) {
		this.userPsw = userPsw;
	}

	

	

	

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public Date getRegTime() {
		return regTime;
	}

	public void setRegTime(Date regTime) {
		this.regTime = regTime;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}


	public String getFixedLineTel() {
		return fixedLineTel;
	}

	public void setFixedLineTel(String fixedLineTel) {
		this.fixedLineTel = fixedLineTel;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getIsEmailVerify() {
		return isEmailVerify;
	}

	public void setIsEmailVerify(Integer isEmailVerify) {
		this.isEmailVerify = isEmailVerify;
	}

	public Integer getIsTelVerify() {
		return isTelVerify;
	}

	public void setIsTelVerify(Integer isTelVerify) {
		this.isTelVerify = isTelVerify;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getJobsId() {
		return jobsId;
	}

	public void setJobsId(Integer jobsId) {
		this.jobsId = jobsId;
	}

	@Override
	public String toString() {
		return "Users [id=" + id + ", userCode=" + userCode + ", userName="
				+ userName + ", userPsw=" + userPsw + ", userType=" + userType
				+ ", userUnits=" + userUnits + ", regTime=" + regTime
				+ ", email=" + email + ", tel=" + tel + ", address=" + address
				+ ", zipCode=" + zipCode + ", fixedLineTel=" + fixedLineTel
				+ ", fax=" + fax + ", status=" + status + ", roleId=" + roleId
				+ ", isEmailVerify=" + isEmailVerify + ", isTelVerify="
				+ isTelVerify + ", companyId=" + companyId + ", departmentId="
				+ departmentId + ", jobsId=" + jobsId + "]";
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}


	public Integer getMaxNum() {
		return maxNum;
	}

	public void setMaxNum(Integer maxNum) {
		this.maxNum = maxNum;
	}

	public Integer getParentID() {
		return parentID;
	}

	public void setParentID(Integer parentID) {
		this.parentID = parentID;
	}

	public String getAddressName() {
		return addressName;
	}

	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}

	
	
	
}
