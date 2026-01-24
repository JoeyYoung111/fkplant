package com.aladdin.dao.dialect;


public class MsSQL2000Dialect implements Dialect {
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
        sql = trim(sql,offset,limit);
        StringBuffer sb = new StringBuffer(sql.length() + 90);
        sb.append("select * from (SELECT top "+limit +" A.* FROM (");
        sb.append(sql);
        if (offset < 0)
            offset = 0;
        int end = offset + limit;
        sb.append(" order by id desc) A  order by id ) b order by id desc");    //.append(SQL_END_DELIMITER)

        return sb.toString();
    }
      public String getCountString(String sql){
          String rtn = "";
          sql = trim(sql);
           int frompos= sql.indexOf("from");
          rtn="select count(*)  "+sql.substring(frompos);
          return rtn;
      }
    private String trim(String sql, int offset, int limit) {
         sql = sql.trim();
         int end = offset + limit;
        sql="select top "+end +" "+sql.substring(7);
        if (sql.endsWith(SQL_END_DELIMITER)) {
            sql = sql.substring(0, sql.length() - 1 - SQL_END_DELIMITER.length());
        }
     //   sql=sql+" order by id desc";
        return sql;
    }
     private String trim(String sql) {
         sql = sql.trim();
        if (sql.endsWith(SQL_END_DELIMITER)) {
            sql = sql.substring(0, sql.length() - 1 - SQL_END_DELIMITER.length());
        }
     //   sql=sql+" order by id desc";
        return sql;
    }
}
