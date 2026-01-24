package com.aladdin.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class CardnumberInfo {
	/**
	 * 根据身份证返回年龄age和性别sexes
	 * @param cardnumber
	 * @return 
	 */
	public static HashMap<String,Object> getInfomation(String cardnumber){
		HashMap<String,Object> infos=new HashMap<String, Object>();
		cardnumber = cardnumber.trim();
		try {
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
			int year=Integer.parseInt(dateFormat.format(now));
			
			int length=cardnumber.length();
			if(length==15){
				int cardYear=Integer.parseInt(cardnumber.substring(6,8))+1900;
				int age=year-cardYear+1;
				infos.put("age",age);
				
				int sexnumber=Integer.parseInt(cardnumber.substring(14));
				if(sexnumber%2!=0)infos.put("sexes","男");//奇数为男
				else infos.put("sexes","女");//偶数为女
			}else if(length==18){
				int cardYear=Integer.parseInt(cardnumber.substring(6,10));
				int age=year-cardYear+1;
				infos.put("age",age);
				
				int sexnumber=Integer.parseInt(cardnumber.substring(16,17));
				if(sexnumber%2!=0)infos.put("sexes","男");//奇数为男
				else infos.put("sexes","女");//偶数为女
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return infos;
	}
	public static int getAge(String cardnumber){
		int age=0;
		cardnumber = cardnumber.trim();
		try {
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
			SimpleDateFormat zjFormat=new SimpleDateFormat("MMdd");
			int year=Integer.parseInt(dateFormat.format(now));
			int monthdate=Integer.parseInt(zjFormat.format(now));
			int length=cardnumber.length();
			if(length==15){
				int cardYear=Integer.parseInt(cardnumber.substring(6,8))+1900;
				age=year-cardYear;
				if(Integer.parseInt(cardnumber.substring(8,12))>monthdate)age--;
			}else if(length==18){
				int cardYear=Integer.parseInt(cardnumber.substring(6,10));
				 age=year-cardYear;
				 if(Integer.parseInt(cardnumber.substring(10,14))>monthdate)age--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return age;
	} 
	public static int getAgeByBirthday(String birthday){
		int age=0;
		birthday = birthday.trim();
		try {
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
			SimpleDateFormat zjFormat=new SimpleDateFormat("MMdd");
			int year=Integer.parseInt(dateFormat.format(now));
			int monthdate=Integer.parseInt(zjFormat.format(now));
			int length=birthday.length();
			if(length>0){
				int cardYear=Integer.parseInt(birthday.substring(0,4));
				age=year-cardYear;
				if(Integer.parseInt(birthday.substring(5,7).toString()+birthday.substring(8,10).toString())>monthdate)age--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return age;
	} 
	
	public static String  getSex(String cardnumber){
		String sex="";
		cardnumber = cardnumber.trim();
		try {
		int length=cardnumber.length();
			if(length==15){
			int sexnumber=Integer.parseInt(cardnumber.substring(14));
				if(sexnumber%2!=0)sex="男";//奇数为男
				else sex="女";//偶数为女
			}else if(length==18){
			int sexnumber=Integer.parseInt(cardnumber.substring(16,17));
				if(sexnumber%2!=0)sex="男";//奇数为男
				else sex="女";//偶数为女
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sex;
	}
	
	public static String getBirthDay(String cardnumber){
		String birthday="";
		cardnumber = cardnumber.trim();
		int length=cardnumber.length();
		if(length==15){
			birthday = "19"+cardnumber.substring(6,8)+"-"+cardnumber.substring(8,10)+"-"+cardnumber.substring(10,12);
		}else if(length==18){
			birthday = cardnumber.substring(6,10)+"-"+cardnumber.substring(10,12)+"-"+cardnumber.substring(12,14);
		}
		return birthday;
	}

	/**
	 * 根据出生日期和指定日期计算年龄
	 * @param birthday 出生日期 格式：yyyy-MM-dd
	 * @param targetDate 目标日期 格式：yyyy-MM-dd
	 * @return 年龄
	 */
	public static int getAgeByDate(String birthday, String targetDate){
		int age = 0;
		try {
			if(birthday == null || targetDate == null || birthday.length() < 10 || targetDate.length() < 10){
				return 0;
			}
			int birthYear = Integer.parseInt(birthday.substring(0, 4));
			int birthMonth = Integer.parseInt(birthday.substring(5, 7));
			int birthDay = Integer.parseInt(birthday.substring(8, 10));

			int targetYear = Integer.parseInt(targetDate.substring(0, 4));
			int targetMonth = Integer.parseInt(targetDate.substring(5, 7));
			int targetDay = Integer.parseInt(targetDate.substring(8, 10));

			age = targetYear - birthYear;
			// 如果目标日期的月日还没到生日，年龄减1
			if(targetMonth < birthMonth || (targetMonth == birthMonth && targetDay < birthDay)){
				age--;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return age;
	}
}
