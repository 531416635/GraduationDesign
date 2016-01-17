package com.wit.model;

import java.io.Serializable;
import java.util.Date;

public class Jobs implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//岗位id
	private Integer id;
	//部门id
	private Integer departmentId;
	//岗位名称
	private String jobName;
	//状态
	private Integer status;
	//创建人
	private Integer createBy;
	//创建时间
	private Date createAt;
	
	private String departmentName;
	
	
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	@Override
	public String toString() {
		return "id=" + id + ", departmentId=" + departmentId
				+ ", jobName=" + jobName + ", status=" + status + ", createBy="
				+ createBy + ", createAt=" + createAt;
	}
	public Jobs() {
	}
	public Jobs(Integer id, Integer departmentId, String jobName,
			Integer status, Integer createBy, Date createAt) {
		super();
		this.id = id;
		this.departmentId = departmentId;
		this.jobName = jobName;
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
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
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
	public Date getCreateAt() {
		return createAt;
	}
	public void setCreateAt(Date date) {
		this.createAt = date;
	}
	
}
