package com.szrj.business.dao.interfaces;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;

public class SendChat {
	
    public static String doHttpGet(String httpUrl) {
    	
	    HttpGet httpGet = new HttpGet(httpUrl);
		HttpClient httpClient = new DefaultHttpClient();
		HttpResponse httpResponse;
		StringBuffer result = new StringBuffer();
		try {
			httpResponse = httpClient.execute(httpGet);
		
		HttpEntity httpEntity = httpResponse.getEntity();
		InputStreamReader reader;
	  reader = new InputStreamReader(httpEntity.getContent());
		
		char[] buff = new char[1024];
		int length=0;
		
		 while((length=reader.read(buff))!=-1){
			result.append(buff,0,length);
		}
    	
      } catch (Exception e) {
		  e.printStackTrace();
	  } 
	  return result.toString();
 }   
    
   /**\
    * POST post方法
    * 参数必须为json格式
    * @param url
    * @param json
    * @return
    */
    public static String doHttpPost(String url,String json) {
		String result = null;
		CloseableHttpClient httpClient=HttpClients.createDefault();
		ResponseHandler<String> responseHandler=new BasicResponseHandler();
		try {
		httpClient=HttpClients.createDefault();
		HttpPost httpPost=new HttpPost(url);
		StringEntity stringEntity=new StringEntity(json,"utf-8");
		stringEntity.setContentEncoding("UTF-8");
		httpPost.setHeader("Content-type", "application/json");
		httpPost.setEntity(stringEntity);
		
			result=httpClient.execute(httpPost,responseHandler);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		finally {
			try {
				httpClient.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	} 
   
}
