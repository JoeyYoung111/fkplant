package com.aladdin.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 获取系统的当前时间
 * @author xuxj
 *
 */
public class TimeFormate {
	/**
	 * 获取当前时间（xxxx-xx-xx xx:xx:xx）
	 * @author xuxj
	 * @return String
	 */
	public static String getISOTimeToNow(){
		Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dateFormat.format(now);
	}
	
	/**
	 * 获取当前时间（20161122101122）
	 * @author xuxj
	 * @return String
	 */
	public static String getISOTimeToNow2(){
		Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        return dateFormat.format(now);
	}
	
	/**
	 * 获取当前时间（xxxx-xx-xx）
	 * @author xuxj
	 * @return String
	 */
	public static String getYMD(){
		Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(now);
	}
}
