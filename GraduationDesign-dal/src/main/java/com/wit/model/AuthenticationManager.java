package com.wit.model;

import java.sql.Date;

/**
 * 认证管理实体类
 * @author Jason-Tang
 *
 */
public class AuthenticationManager {
	//认证管理id
	private Integer id;
	//认证名称
	private String authenticationName;
	//认证文件
	private String filePath;
	//企业名称id
	private Integer companyId;
	//企业类型
	private Integer companyType;
	//状态
	private Integer status;
	//上传时间
	private Date uploadTime;
	//上传人
	private Integer uploadBy;
	//文件类别
	private Integer fileClass;
	@Override
	public String toString() {
		return "id=" + id + ", authenticationName="
				+ authenticationName + ", filePath=" + filePath
				+ ", companyId=" + companyId + ", companyType=" + companyType
				+ ", status=" + status + ", uploadTime=" + uploadTime
				+ ", uploadBy=" + uploadBy + ", fileClass=" + fileClass;
	}
	public AuthenticationManager() {
	}
	public AuthenticationManager(Integer id, String authenticationName,
			String filePath, Integer companyId, Integer companyType,
			int status, Date uploadTime, Integer uploadBy, Integer fileClass) {
		super();
		this.id = id;
		this.authenticationName = authenticationName;
		this.filePath = filePath;
		this.companyId = companyId;
		this.companyType = companyType;
		this.status = status;
		this.uploadTime = uploadTime;
		this.uploadBy = uploadBy;
		this.fileClass = fileClass;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAuthenticationName() {
		return authenticationName;
	}
	public void setAuthenticationName(String authenticationName) {
		this.authenticationName = authenticationName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getCompanyType() {
		return companyType;
	}
	public void setCompanyType(Integer companyType) {
		this.companyType = companyType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date date) {
		this.uploadTime = date;
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
	
	
}
