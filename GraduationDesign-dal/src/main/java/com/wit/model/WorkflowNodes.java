package com.wit.model;

/**
 * 流程节点 lj
 */
public class WorkflowNodes {
	private Integer id;// ID
	private String nodeName;// 节点名称
	private String nodeCode;// 节点简称
	private Integer nodeRole;// 节点角色
	private Integer nodeType;// 节点类型
	private Integer processResult;// 批复
	private String processContent;// 批复内容
	private Integer prevNode;// 上一个节点
	private Integer nextNode;// 下一个节点
	private Integer workflowTypeId;// 流程类型ID

	private String roleName;// 节点角色名称

	

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getNodeCode() {
		return nodeCode;
	}

	public void setNodeCode(String nodeCode) {
		this.nodeCode = nodeCode;
	}

	public Integer getNodeRole() {
		return nodeRole;
	}

	public void setNodeRole(Integer nodeRole) {
		this.nodeRole = nodeRole;
	}

	public Integer getNodeType() {
		return nodeType;
	}

	public void setNodeType(Integer nodeType) {
		this.nodeType = nodeType;
	}

	public Integer getProcessResult() {
		return processResult;
	}

	public void setProcessResult(Integer processResult) {
		this.processResult = processResult;
	}

	public String getProcessContent() {
		return processContent;
	}

	public void setProcessContent(String processContent) {
		this.processContent = processContent;
	}

	public Integer getPrevNode() {
		return prevNode;
	}

	public void setPrevNode(Integer prevNode) {
		this.prevNode = prevNode;
	}

	public Integer getNextNode() {
		return nextNode;
	}

	public void setNextNode(Integer nextNode) {
		this.nextNode = nextNode;
	}

	public Integer getWorkflowTypeId() {
		return workflowTypeId;
	}

	public void setWorkflowTypeId(Integer workflowTypeId) {
		this.workflowTypeId = workflowTypeId;
	}

	@Override
	public String toString() {
		return "WorkFlowNodes [id=" + id + ", nodeName=" + nodeName
				+ ", nodeCode=" + nodeCode + ", nodeRole=" + nodeRole
				+ ", nodeType=" + nodeType + ", processResult=" + processResult
				+ ", processContent=" + processContent + ", prevNode="
				+ prevNode + ", nextNode=" + nextNode + ", workflowTypeId="
				+ workflowTypeId + "]";
	}

}
