package com.aladdin.util;


import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

public class Configuration {
	private Properties propertie;
	private InputStreamReader inputFile;

	/**
	 * 初始化Configuration
	 */
	public Configuration() {
		propertie = new Properties();
	}

	/**
	 * 初始化Configuration
	 * @param filePath 要读取的配置文件的路径+名称
	 */
	public Configuration(String filePath) {
		propertie = new Properties();
		try {
			inputFile=new InputStreamReader(this.getClass().getResourceAsStream(filePath), "UTF-8");
			//propertie.load(inputFile);
			inputFile.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取对应key的值
	 * @param key
	 * @return String
	 */
	public String getValue(String key){
		if(propertie.containsKey(key)){
			String value = propertie.getProperty(key);
			return value;
		}
		else return "";
	}
}
