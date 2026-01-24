package com.aladdin.model;

import java.util.List;


public class NewPageModel {
    private int start;
    private int limit = 10;
    private int pageNumber = 1;
    private int allpagenum = 0;    //all page count
    private int total;          //all count of result
    private List rows;
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

        if (total % limit == 0) {
            this.setAllpagenum(total / limit);
        } else {
            this.setAllpagenum(total / limit + 1);
        }
        //}
       this.setTruepagesize(limit);
        if (pageNumber > allpagenum)
        	pageNumber = allpagenum;
        if (pageNumber < 1)
        	pageNumber= 1;
        if (pageNumber == allpagenum) {
            int lastpagesize = total % limit;  //设置最后一页的条数
            if (lastpagesize != 0) {
                this.setTruepagesize(lastpagesize);
            }
        }
        this.setStart((pageNumber - 1) * limit);

    }
    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getAllpagenum() {
		return allpagenum;
	}

	public void setAllpagenum(int allpagenum) {
		this.allpagenum = allpagenum;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}






 




}
