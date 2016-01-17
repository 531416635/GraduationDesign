package com.wit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.wit.dao.InquirySheetDao;
import com.wit.model.InquirySheet;
import com.wit.model.Page;
import com.wit.service.InquirySheetService;

@Service("InquirySheetService")
public class InquirySheetServiceImpl implements InquirySheetService{
	 @Resource
	private InquirySheetDao inquirySheetDao;

	@Override
    public List<InquirySheet> getAll(Page page) {
        return inquirySheetDao.getAll(page);
    }
	
	
	 @Override
	    public String delete(int id) {
	        if (inquirySheetDao.delete(id) == 1) {
	            return "删除成功";
	        }
	        return "删除失败";
	 }
	 
	 @Override
	 public void add(InquirySheet inquirySheet){
		 inquirySheetDao.add(inquirySheet);
	 }
	
	 @Override
	    public InquirySheet findById(Integer id) {
	        return inquirySheetDao.findbyId(id);
	    }
	 @Override
	    public void update(InquirySheet inquirySheet) {
		 	inquirySheetDao.update(inquirySheet);
	    }
	 
	 @Override
	 public int findRows(){
		 return inquirySheetDao.findRows();
	 }


	@Override
	public List<InquirySheet> findAll(Map<String, Object> parm) {
		return inquirySheetDao.findAll(parm);
	}


	@Override
	public int rows(Integer userId) {
		return inquirySheetDao.rows(userId);
	}
	
	@Override
	public List<Map<String,Object>> findAllByIds(Map<String,Object> parm){
		return inquirySheetDao.findAllByIds(parm);
	}


	@Override
	public void updateInquirySheetInfo(InquirySheet inquirySheet) {
		inquirySheetDao.updateInquirySheetInfo(inquirySheet);
	}
	
	@Override
	public InquirySheet findByInquiryId(String inquiryId)
	{
		return 	inquirySheetDao.findByInquiryId(inquiryId);
	}


	@Override
	public void deleteInquirySheetInfo(String inquiryId) {
		inquirySheetDao.deleteInquirySheetInfo(inquiryId);
	}
	
	@Override
	public void updateStatusByIds(String ids, Integer status)
	{
		inquirySheetDao.updateStatusByIds( ids,  status);
	}
	
	@Override
	public int findAllByIdsRows(Map<String, Object> parm){
		return inquirySheetDao.findAllByIdsRows( parm );
	}


	@Override
	public List<Map<String, Object>> weChatFindAllByIds(Map<String, Object> parm) {
		
		return inquirySheetDao.weChatFindAllByIds(parm);
	}


	@Override
	public int weChatFindAllRowsByIds(Map<String, Object> parm) {
		
		return inquirySheetDao.weChatFindAllRowsByIds(parm);
	}
}
