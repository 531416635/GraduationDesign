package com.wit.dao;

import java.util.List;
import java.util.Map;

import com.wit.model.ProductTransfer;

public interface ProductTransferDao {
		//查询所有物流信息
		List<ProductTransfer>  findProductTransfer();
		//删除物流信息
		void deleteProductTransfer(Integer id);
		//根据ID字符数组删除数据
		void deleteProductTransferByIds(String ids);
		//增加物流公告
		void addProductTransfer(ProductTransfer productTransfer);
		//根据Id查询物流公告信息
		ProductTransfer findbyId(Integer id);
		//更新物流公告
		void updateProductTransfer(ProductTransfer productTransfer);
		//根据companyProductId查询物流公告信息
		List<ProductTransfer> findbycompanyProductId(Integer companyProductId);
		//根据companyProductId分页查询物流公告信息
		List<ProductTransfer> findbycompanyProductIds(Map<String,Object> maps);
		//记录信息条数
		int findRows(Integer companyProductID);
}
