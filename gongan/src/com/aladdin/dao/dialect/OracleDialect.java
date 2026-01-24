package com.aladdin.dao.dialect;


public class OracleDialect implements Dialect {
    protected static final String SQL_END_DELIMITER = ";";

    public boolean supportsLimit() {
        return true;
    }

    public String getLimitString(String sql, boolean hasOffset) {
        if (hasOffset)
            return new StringBuffer(sql.length() + 50).append("select * from (").append(trim(sql)).append(") where rownum>? and rownum<?").toString();      //.append(SQL_END_DELIMITER).
        else
            return new StringBuffer(sql.length() + 40).append("select * from (").append(trim(sql)).append(") where rownum<?").toString();               //.append(SQL_END_DELIMITER)

    }

    public String getLimitString(String sql, int offset, int limit) {
        sql = trim(sql);
        StringBuffer sb = new StringBuffer(sql.length() + 90);
        sb.append("SELECT * FROM  ( SELECT A.*, ROWNUM RN FROM (");
        sb.append(sql);
        if (offset < 0)
            offset = 0;
        int end = offset + limit;
        sb.append(") A WHERE ROWNUM <= ").append(end).append(") WHERE RN > ").append(offset);    //.append(SQL_END_DELIMITER)

        return sb.toString();
    }
      public String getCountString(String sql){
          String rtn = "";
          sql=trim(sql);
          int frompos= sql.indexOf("from");
          rtn="select count(*)  "+sql.substring(frompos);
          return rtn;
      }
    private String trim(String sql) {
        sql = sql.trim();
        if (sql.endsWith(SQL_END_DELIMITER)) {
            sql = sql.substring(0, sql.length() - 1 - SQL_END_DELIMITER.length());
        }
        return sql;
    }

}
