package com.wit.model;

/**
 * 所有分页组件的父类，
 * 封装了分页相关的公共参数。
 */
public class newOrNoticePage extends Page{
	@Override
	public int getPageNum() {
		pageNum=50;
		return pageNum;
	}
}
