package com.wit.service;

import java.util.List;

import com.wit.model.GrossMargin;

public interface GrossMarginService {
			//查询所有新闻信息
			List<GrossMargin>  findGrossMargin();
			//删除新闻信息
			void deleteGrossMargin(Integer id);
			//增加新闻公告
			void addGrossMarginr(GrossMargin grossMargin);
			//根据Id查询新闻公告信息
			GrossMargin findbyId(GrossMargin id);	
			//根据ID字符数组删除数据
			void deleteByIds(String ids);
			//更新新闻公告
			void updateGrossMargin(GrossMargin grossMargin);

}
