package com.wit.comm;
/** 
 * 重新加载接口 
 */  
public interface ReloadHandler {  
    /** 
     * 分析文件 
     * @return 要缓存的内容 
     */  
    Object processNewCache() throws Exception;  
} 
