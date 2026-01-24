package com.aladdin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.View;

import com.szrj.business.model.User;
import com.szrj.business.model.personel.AttributeLabel;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver;

import com.aladdin.model.Message;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.io.PrintWriter;
import java.io.IOException;


@Controller
public class JsonView implements View {
    public static final JsonView instance = new JsonView();

    public static final String JSON_ROOT = "root";
    private XStream xstream = new XStream(new JettisonMappedXmlDriver());


    public String getContentType() {
        return null;
    }

    public JsonView() {

        xstream.processAnnotations(Message.class);
        xstream.alias("msg", Message.class);
        xstream.alias("user", User.class);
        xstream.alias("attributelabel", AttributeLabel.class);
    }

    @SuppressWarnings("unchecked")
    public void render(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Object root = model.get(JsonView.JSON_ROOT);
        String callback = request.getParameter("jsoncallback");
        if (root == null) {
            throw new RuntimeException("JSON root object with key '"
                    + JsonView.JSON_ROOT + "' not found in model");
        }
        response.setContentType("text/html;charset=GBK");
        PrintWriter writer = response.getWriter();
        String json = xstream.toXML(root);
        if (callback == null)
            writer.write(json);
        else
            writer.write(callback + "(" + json + ");");
    }

}
