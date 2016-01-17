package com.wit.model;

import jxl.write.DateTime;

/**
 * 流程日志
 * @author Administrator
 *
 */
public class WorkflowLogs {
private Integer id;//流程日志Id
private Integer workflowId;//流程Id
private Integer nodeId;//节点
private Integer userId;//用户Id
private Integer processResult;//处理结果
private String processContent;//处理意见
private String refId;//对应的配送单号  dispatchBillId
private DateTime processTime;//处理时间


public DateTime getProcessTime() {
	return processTime;
}

public void setProcessTime(DateTime processTime) {
	this.processTime = processTime;
}

public String getRefId() {
	return refId;
}

public void setRefId(String refId) {
	this.refId = refId;
}

public Integer getId() {
	return id;
}

public void setId(Integer id) {
	this.id = id;
}

public Integer getWorkflowId() {
	return workflowId;
}

public void setWorkflowId(Integer workflowId) {
	this.workflowId = workflowId;
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



}
