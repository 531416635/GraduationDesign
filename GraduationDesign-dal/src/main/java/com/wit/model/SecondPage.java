package com.wit.model;

public class SecondPage extends Page{
	
	private String condition0;  //商品成分
	
	private String condition1; //商品品牌
	
	private String condition2; //商品规格

	private String superclass; //父类
	
	private String subclass; //子类
	
	private String productCategoryIds; //属性
	
	public String getSubclass() {	
		return subclass;
	}

	public void setSubclass(String subclass) {
		this.subclass = subclass;
	}

	public String getProductCategoryIds() {
		
		return productCategoryIds;
	}

	public void setProductCategoryIds(String productCategoryIds) {
		 //将其他查询条件拆分保存
		if(productCategoryIds.indexOf(",")==-1){
			this.setCondition0(productCategoryIds);
		}else{
			String[] conditions = productCategoryIds.split(",");
			int i =0;
			while(i<conditions.length){
				switch(i){
				case 0 :
					this.setCondition0(conditions[i]);
					break;
				case 1 :
					this.setCondition1(conditions[i]);
					break;
				case 2 :
					this.setCondition2(conditions[i]);
					break;
				}
				++i;
			}	
		}
		this.productCategoryIds = productCategoryIds;
	}

	public String getSuperclass() {
		return superclass;
	}

	public void setSuperclass(String superclass) {
		this.superclass = superclass;
	}

	public String getCondition0() {
		return condition0;
	}

	public void setCondition0(String condition0) {
		this.condition0 = condition0;
	}

	public String getCondition1() {
		return condition1;
	}

	public void setCondition1(String condition1) {
		this.condition1 = condition1;
	}

	public String getCondition2() {
		return condition2;
	}

	public void setCondition2(String condition2) {
		this.condition2 = condition2;
	}
/*
	@Override
	public int getPageNum() {
		pageNum=3;
		return pageNum;
	}
	*/
}
