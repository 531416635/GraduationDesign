package com.wit.comm;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

public class Common {
	
	private static  org.apache.log4j.Logger  log= Logger.getLogger(Common.class);
	public static String getDateTimeNow() {
		return getDateTimeNow("");
	}
	public static String getDateTimeNow(String format) {
		if(format==null || format=="")
		{
			format="yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat df = new SimpleDateFormat(format);// 设置日期格式
		return df.format(new Date());// new Date()为获取当前系统时间
	}
	/**
	 * 按照参数format的格式，日期转字符串
	 * @param date
	 * @param format
	 * @return
	 */
	public static String getDateTime1Now(Date date,String format){
		if(date!=null){
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			return sdf.format(date);
		}else{
			return "";
		}
	}
	/**
	 * 按照yyyy-MM-dd HH:mm:ss的格式，日期转字符串
	 * @param date
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static String getDateTime1Now(Date date){
		return getDateTime1Now(date,"yyyy-MM-dd HH:mm:ss");
	}
	/**
	 * 将日期(yyyy-MM-dd)字符串转换为sqlDate日期格式
	 * @param date
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static java.sql.Date strTosqlDate1(String date){
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date cDate = null;
		try {
			cDate = df.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        java.sql.Date dd = new java.sql.Date(cDate.getTime());
        return dd;
	}
	/**
	 * 将日期(yyyy-MM-dd HH:mm:ss)字符串转换为Date日期格式
	 * @param date
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static java.sql.Date strTosqlDate2(String date){
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date cDate = null;
		try {
			cDate = df.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		java.sql.Date dd = new java.sql.Date(cDate.getTime());
        return dd;
	}
	

	public static java.sql.Date getSqlDate() {
		java.util.Date datetime = new java.util.Date();
		return new java.sql.Date(datetime.getTime());

	}

	public static void setLog(Object message)
	{		
		 log.debug(message);
	}
	
	public static String getDecoding(String text)
	{
		
		try {
			text = java.net.URLDecoder.decode(text, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			Common.setLog(e);
		}
		return text;
	}
	
	public static enum UserType {
		Manager("管理用户", 1), Merchant("商户用户", 2);
		// 成员变量
		private String name;
		private int index;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public int getIndex() {
			return index;
		}

		public String getIndexString() {
			return Integer.toString(index);
		}

		public void setIndex(int index) {
			this.index = index;
		}

		// 构造方法
		private UserType(String name, int index) {
			this.name = name;
			this.index = index;
		}

		// 覆盖方法
		@Override
		public String toString() {
			return this.index + "_" + this.name;
		}

	}
	public static enum NewsType {
		News("新闻", 1), Notice("公告", 2);
		// 构造方法
		private NewsType(String name, int index) {
			this.name = name;
			this.index = index;
		}
		// 成员变量
		private String name;
		private int index;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public int getIndex() {
			return index;
		}

		public String getIndexString() {
			return Integer.toString(index);
		}

		public void setIndex(int index) {
			this.index = index;
		}



		// 覆盖方法
		@Override
		public String toString() {
			return this.index + "_" + this.name;
		}

	}
	private static String md5Key = "tuancan";

	public static String md5(String md5Text) {
		return com.wit.sign.MD5.sign(md5Text, md5Key, "UTF-8");
	}
	/**
	 * 判断字符串中是否有数字
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		if (str.matches("\\d *")) {
			return true;
		} else {
			return false;
		}
	}
	
}
