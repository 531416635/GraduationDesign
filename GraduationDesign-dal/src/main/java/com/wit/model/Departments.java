package com.wit.model;

import java.sql.Date;



/**
 * 部门表实体类
 * @author Jason-Tang
 *
 */
public class Departments {
	//部门id
	private Integer id;
	//公司id
	private Integer companyId;
	
	private String companyName;
	//部门名称
	private String departmentName;
	//状态
	private Integer status;
	//创建人
	private Integer createBy;
	//创建时间
	private java.util.Date createAt;
	
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	@Override
	public String toString() {
		return "id=" + id + ", companyId=" + companyId
				+ ", departmentName=" + departmentName + ", status=" + status
				+ ", createBy=" + createBy + ", createAt=" + createAt;
	} 
	public Departments() {
	}
	public Departments(Integer id, Integer companyId, String departmentName,
			Integer status, Integer createBy, Date createAt) {
		super();
		this.id = id;
		this.companyId = companyId;
		this.departmentName = departmentName;
		this.status = status;
		this.createBy = createBy;
		this.createAt = createAt;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getCreateBy() {
		return createBy;
	}
	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}
	public java.util.Date getCreateAt() {
		return createAt;
	}
	public void setCreateAt(java.util.Date date) {
		this.createAt = date;
	}
	
}
