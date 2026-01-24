package com.aladdin.model;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chapter;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.DottedLineSeparator;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

public class FILE2PDF {
	static final int CHAPTER = 0;
	static final int SECTION = 1;
	
	static final int CHAPTER_FONT_SIZE = 24;
	
	static final int wdDoNotSaveChanges = 0;	// 不保存待定的更改。
	static final int wdFormatPDF = 17;			// PDF格式
	static final int ppFormatPDF = 32;			// PPT格式

	
	
	/**
	 * Word文档转换为PDF
	 * @param srcFileName 要转换的Word文件名
	 * @param dstFileName 生成的PDF目标目录
	 */
	public static String word2Pdf(String srcFilePath, String dstPdfPath){
		String filename = srcFilePath;
		String toFilename = dstPdfPath;
		long start = System.currentTimeMillis();
		ActiveXComponent app = null;
		try {
			app = new ActiveXComponent("Word.Application");
			app.setProperty("Visible", false);
			Dispatch docs = app.getProperty("Documents").toDispatch();
			
			Dispatch doc = Dispatch.call(docs,//
					"Open", 	//
					filename,	// FileName
					false,		// ConfirmConversions
					true 		// ReadOnly
					).toDispatch();

			
			File tofile = new File(toFilename);
			if (tofile.exists()) {
				tofile.delete();
			}
			Dispatch.call(doc,		//
					"SaveAs", 		//
					toFilename, 	// FileName
					wdFormatPDF);
			Dispatch.call(doc, "Close", false);//, false);
			long end = System.currentTimeMillis();
			
		} catch (Exception e) {
			
		} finally {
			if (app != null)
				app.invoke("Quit", wdDoNotSaveChanges);
		}
		return dstPdfPath;
	}
	
	/**
	 * Excel表格转换为PDF
	 * @param srcFileName 要转换的EXCEL文件名
	 * @param dstFileName 生成的PDF目标目录
	 */
	public static String excel2Pdf(String srcFilePath, String dstPdfPath){	      
	      Dispatch sheet = null;  
	      Dispatch sheets = null;
	      Dispatch excel = null;
	      ActiveXComponent actcom = new ActiveXComponent("Excel.Application");
	      List<InputStream> subPdfs = new ArrayList<InputStream>(); 
	      List<String> subPdfsTitle = new ArrayList<String>();  
	      try{
	    	  actcom.setProperty("Visible", new Variant(false));
	    	  Dispatch excels = actcom.getProperty("Workbooks").toDispatch();
 	    	  excel = Dispatch.invoke(
    			  excels,
    			  "Open",
    			  Dispatch.Method,
    			  new Object[]{ 
    					  srcFilePath, 
    					  new Variant(false), 
    					  new Variant(true)		// ReadOnly
    			  },
    			  new int[9]
	    	  ).toDispatch();
	    	  sheets= Dispatch.get(excel, "Sheets").toDispatch();	             
	          int count = Dispatch.get(sheets, "Count").getInt();  
	          for (int j = 1; j <= count; j++) {
	        	  sheet = Dispatch.invoke(
	        			  sheets, 
	        			  "Item", 
	        			  Dispatch.Get,
	        			  new Object[] { new Integer(j) }, 
	        			  new int[1]
	        			  ).toDispatch(); 
	        	  String sheetname = Dispatch.get(sheet, "name").toString();
	        	  Dispatch.call(sheet, "Activate");	
	        	  Dispatch.call(sheet, "Select");
	        	  String outFile = dstPdfPath + sheetname + j + ".PDF";
	        	  try{
	        		  Dispatch.invoke(
	 	        			  excel,
	 	        			  "SaveAs",
	 	        			  Dispatch.Method,
	 	        			  new Object[]{ 
	        					  outFile,
	        					  new Variant(57), 
	        					  new Variant(false),
	        					  new Variant(57), 
	        					  new Variant(57),
	        					  new Variant(false), 
	        					  new Variant(true),
	        					  new Variant(57), 
	        					  new Variant(false),
	        					  new Variant(true), 
	        					  new Variant(false) 
	 	        			  },
	 	        			  new int[1]);
	        	  }catch(Exception e){
	        		  
	        	  }
 	        	  
 	        	  subPdfs.add(new FileInputStream(outFile));
 	        	  subPdfsTitle.add(sheetname);
	          } // end for(j)           
	      }catch(Exception es){
	          es.printStackTrace();
	      }finally{
	    	  Dispatch.call(excel, "Close", new Variant(true));
	          if(actcom!=null){
	        	  actcom.invoke("Quit");
	        	  actcom=null;
	          } 
	          ComThread.Release();       
	          
	          /*
	          File ftemp=new File(srcFilePath);
	          ftemp.renameTo(new File(srcFilePath));
	          ftemp=new File(srcFilePath);
	          //temp.deleteOnExit();
	          ftemp=null;
	          */
	      }
	      
          try{
        	  File file = new File(dstPdfPath);  
              if (!file.getParentFile().exists()) {  
            	  file.getParentFile().mkdirs();  
              }
              OutputStream output = new FileOutputStream(dstPdfPath);  
    	      concatPDFs(subPdfs, subPdfsTitle, output, false, false, false, "",0);
    	      //System.out.println("转换完成：" + dstPdfPath);
          } catch(Exception e){
        	  dstPdfPath = null;
        	  e.printStackTrace();
          }	      
	      return dstPdfPath;
	}
	 
	
	/**
	 * PowerPoint文档转换为PDF
	 * @param srcFileName 要转换的PointPower文件名
	 * @param dstFileName 生成的PDF目标目录
	 */
	public static String ppt2Pdf(String srcFilePath, String dstPdfPath){
		String filename = srcFilePath;
		String toFilename = dstPdfPath;
		//System.out.println(toFilename);
		long start = System.currentTimeMillis();
		ActiveXComponent app = null;
		try {
			app = new ActiveXComponent("PowerPoint.Application");
			app.setProperty("Visible", new Variant(true));
			Dispatch ppts = app.getProperty("Presentations").toDispatch();
			//System.out.println("打开文档..." + filename);
			Dispatch ppt = Dispatch.call(ppts,//
					"Open", 	//
					filename,	// FileName
					false,		// ConfirmConversions
					true 		// ReadOnly
					).toDispatch();

			////System.out.println("转换文档到PDF..." + toFilename);
			File tofile = new File(toFilename);
			if (tofile.exists()) {
				tofile.delete();
			}
			Dispatch.call(ppt,		//
					"SaveAs", 		//
					toFilename, 	// FileName
					ppFormatPDF);

			Dispatch.call(ppt, "Close", false);
			long end = System.currentTimeMillis();
			////System.out.println("转换完成..用时：" + (end - start) + "ms.");
		} catch (Exception e) {
			////System.out.println("========Error:文档转换失败：" + e.getMessage());
		} finally {
			if (app != null)
				app.invoke("Quit");
		}
		return dstPdfPath;
	}
	
	 public String getDateStr(){
	    Calendar cl=Calendar.getInstance();
	    cl.setTime(new Date());
	    String str=cl.get(Calendar.YEAR)+""+(cl.get(Calendar.MONTH)+1)+""
	    +cl.get(Calendar.DATE)+""+cl.get(Calendar.HOUR)+""+cl.get(Calendar.MINUTE)+""
	    +cl.get(Calendar.SECOND); 
	    return str;
	 }
	 
	/**
	 * 将文件夹中的所有XLS转换为PDF
	 * @param path 文件夹路径，如：D:/test/
	 */
	public void convertAllXls(String path){
        try{
           File file=new File(path);
           
           if(file.exists()){
          	 
        	   String fileName = "";
        	   String appdex = "";
	       	    File temp=null;
	       	    try{
	       		 File [] list=new File(path).listFiles(new FileFilter(){
	       		    public boolean accept(File pathname) {
	       		        boolean x = false;
	       		        if (pathname.getName().toLowerCase().endsWith(".XLS")) {
	       		                 x = true;
	       		            }
	       		            return x;
	       		        }
	       		 });
	       	     ////System.out.println((new Date()).toString()+"  Total Convert File : "+list.length);
	       	     for(int i=0;i<list.length;i++){
	       	    	 fileName=list[i].getName().substring(0, list[i].getName().indexOf("."));
	       		      appdex=list[i].getName().substring(list[i].getName().indexOf("."));
	       		      temp=new File(path+fileName+".PDF");
	       		      if(temp.exists()){
	       		    	  temp.renameTo(new File(path+fileName+"-"+getDateStr()+".PDF"));
	       		      }
	       		      
	       		      ComThread.InitSTA();
	       		      String filePath = path+fileName+appdex;
	       		      
	       	     }
	       	    }catch(Exception ex){
	       	     ex.printStackTrace();
	       	    }
                
           }else{
          	 
           ////System.out.println("Path Not Exist,Pls Comfirm: "+path);
           
           }
	     }catch(Exception ex){	  	   
	           ////System.out.println("Pls Check Your Format,Format Must Be: java com/olive/util/RunTask Path(Exist Path) Frequency(Run Frequency,int)");
	           ex.printStackTrace();
	     }
	}
	
	/**
	 * Excel表格转换为PDF
	 * @param srcFileName 要转换的图像文件名
	 * @param dstFileName 生成的PDF目标目录
	 */
	public static String image2Pdf(String srcFilePath, String dstPdfPath){
		// 先创建一个Document文档对象  
		Document document = new Document();
		try {  
			// PDF文件和图片文件路径  
			String filePath = dstPdfPath;  
			String imagePath = srcFilePath;  
			// 生成test.pdf文档  
			PdfWriter.getInstance(document, new FileOutputStream(filePath));     
			// 添加PDF文档的某些信息，比如作者，主题等等  
			document.addAuthor("www.jsywsz.com");  
			document.addSubject("test pdf.");  
			// 设置文档的大小  
			// document.setPageSize(PageSize.A5);  
			// 打开文档  
			document.open();  
			// 写入一段文字 
			document.add(new Paragraph("测试.."));  
			// 读取一个图片  
			Image image = Image.getInstance(imagePath);  
			   float width =	image.getPlainWidth();
			   float height =	image.getPlainHeight();
			   float A4width =	PageSize.A4.getWidth();
			   float A4height = PageSize.A4.getHeight();
			if (width > height)
			image.setRotationDegrees(90);
			image.setAlignment(Image.MIDDLE);
			image.scaleToFit(A4width-100, A4height-100);
			// 插入一个图片  
			document.add(image);  
			////System.out.println(filePath+"文件已生成");
		} catch (DocumentException de) {
			////System.out.println(de.getMessage());  
		} catch (IOException ioe) {
			////System.out.println(ioe.getMessage());  
		}
		// 关闭打开的PDF文档  
		document.close(); 
		
		return dstPdfPath;
	}
	
	public static void addMenu(Document document, List<String> titleOfPDFFiles, List<PdfReader> readers) throws DocumentException, IOException{
		BaseFont bfCN;
		bfCN = BaseFont.createFont("C:\\WINDOWS\\Fonts\\simsun.ttc,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Iterator<PdfReader> iteratorPDFReader = readers.iterator();  
		Iterator<String> iteratorTitles = titleOfPDFFiles.iterator(); 
        List<Integer> menuPages = new ArrayList<Integer>();
        List<String> pdfTitles = new ArrayList<String>();
        int currentPageNumber = 0;
        int pageOfCurrentReaderPDF = 0;
        String previousTitle = "";
		while (iteratorPDFReader.hasNext()) {
			PdfReader pdfReader = iteratorPDFReader.next();
			String pdfTitle = iteratorTitles.hasNext() ? iteratorTitles.next() : "";
			if (previousTitle.equals("")||(!previousTitle.equals(pdfTitle))){
				pdfTitles.add(pdfTitle);
				currentPageNumber++;
				menuPages.add(currentPageNumber);
				previousTitle = pdfTitle;
			}
			while (pageOfCurrentReaderPDF < pdfReader.getNumberOfPages()) {
				pageOfCurrentReaderPDF++;  
				currentPageNumber++;  
			}
			pageOfCurrentReaderPDF = 0;  
		}
		document.setMargins(50, 50, 50, 50);
		document.newPage();
		Font f1 = new Font(bfCN, 30);
		Font f2 = new Font(bfCN, 15);
		Paragraph menu = new Paragraph("目录", f1);
		menu.setAlignment(Element.ALIGN_CENTER);
		document.add(menu);
		if (pdfTitles.size() > 0 && menuPages.size() > 0) {
			for (int i = 0; i < pdfTitles.size(); i++) {
				DottedLineSeparator dos = new DottedLineSeparator();
				dos.setAlignment(Element.ALIGN_MIDDLE);
				Paragraph p2 = new Paragraph((i+1) + "、" + pdfTitles.get(i), f2);
				p2.add(new Chunk(dos));
				p2.add(menuPages.get(i).toString());
				document.add(p2);
			}
		}
	}
	/**
	 * 合成多个PDF
	 * @param streamOfPDFFiles	欲合成的PDF文件流
	 * @param outputStream		合成文件输出流
	 * @param paginate			是否输出页码
	 */
	public static void concatPDFs(
			List<InputStream> streamOfPDFFiles, 
			List<String> titleOfPDFFiles,
			OutputStream outputStream, 
			boolean paginate,
			boolean addChapter,
			boolean addTitle,
			String  bookTitle,
			int titlenum)
	
	{  
        Document document = new Document(PageSize.A4, 50, 50, 50, 50);  
        try {
            List<InputStream> pdfs = streamOfPDFFiles;  
            List<PdfReader> readers = new ArrayList<PdfReader>();
            int totalPages = 0;
            Iterator<InputStream> iteratorPDFs = pdfs.iterator();    
            Iterator<String> iteratorTitles = titleOfPDFFiles.iterator();  
            
            // 创建阅读器集合
            while (iteratorPDFs.hasNext()) {  
                InputStream pdf = iteratorPDFs.next();  
                PdfReader pdfReader = new PdfReader(pdf);  
                readers.add(pdfReader);  
                totalPages += pdfReader.getNumberOfPages();
            }  
            totalPages += titlenum;
            // 为输出文件流创建Writer
            PdfWriter writer = PdfWriter.getInstance(document, outputStream);  
            document.open();
            BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            BaseFont bfCN = BaseFont.createFont("C:\\WINDOWS\\Fonts\\simsun.ttc,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font chFont = new Font(bfCN, CHAPTER_FONT_SIZE, Font.BOLD, BaseColor.BLACK);		// 章的字体            
            // Font secFont = new Font(bfCN, 12, Font.NORMAL, BaseColor.BLACK);		// 节的字体            
            // Font textFont = new Font(bfCN, 12, Font.NORMAL, BaseColor.BLACK);	// 正文的字体
            
            PdfContentByte cb = writer.getDirectContent(); 	// Holds the PDF
            
           
           
            PdfImportedPage page;
            int currentPageNumber = 0;
            int pageOfCurrentReaderPDF = 0;
            int chapterNumber = 0;
            Iterator<PdfReader> iteratorPDFReader = readers.iterator();  
            
            if(addTitle){
            	document.newPage();
            	cb.beginText();  
            	cb.setFontAndSize(bfCN,50);  
            	cb.showTextAligned(PdfContentByte.ALIGN_CENTER, 
            			bookTitle, 
            			document.getPageSize().getWidth()/2, document.getPageSize().getHeight()/2, 0); 
            	cb.endText();
           
            	cb.beginText();  
            	cb.setFontAndSize(bfCN,20);
            	SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日");
            	Date date = new Date();
            	String date2 = format.format(date);
            	cb.showTextAligned(PdfContentByte.ALIGN_CENTER, 
            			date2, 
            			document.getPageSize().getWidth()/2, 100, 0); 
            	cb.endText();
            	addMenu(document, titleOfPDFFiles, readers);
            }
            
      
			// 循环各个要合成的PDF
            String previousTitle = "";
            while (iteratorPDFReader.hasNext()) {
            	PdfReader pdfReader = iteratorPDFReader.next();
            	String pdfTitle = iteratorTitles.hasNext() ? iteratorTitles.next() : "";
            	
            	// 添加章节标题
            	if (addChapter&&(previousTitle.equals("")||(!previousTitle.equals(pdfTitle)))){
            		document.newPage();
                	currentPageNumber++;
                	Paragraph title = new Paragraph(pdfTitle, chFont);
                	title.setAlignment(Element.ALIGN_CENTER);
            		Chapter chapter = new Chapter(title, ++chapterNumber);
            		document.setPageSize(PageSize.A4);
            		document.setMargins(20, 20, document.getPageSize().getHeight() / 4, 20);
                	document.add(chapter);
                	document.setMargins(20, 20, 20, 20);
                	previousTitle = pdfTitle;
            	}            	
            	
            	// 一页页导入          	
                while (pageOfCurrentReaderPDF < pdfReader.getNumberOfPages()) {
                    pageOfCurrentReaderPDF++;  
                    currentPageNumber++;  
                    page = writer.getImportedPage(pdfReader, pageOfCurrentReaderPDF);
                    document.setPageSize(page.getBoundingBox());
                    document.newPage();
                    cb.addTemplate(page, 0, 0);
                    
                    // 添加页码 
                    if (paginate) {  
                        cb.beginText();  
                        cb.setFontAndSize(bf, 9);  
                        cb.showTextAligned(PdfContentByte.ALIGN_CENTER, 
                        		currentPageNumber + " / " + totalPages, 
                        		document.getPageSize().getWidth()-50, 10, 0);  
                        cb.endText();
                    }
                }  
                pageOfCurrentReaderPDF = 0;  
            }
            
            outputStream.flush();  
            document.close();  
            outputStream.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {
            if (document.isOpen())
                document.close();
            try {
                if (outputStream != null)
                    outputStream.close();
            } catch (IOException ioe) {
               ioe.printStackTrace();
            }
        }
	}
	
	/**
	 * 任意文件转PDF
	 * @param srcFilePath 欲转换的源文件全路径
	 * @param dstPdfPath 欲生成的PDF文件全路径
	 * @return 若可转换，则返回转换输出文件的全路径
	 */
	public static String any2Pdf(String srcFilePath, String dstPdfPath){
		//System.out.println("srcFilePath===="+srcFilePath+"    dstPdfPath===="+dstPdfPath);
		String finalDstPdfPath = null;
		if (srcFilePath.endsWith(".DOC") || srcFilePath.endsWith(".DOCX") || srcFilePath.endsWith(".TXT")){
			finalDstPdfPath = word2Pdf(srcFilePath, dstPdfPath);				
		}else if (srcFilePath.endsWith(".XLS") || srcFilePath.endsWith(".XLSX")){	
			srcFilePath = srcFilePath.replace('/', '\\');
			finalDstPdfPath = excel2Pdf(srcFilePath, dstPdfPath);
		}else if (srcFilePath.endsWith(".PPT") || srcFilePath.endsWith(".PPTX")){	
			srcFilePath = srcFilePath.replace('/', '\\');
			finalDstPdfPath = ppt2Pdf(srcFilePath, dstPdfPath);
		}else if (srcFilePath.endsWith(".JPG") || srcFilePath.endsWith(".PNG") || srcFilePath.endsWith(".GIF") || srcFilePath.endsWith(".BMP")){
			finalDstPdfPath = image2Pdf(srcFilePath, dstPdfPath);
		}else if (srcFilePath.endsWith(".PDF")){
			finalDstPdfPath = srcFilePath;
		}
		//System.out.println("finalDstPdfPath===="+finalDstPdfPath);
		return finalDstPdfPath;
	}
	
	public static void mergePdf(String contextPath, List<String> upload, 
			List<String> uploadName, String pdfTitle, String outputFileName) {
		
		ArrayList<String> uploadFiles = new ArrayList<String>();
		String tempFolderPath = contextPath + "image/temp/";
		String outputPdfPath = contextPath + "image/" + outputFileName + ".PDF";
		File f = new File(tempFolderPath);
		for(int i=0; i<upload.size(); i++){
			uploadFiles.add( contextPath + upload.get(i));
		}
		try{
			if(!f.exists())
				f.mkdir();
			List<InputStream> pdfs = new ArrayList<InputStream>();
			List<String> pdfsTitle = new ArrayList<String>();
			for (int i=0; i < uploadFiles.size(); i++){
				String srcFilePath = uploadFiles.get(i);
				String title = uploadName.get(i);
				String tempPdfPath = tempFolderPath + title + i + ".PDF";
				tempPdfPath = any2Pdf(srcFilePath, tempPdfPath);
				if (null != tempPdfPath){
					pdfs.add(new FileInputStream(tempPdfPath));
					pdfsTitle.add(title);
				}
			}

	        File file = new File(outputPdfPath);  
	        if (!file.getParentFile().exists()) {  
	            file.getParentFile().mkdirs();  
	        }  
	        OutputStream output = new FileOutputStream(outputPdfPath);
	        String privTitle = "";
	        int titlenum = 0;
	        for(int i=0;i<uploadName.size();i++){
	        	if((privTitle.equals("")||(!privTitle.equals(uploadName.get(i))))){
	        		titlenum++;
	        		privTitle = uploadName.get(i);
	        	}
	        }
	        concatPDFs(pdfs, pdfsTitle, output, true, true, true, pdfTitle,titlenum);
	        ////System.out.println("合成完毕...");
	        File[] files = f.listFiles();
	        for(int i=0; i<files.length; i++){
	        	files[i].delete();
	        }
	        f.delete();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
