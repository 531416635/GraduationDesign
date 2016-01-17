package com.wit.model;
/**
 * 用户流程
 * @author Administrator
 *
 */
public class Workflows {
	private Integer id;// 用户流程ID
	private Integer workflowTypeId;// 流程类型Id
	private Integer nodeId;// 节点Id
	private Integer userId;// 用户Id
	private Integer status;// 状态

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getWorkflowTypeId() {
		return workflowTypeId;
	}

	public void setWorkflowTypeId(Integer workflowTypeId) {
		this.workflowTypeId = workflowTypeId;
	}

	public Integer getNodeId() {
		return nodeId;
	}

	public void setNodeId(Integer nodeId) {
		this.nodeId = nodeId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Workflows [id=" + id + ", workflowTypeId=" + workflowTypeId
				+ ", nodeId=" + nodeId + ", userId=" + userId + ", status="
				+ status + "]";
	}
}
