package com.aladdin.model;

import java.util.List;


public class PageModel {
    private int start;
    private int pagesize = 10;
    private int pagenum = 1;
    private int allpagenum = 0;    //all page count
    private int allcount;          //all count of result
    private List list;
    private int rows;
    private float sumweight = 0.0f;
    private int truepagesize ;

    public int getTruepagesize() {
        return truepagesize;
    }

    public void setTruepagesize(int truepagesize) {
        this.truepagesize = truepagesize;
    }

    public float getSumweight() {
        return sumweight;
    }

    public void setSumweight(float sumweight) {
        this.sumweight = sumweight;
    }


    public void setup() {
        //if(allpagenum==0){
        if (allcount % pagesize == 0) {
            this.setAllpagenum(allcount / pagesize);
        } else {
            this.setAllpagenum(allcount / pagesize + 1);
        }
        //}
       this.setTruepagesize(pagesize);
        if (pagenum > allpagenum)
            pagenum = allpagenum;
        if (pagenum < 1)
            pagenum = 1;
        if (pagenum == allpagenum) {
            int lastpagesize = allcount % pagesize;  //设置最后一页的条数
            if (lastpagesize != 0) {
                this.setTruepagesize(lastpagesize);
            }
        }
        this.setStart((pagenum - 1) * pagesize);

    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getAllcount() {
        return allcount;
    }

    public void setAllcount(int allcount) {
        this.allcount = allcount;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public int getPagesize() {

        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public int getPagenum() {

        return pagenum;
    }

    public void setPagenum(int pagenum) {
        this.pagenum = pagenum;
    }

    public int getAllpagenum() {
        return allpagenum;
    }

    public void setAllpagenum(int allpagenum) {
        this.allpagenum = allpagenum;
    }

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}
	
	@Override
	public String toString() {
	    return "PageModel{" +
	            "start=" + start +
	            ", pagesize=" + pagesize +
	            ", pagenum=" + pagenum +
	            ", allpagenum=" + allpagenum +
	            ", allcount=" + allcount +
	            ", list=" + list +
	            ", rows=" + rows +
	            ", sumweight=" + sumweight +
	            ", truepagesize=" + truepagesize +
	            '}';
	}

}
