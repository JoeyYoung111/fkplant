package com.aladdin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter{
	private long loginFlag=3;
	public void destroy() {
		// TODO Auto-generated method stub
	}
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		session.setMaxInactiveInterval(60*30);
		// 登陆url
		String loginUrl = httpRequest.getContextPath() + "/login.jsp";
		//String loginUrl = httpRequest.getContextPath()+"/";
		String url = httpRequest.getRequestURI();
		String path = url.substring(url.lastIndexOf("/"));		
		System.out.println("+++++++++"+loginFlag+"+++++++++++++++++"+path+"+++++++++++");
		System.out.println("+++++++++"+loginFlag+"+++++++++++++++++"+session.getAttribute("LOGIN_SUCCESS")+"+++++++++++");
		// 超时处理，ajax请求超时设置超时状态，页面请求超时则返回提示并重定向
		//if (path.indexOf("jjbzBusinessManagement") != -1 &&path.indexOf(".do") != -1 && session.getAttribute("LOGIN_SUCCESS") == null) {
		//if (path.indexOf(".do") != -1 && session.getAttribute("LOGIN_SUCCESS") == null) {
		//if (path.indexOf("loginUser.do") == -1 && path.indexOf("toPageindex.do") == -1 && path.indexOf("searchmain.do") == -1 && path.indexOf(".do") != -1 && session.getAttribute("LOGIN_SUCCESS") == null) {
		if(path.indexOf("loginUser.do") != -1)loginFlag=0;
		if (loginFlag>2 && path.indexOf("updateLingwuUsers.do") == -1 && path.indexOf(".do") != -1 && session.getAttribute("LOGIN_SUCCESS") == null) {
			// 判断是否为ajax请求
			if (httpRequest.getHeader("x-requested-with") != null
					&& httpRequest.getHeader("x-requested-with")
					.equalsIgnoreCase("XMLHttpRequest")) {
				httpResponse.addHeader("sessionstatus", "timeOut");
				httpResponse.addHeader("loginPath", loginUrl);
				chain.doFilter(request, response);// 不可少，否则请求会出错
			} else {	
				String str = "<script language='javascript'>alert('长时间未操作！请重新登录');"
					+ "window.top.location.href='"
					+ loginUrl
					+ "';</script>";
				response.setContentType("text/html;charset=UTF-8");// 解决中文乱码
				try {
					PrintWriter writer = response.getWriter();
					writer.write(str);
					writer.flush();
					writer.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else {
			loginFlag++;
			chain.doFilter(request, response);
		}
	}
	public void init(FilterConfig arg0) throws ServletException {
	}
}
