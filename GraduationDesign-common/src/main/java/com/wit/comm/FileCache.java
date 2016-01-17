package com.wit.comm;
/**
 * 缓存类
 */

import java.io.File;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
    /** 
     * <pre> 
     * final 外部对象操作时：  
     * 通过文件名 -- 在map中找到对应 -- 判断是否修改 
     * 否 -- 返回缓存对象 
     * 是 -- 调用reload，根据传入的handler进行reload，更新缓存对象，更新操作时间 
     * </pre> 
     */  
    public class FileCache {  
        /** 缓存map */  
        private static Map<String, CacheElement> cacheMap = new HashMap<String, CacheElement>();  
        private static FileCache fileCache;  
        private static final int MAX_SIZE = 20;  
        private Queue<String> fileQueue = new LinkedList<String>();  
          
        /** 
         * 单例,多线程一样自信 
         *  
         * @return fileCache单例 
         */  
        public static FileCache getInstance(){  
        if(null == fileCache){  
            fileCache = new FileCache();  
        }  
        return fileCache;  
        }  
        /** 
         * 获取缓存对象 
         * 获取缓存，如果文件被修改，则重新加载最近配置，内存中超过20个文件缓存，会自动清理 
         * @param fileName 
         * @return 
         * @throws Exception  
         */  
        public Object getCache(String fileName,ReloadHandler handler) throws Exception{  
        fileName = fileName.trim();  
        if(isModified(fileName)){  
            reLoad(fileName,handler);  
        }  
        return cacheMap.get(fileName).getCache();  
        }  
          
        /** 
         * 重新加载 
         * @param fileName  
         * @param handler 
         * @throws Exception  
         */  
        private void reLoad(String fileName, ReloadHandler handler) throws Exception {  
        CacheElement ele = cacheMap.get(fileName);  
        if(null == ele){  
            //文件没有加载过  
            ele = new CacheElement();  
            //设置File对象  
            ele.setFile(new File(fileName));  
            cacheMap.put(fileName, ele);  
            //添加新的缓存，记录到队列中  
            if(!fileQueue.contains(fileName)){  
            //如果队列中没记录这个，则试图添加并进行清理  
            cacheClean();  
            fileQueue.add(fileName);  
            }  
        }  
        //更新缓存  
        ele.setCache(handler.processNewCache());  
        //更新修改时间  
        ele.setLastEditTime(ele.getFile().lastModified());  
          
        }  
        /** 
         * 判断是否已经修改 
         *  
         * @param diXmlName 
         * @return 
         */  
        private boolean isModified(String fileName) {  
      
        CacheElement cacheElement = cacheMap.get(fileName);  
        if (null == cacheElement) {  
            //配置文件没有被加载过  
            return true;  
        }  
        if (cacheElement.getFile().lastModified() != cacheElement.getLastEditTime()) {  
            //被修改  
            return true;  
        }  
        // 没有变化  
        return false;  
        }  
          
        /** 
         * FIFO 清理缓存， 
         */  
        private void cacheClean(){  
        //缓存超过限制之后，进行清理  
        if(fileQueue.size() >= MAX_SIZE ){  
            String fileName = fileQueue.poll();  
            cacheMap.put(fileName, null);  
            cacheMap.remove(fileName);  
        }  
        }  
          
        //私有构造  
        private FileCache(){}  
        /** 
         * 缓存元素 
         *  
         
         */  
        class CacheElement {  
      
        public long   lastEditTime;  
        public File   file;  
        public File getFile() {
			return file;
		}

        //setters and getters... 
		public void setFile(File file) {
			this.file = file;
		}

		public Object getCache() {
			return cache;
		}

		public void setCache(Object cache) {
			this.cache = cache;
		}

		public Object cache;  
      
        public long getLastEditTime() {  
      
            return lastEditTime;  
        }  
      
        public void setLastEditTime(long lastEditTime) {  
      
            this.lastEditTime = lastEditTime;  
        }  
      
        }  
    }  