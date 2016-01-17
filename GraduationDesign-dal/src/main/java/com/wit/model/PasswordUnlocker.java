package com.wit.model;

import java.sql.Date;

/**
 * 密码找回实体类
 * @author Administrator
 *
 */
public class PasswordUnlocker {
	private Integer id;//ID
	private Integer userId;//用户ID
	private String verifiCode;//验证码
	private Date verifiDate;//验证时效
	private Integer status;//状态
	
	
	
	@Override
	public String toString() {
		return "PasswordUnlocker [id=" + id + ", userId=" + userId
				+ ", verifiCode=" + verifiCode + ", verifiDate=" + verifiDate
				+ ", status=" + status + "]";
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
	public String getVerifiCode() {
		return verifiCode;
	}
	public void setVerifiCode(String verifiCode) {
		this.verifiCode = verifiCode;
	}
	public Date getVerifiDate() {
		return verifiDate;
	}
	public void setVerifiDate(Date verifiDate) {
		this.verifiDate = verifiDate;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	
}
