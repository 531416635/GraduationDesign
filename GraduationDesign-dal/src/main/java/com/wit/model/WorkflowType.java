package com.wit.model;

import java.sql.Date;
/**
 * 流程类型
 * @author Administrator
 *
 */
public class WorkflowType {
	private Integer id;// 流程类型Id
	private String workflowTypeName;// 流程类型名称
	private Integer createBy;// 创建人
	private Date createTime;// 创建时间
	private Integer status;// 状态

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getWorkflowTypeName() {
		return workflowTypeName;
	}

	public void setWorkflowTypeName(String workflowTypeName) {
		this.workflowTypeName = workflowTypeName;
	}

	public Integer getCreateBy() {
		return createBy;
	}

	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "WorkflowType [id=" + id + ", workflowTypeName="
				+ workflowTypeName + ", createBy=" + createBy + ", createTime="
				+ createTime + ", status=" + status + "]";
	}

}
