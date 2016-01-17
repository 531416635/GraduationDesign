package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.PriceSheetDao;
import com.wit.model.Page;
import com.wit.model.PriceSheet;
import com.wit.service.PriceSheetService;

@Service
public class PriceSheetServiceImpl implements PriceSheetService{
	@Resource
	private PriceSheetDao  priceSheetDao;
	
	@Override
    public List<PriceSheet> getAll(Page page) {
        return priceSheetDao.getAll(page);
    }
	
	 @Override
	    public String delete(int id) {
	        if (priceSheetDao.delete(id) == 1) {
	            return "删除成功";
	        }
	        return "删除失败";	
	 }

	 @Override
	 public void add(PriceSheet priceSheet){
		priceSheetDao.add(priceSheet);
	 }
	 @Override
	 public int addByIds(Map<String, Object> parm)
	 {
		 return priceSheetDao.addByIds(parm);
	 }
	 @Override
	 public PriceSheet findById(Integer id){
		 return priceSheetDao.findbyId(id);
	 }
	 @Override
	 public void update(PriceSheet priceSheet){
		 priceSheetDao.update(priceSheet);
	 }
	 
	 @Override
	 public int findRows(){
		 return priceSheetDao.findRows();
	 }

	@Override
	public List<PriceSheet> findAll(Map<String, Object> parm) {
		return priceSheetDao.findAll(parm);
	}

	@Override
	public int rows(Integer userId) {
		return priceSheetDao.rows(userId);
	}

	@Override
	public List<Map<String, Object>> getPriceSheetInfo(Map<String, Object> parm){
		return priceSheetDao.getPriceSheetInfo(parm);
	} 	
  	//议价单数据展示
	@Override
	public List<Map<String,Object>> getBargainingInfo(Map<String,Object> parm){
		return priceSheetDao.getBargainingInfo(parm);
	}
  	
	@Override
	public List<Map<String, Object>> getCompanyBargainingInfo(Map<String, Object> parm){
		return priceSheetDao.getCompanyBargainingInfo(parm);
	}
  	
	@Override
	public Integer getPriceSheetInfoRow(Map<String, Object> parm){
		return priceSheetDao.getPriceSheetInfoRow(parm);
	}  	
  	//议价单数据展示
	@Override
	public Integer getBargainingInfoRow(Map<String,Object> parm){
		return priceSheetDao.getBargainingInfoRow(parm);
	}
  	
	@Override
	public Integer getCompanyBargainingInfoRow(Map<String, Object> parm){
		return priceSheetDao.getCompanyBargainingInfoRow(parm);
	}	

	@Override
	public void bargaining(PriceSheet priceSheet) {
		priceSheetDao.bargaining(priceSheet);
	}

	@Override
	public void deletePriceSheetInfo(PriceSheet priceSheet) {
		priceSheetDao.deletePriceSheetInfo(priceSheet);
	}
	@Override
	public void updateByIds(Map<String, Object> parm)
	{
		priceSheetDao.updateByIds(parm);
	}

	@Override
	public int bargainingResponse(Integer userId) {
		return priceSheetDao.bargainingResponse(userId);
	}

	@Override
	public int bargainingWait(Integer companyId) {
		return priceSheetDao.bargainingWait(companyId);
	}

	@Override
	public List<Map<String, Object>> getWeChatPriceSheetInfo(
			Map<String, Object> parm) {
		
		return priceSheetDao.getWeChatPriceSheetInfo(parm);
	}

	@Override
	public Integer getWeChatPriceSheetInfoRow(Map<String, Object> parm) {
		
		return priceSheetDao.getWeChatPriceSheetInfoRow(parm);
	}

}
