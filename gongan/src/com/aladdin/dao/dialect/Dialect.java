package com.aladdin.dao.dialect;

public interface Dialect {
    public boolean supportsLimit();

    public String getLimitString(String sql, boolean hasOffset);
    public String getCountString(String sql);
    public String getLimitString(String sql, int offset, int limit);
}