package com.aladdin.util;
/**
 * 导出公用类
 * @author lenovo
 *
 */
public class TextField {
	//common properties
    private String columnName;
    private String fieldName;
    private String pattern;

    //excel properties
    private int xls_columnView;
    //pdf properties
    private float width;
    private float height;
    private float horizontalAlignment;
    private float verticalAlignment;
    private float pdf_columnWidth = 0.2f;

    public TextField() {
    }

    public TextField(String fieldName) {
        this.fieldName = fieldName;
    }

    public TextField(String columnName, String fieldName) {
        this.columnName = columnName;
        this.fieldName = fieldName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getPattern() {
        return pattern;
    }

    public void setPattern(String pattern) {
        this.pattern = pattern;
    }

    public float getWidth() {
        return width;
    }

    public void setWidth(float width) {
        this.width = width;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public float getHorizontalAlignment() {
        return horizontalAlignment;
    }

    public void setHorizontalAlignment(float horizontalAlignment) {
        this.horizontalAlignment = horizontalAlignment;
    }

    public float getVerticalAlignment() {
        return verticalAlignment;
    }

    public void setVerticalAlignment(float verticalAlignment) {
        this.verticalAlignment = verticalAlignment;
    }

    public int getXls_columnView() {
        return xls_columnView;
    }

    public void setXls_columnView(int xls_columnView) {
        this.xls_columnView = xls_columnView;
    }

    public float getPdf_columnWidth() {
        return pdf_columnWidth;
    }

    public void setPdf_columnWidth(float pdf_columnWidth) {
        this.pdf_columnWidth = pdf_columnWidth;
    }
}
