package com.wit.model;

import java.util.Date;

public class Roles {
private Integer id; //角色ID
private String roleName;//角色名称
private String roleCode;//角色编号
private Integer status;//状态
private Date createTime;//创建时间
private Integer createBy;//创建人
private String createByName;//创建人
private String rightID;//权限菜单
private Integer companyID;//公司ID
private String companyName;//公司ID
public Integer getCompanyID() {
	return companyID;
}

public void setCompanyID(Integer companyID) {
	this.companyID = companyID;
}

public String getRightID() {
	return rightID;
}

public void setRightID(String rightID) {
	this.rightID = rightID;
}



public Integer getId() {
	return id;
}

public void setId(Integer id) {
	this.id = id;
}

public String getRoleName() {
	return roleName;
}

public void setRoleName(String roleName) {
	this.roleName = roleName;
}

public String getRoleCode() {
	return roleCode;
}

public void setRoleCode(String roleCode) {
	this.roleCode = roleCode;
}

public Integer getStatus() {
	return status;
}

public void setStatus(Integer status) {
	this.status = status;
}



public Date getCreateTime() {
	return createTime;
}

public void setCreateTime(Date createTime) {
	this.createTime = createTime;
}

public Integer getCreateBy() {
	return createBy;
}

public void setCreateBy(Integer integer) {
	this.createBy = integer;
}

public String getCompanyName() {
	return companyName;
}

public void setCompanyName(String companyName) {
	this.companyName = companyName;
}

public String getCreateByName() {
	return createByName;
}

public void setCreateByName(String createByName) {
	this.createByName = createByName;
}







}
