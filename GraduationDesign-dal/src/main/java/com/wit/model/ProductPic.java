package com.wit.model;

import java.sql.Timestamp;

public class ProductPic {
private Integer id;
private Integer productId;
private Integer status;
private Timestamp uploadTime;
private Integer uploadBy;
private Integer fileClass;
private String filePath;
private Integer isDefault=0;
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public Integer getProductId() {
	return productId;
}
public void setProductId(Integer productId) {
	this.productId = productId;
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
public Integer getIsDefault() {
	return isDefault;
}
public void setIsDefault(Integer isDefault) {
	this.isDefault = isDefault;
}
@Override
public String toString() {
	return "ProductPic [id=" + id + ", productId=" + productId + ", status="
			+ status + ", uploadTime=" + uploadTime + ", uploadBy=" + uploadBy
			+ ", fileClass=" + fileClass + ", filePath=" + filePath
			+ ", isDefault=" + isDefault + "]";
}


}
