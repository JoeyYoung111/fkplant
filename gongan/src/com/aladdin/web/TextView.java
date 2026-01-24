package com.aladdin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.View;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.io.PrintWriter;
import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: wangting
 * Date: 2009-1-3
 * Time: 13:25:46
 * To change this template use File | Settings | File Templates.
 */
@Controller
public  class TextView implements View {
    public static final TextView instance = new TextView();

    public static final String TEXT_ROOT="root";



    public String getContentType() {
        return "text/html; charset=GBK";
    }

    public TextView() {

    }
    @SuppressWarnings("unchecked")
    public void  render(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String root=(String)model.get(TextView.TEXT_ROOT);
        if (root == null) {
	    throw new RuntimeException("TEXT root object with key '"
		    + TextView.TEXT_ROOT + "' not found in model");
	}
        response.setContentType("text/html;charset=GBK");
        PrintWriter writer=response.getWriter();
         writer.write(root);

    }


}