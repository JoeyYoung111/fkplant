package com.aladdin.util;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
 
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
public class PictureExcel {
	public static int count = 0;
    public static String OutPictruePath = "D:/kong_pictures";
 
    public static void main(String[] args) {
        List<String> urlList = getUrl();
        if (urlList != null) {
            System.out.println("userList.Size:" + urlList.size());
        } else {
            System.out.println("is error");
        }
 
    }
 
    /**
     * 从配置文件中读取出Excel文件的路径
     *
     * @return
     */
    public static String getPath() {
        String filePath = null;
        filePath = "D:/kong_pictures/kong_0530_xls.xls";
        return filePath;
    }
 
    /**
     * 获得图片URL集合
     * jxl只支持xls格式的excel
     *
     * @return
     */
    public static List<String> getUrl() {
        List<String> urlList =new ArrayList<String>();
        Sheet sheet = null;
        String filePath = getPath();
        InputStream in = null;
        InputStream in2outPictrue = null;
        try {
            File file = new File(filePath);
            in = new FileInputStream(file.getAbsolutePath());
            Workbook workbook = Workbook.getWorkbook(in);
            int sheet_size = workbook.getNumberOfSheets();//总共多少个页签
            System.out.println("sheet_size:" + sheet_size);
            for (int i = 0; i < sheet_size; i++) {
                sheet = workbook.getSheet(i);
                for (int j = 0; j < sheet.getRows(); j++) {
                    String name=sheet.getCell(0, j).getContents();
                    String card=sheet.getCell(1, j).getContents();
                	String url = sheet.getCell(2, j).getContents();
                    count++;
                    System.out.println("count:" + count+"-- "+name+"_"+card + "-->" + url);
                    if (url.equals("") || url == null) {
                    } else {
                        getPictrue(name,card,url,in);
//                            urlList.add(url);
                    }
                    url = null;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (BiffException e) {
            e.printStackTrace();
        } finally {
            try {
                if (in != null) in.close();
                if (in2outPictrue != null) in2outPictrue.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        System.out.println("filePath:" + filePath);
        return urlList;
    }
//    public static List<String> getUrl2() {
//        List<String> urlList = new ArrayList<>();
//        String filePath = getPath();
//        Sheet sheet = null;
//        Workbook workbook=null;
//        Row row = null;
//        int rownum = 0;//行数
//        int colnum = 0;//列数
//        InputStream in = null;
//        try {
//            File file = new File(filePath);
//            in = new FileInputStream(file.getAbsolutePath());
//            try {
//                workbook = WorkbookFactory.create(in);
//            } catch (InvalidFormatException e) {
//                e.printStackTrace();
//            }
//
//            int sheet_size = workbook.getNumberOfSheets();
//            System.out.println("sheet_size:" + sheet_size);
//            for (int i = 0; i < sheet_size; i++) {
//                sheet = workbook.getSheetAt(i);
//                rownum = sheet.getPhysicalNumberOfRows();//获取行数
//                row = sheet.getRow(0);//获取第一行，之后获得列数
//                colnum = row.getPhysicalNumberOfCells();//获得列数
//                for (int j = 1; j < rownum; j++) {
//                    row = sheet.getRow(j);
//                    if (row != null) {
//                        for (int k = 0; k < colnum; k++) {
//                            Cell cell = row.getCell(k); //这里已经确认将要获取的数据是String类型，所以不用判断Cell的类型
//                            String url = cell.getStringCellValue();
//                            System.out.println("j---------》》》"+url);
//                            urlList.add(url);
//                            if (url.equals("") || url == null) {
//                            } else {
//                                urlList.add(url);
//                            }
//                            url = null;
//                        }
//                    }
//                }
//                sheet=workbook.getSheetAt(i);
//                for (int j = 0; j < sheet.getPhysicalNumberOfRows(); j++) { //行数
 
//                    for (int k = 0; k < ; k++) {
//                        String url=sheet.getCell(k,j).getContents();
//                        System.out.println("i,j:"+url);
//                        if (url.equals("")||url==null){
//                        }else {
//                            urlList.add(url);
//                        }
//                        url=null;
//                    }
//                }
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (in != null) in.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//        System.out.println("filePath:" + filePath);
//        return urlList;
//    }
 
    /**
     * 将图片写入磁盘
     *
     * @param url
     * @param in2outPictrue
     * @throws UnsupportedEncodingException 
     */
    public static void getPictrue(String name,String card,String url, InputStream in2outPictrue) throws UnsupportedEncodingException {
        if (url.length() > 7) {
            in2outPictrue = null;
            OutputStream out = null;
            String filePath = null;
            String[] urls=url.split("\\.");
            int len=urls.length-1;
            String pictureType = urls[len];
            if (OutPictruePath != null) {
                filePath = OutPictruePath + "/" + name+"_"+card+"."+pictureType;
            } else {
                return;
            }
            File file = new File(filePath);
            in2outPictrue = getPictrueInputStream(url, in2outPictrue);
            if (in2outPictrue != null) {
                try {
                    out = new FileOutputStream(file);
                    byte[] b = new byte[1024];
                    int n = 0;
                    while ((n = in2outPictrue.read(b)) != -1) {
                        out.write(b, 0, n);
                    }
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (out != null) out.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                System.out.println("in2outPictrue is null!");
                return;
            }
 
            System.out.println(pictureType);
        } else {
            return;
        }
    }
 
    /**
     * 创建URL连接，获取图片输入流
     *
     * @param url
     * @param in
     * @return
     * @throws UnsupportedEncodingException 
     */
    public static InputStream getPictrueInputStream(String url, InputStream in) throws UnsupportedEncodingException {
        try {
        	String[] urls=url.split("/");
        	String newurl="";
        	for (int i = 0; i < urls.length; i++) {
        		if(i!=0)newurl+="/";
        		if(i<urls.length-1)newurl+=urls[i];
        		else newurl+=java.net.URLEncoder.encode(urls[i],"UTF-8");
			}
            URL urlConn = new URL(newurl);
            try {
                HttpURLConnection conn = (HttpURLConnection) urlConn.openConnection();
                conn.setRequestMethod("GET");
                conn.setReadTimeout(5000);
                if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                    in = conn.getInputStream();
                    return in;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
