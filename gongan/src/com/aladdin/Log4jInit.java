package com.aladdin;

import org.apache.log4j.PropertyConfigurator;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.io.IOException;
import java.util.Properties;


public class Log4jInit extends HttpServlet {
    public void init() {
        //通过web.xml来动态取得配置文件
        //String prefix = "";//getServletContext().getRealPath("/");
        String file = getInitParameter("log4j-init-file");
        InputStream is=getServletContext().getResourceAsStream(file);
        Properties props=new Properties();
        try {
            props.load(is);

        } catch (IOException e) {
            System.err.println("没有找到 log4j 文件");
            e.printStackTrace();
        }
        //如果没有给出相应的配置文件，则不进行初始化
        PropertyConfigurator.configure(props);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) {

    }

}
