package com.szrj.business.dao.interfaces;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Date;
import java.util.UUID;



public class ShortMessageDao {
	   //private static final String connectionURL = "jdbc:mysql://50.64.130.123:3306/csaqys-wen?useUnicode=true&characterEncoding=UTF8&useSSL=false";
	   private static final String connectionURL = "jdbc:mysql://50.64.128.5:3306/massi?useUnicode=true&characterEncoding=UTF8&useSSL=false";
	   private static final String username = "root";
	   private static final String password = "rootcmcc2017";
	   //创建数据库的连接
	    public static Connection getConnection() {
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            return   DriverManager.getConnection(connectionURL,username,password);
	        } catch (Exception e) {
	            
	            e.printStackTrace();
	        }
	        return null;
	    }
	    //关闭数据库的连接
	    public static void close(ResultSet rs,Statement stmt,Connection con) throws SQLException {
	        if(rs!=null)
	            rs.close();
	        if(stmt!=null)
	            stmt.close();
	        if(con!=null)
	            con.close();
	    }
	    public static void sendmessage(String destaddr,String messagecontent) throws SQLException {
	        //注册驱动    使用驱动连接数据库
	        Connection con = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;
	       
	        try {
	            con = ShortMessageDao.getConnection();
	           // String sql = "insert into sys_buttons_t(id,buttons) values(?,?)";
	            String sql="insert into sms_outbox(SISMSID,EXTCODE,DESTADDR,MESSAGECONTENT,REQDELIVERYREPORT,MSGFMT,SENDMETHOD,REQUESTTIME,APPLICATIONID)" +
	            		" values(?,?,?,?,?,?,?,?,?)";
	            stmt = con.prepareStatement(sql);
	            stmt.setString(1, UUID.randomUUID().toString());
	            stmt.setString(2, "003");
	            stmt.setString(3, destaddr);//接受手机号
	            stmt.setString(4, messagecontent);//短信内容
	            stmt.setInt(5, 0);
	            stmt.setInt(6, 15);
	            stmt.setInt(7, 1);
	            stmt.setDate(8, new java.sql.Date(new Date().getTime()));
	            stmt.setString(9, "p202103081527373");
	            
	            int result =stmt.executeUpdate();// 返回值代表收到影响的行数
	            System.out.println("调用接口短信发送完成======="+result);
	        } catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }finally {
	        	ShortMessageDao.close(rs, stmt, con);
	        }
	    }
	    
	    
	    public static void main(String[] args) {
	    	try {
	    		ShortMessageDao.sendmessage("18861713648","【风控平台】测试短信发送。。。");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
}
