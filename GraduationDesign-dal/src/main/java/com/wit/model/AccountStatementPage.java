package com.wit.model;
import java.sql.Date;

public class AccountStatementPage extends Page{
	private Integer settlementId;
	private Date settleTimeStart;
	private Date settleTimeStop;
	public Integer getSettlementId() {
		return settlementId;
	}
	public void setSettlementId(Integer settlementId) {
		this.settlementId = settlementId;
	}
	public Date getSettleTimeStart() {
		return settleTimeStart;
	}
	public void setSettleTimeStart(Date settleTimeStart) {
		this.settleTimeStart = settleTimeStart;
	}
	public Date getSettleTimeStop() {
		return settleTimeStop;
	}
	public void setSettleTimeStop(Date settleTimeStop) {
		this.settleTimeStop = settleTimeStop;
	}
	@Override
	public String toString() {
		return "SettleInquiryPage [settlementId=" + settlementId
				+ ", settleTimeStart=" + settleTimeStart + ", settleTimeStop="
				+ settleTimeStop + "]";
	}
	
}
