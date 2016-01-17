package com.wit.model;

import java.sql.Timestamp;

public class CompanyProductPic {
private Integer id;
private Integer companyProductsId;
private Integer status=0;
private Timestamp uploadTime;
private Integer uploadBy;
private Integer fileClass;
private String filePath;
private Integer isDefault;


public Integer getIsDefault() {
	return isDefault;
}
public void setIsDefault(Integer isDefault) {
	this.isDefault = isDefault;
}
public Integer getCompanyProductsId() {
	return companyProductsId;
}
public void setCompanyProductsId(Integer companyProductsId) {
	this.companyProductsId = companyProductsId;
}
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public Integer getStatus() {
	return status;
}
public void setStatus(Integer status) {
	this.status = status;
}
public Timestamp getUploadTime() {
	return uploadTime;
}
public void setUploadTime(Timestamp uploadTime) {
	this.uploadTime = uploadTime;
}
public Integer getUploadBy() {
	return uploadBy;
}
public void setUploadBy(Integer uploadBy) {
	this.uploadBy = uploadBy;
}
public Integer getFileClass() {
	return fileClass;
}
public void setFileClass(Integer fileClass) {
	this.fileClass = fileClass;
}

public String getFilePath() {
	return filePath;
}
public void setFilePath(String filePath) {
	this.filePath = filePath;
}
@Override
public String toString() {
	return "companyProductPic [id=" + id + ", companyProductsId="
			+ companyProductsId + ", status=" + status + ", uploadTime="
			+ uploadTime + ", uploadBy=" + uploadBy + ", fileClass="
			+ fileClass + ", filePath=" + filePath + "]";
}

}
