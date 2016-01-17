package com.wit.model;

/**
 * 所有分页组件的父类，
 * 封装了分页相关的公共参数。
 */
public class Page {
	protected int pageNum = 10;
	private int currentPage = 1;
	private int begin;
	private int rows;
	private int totalPage;

	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getBegin() {
		begin = (currentPage-1)*pageNum;
		return begin;
	}
	public void setBegin(int begin) {
		this.begin = begin;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getTotalPage() {
		if(rows%pageNum==0) {
			totalPage = rows/pageNum;
		} else {
			totalPage = rows/pageNum+1;
		}
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	@Override
	public String toString() {
		return "Page [pageNum=" + pageNum + ", currentPage=" + currentPage
				+ ", begin=" + begin + ", rows=" + rows + ", totalPage="
				+ totalPage + "]";
	}

	

}
