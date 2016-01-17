package com.wit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.wit.model.CompanyProducts;
import com.wit.model.Page;
public interface CompanyProductsDao {
			//查询所有新闻信息
			List<CompanyProducts>  findCompanyProducts(Page page);
			
			//删除新闻信息
			void deleteCompanyProduct(Integer id);
			//门户中商品管理中商品上架商品列表
			List<Map<String,Object>> findProductsbyCompanyId(Map<String, Object> parm);
			//根据ID字符数组删除数据
			void deleteCompanyProductByIds(String ids);
			//增加新闻公告
			void addCompanyProduct(CompanyProducts companyProduct);
			//根据Id查询新闻公告信息
			CompanyProducts findbyId(Integer id);
			//根据Id查询新闻公告信息
			CompanyProducts findbyIds(Integer id);
			//更新新闻公告
			void updateCompanyProducts(CompanyProducts companyProduct);
			//记录信息条数
			int findRows();
			//根据公司Id及分页查询所有供应商商品信息
			List<CompanyProducts> findCompanyProductsbyCompanyId(Map<String,Object> maps);
			//根据查看供应商是否出售该商品
			List<CompanyProducts> findCompanyProductsbyCompanyIdProdcuts(Map<String,Object> maps);
			
			//记录信息条数
			int findRowsbyCompanyId(Integer companyId);
			//门户删除或上下架商品信息

			int findProductsbyCompanyIdRows(Map<String, Object> parm);

			void changeCompanyProductStatus(Map<String, Object> parm);
			
			//供应审批信息列表
			List<CompanyProducts>  findsupplyCheckList(Page page);
			//供应审批信息列表 总条数
			int findsupplyCheckListRows();
			 //更改审核状态
			void changeCheck(@Param(value = "id") Integer id, 
					@Param(value = "status") Integer status);
			 //根据商品ID更改审核状态
			void changeCheckProduct(@Param(value = "id") Integer id, 
					@Param(value = "status") Integer status);
			//根据id查询商品上货中的“日期编码备注”字段
			CompanyProducts findProductInfoById(Integer id);
			//商品编辑页面中修改“日期编码备注”字段信息 
			void updateProductInfo(CompanyProducts companyproduct);
			//根据公司ID和商品ID查询IsSample
			int findProductSample(Map<String, Integer> par);

			Integer findbyProductId(int productId);
			
			
			List<CompanyProducts> webfindProductPicbyCompanyId(Map<String, Object> parm); //供应商新品申请及供应图片资质展现
			
			int webfindProductPicbyCompanyIdRows(Map<String, Object> parm);//供应商新品申请及供应图片资质展现总条数
			
			//工作台我的商品供应
			List<Map<String,Object>> productSupply(Map<String, Object> parm);
			
}
