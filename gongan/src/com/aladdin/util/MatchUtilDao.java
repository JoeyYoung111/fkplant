package com.aladdin.util;

import java.util.List;


/**
 * Created by IntelliJ IDEA. User: zhaoguang Date: 2009-7-6 Time: 17:25:24 To
 * change this template use File | Settings | File Templates.
 */
public interface MatchUtilDao {
    /**
     * 根据匹配的字段名，到对应的数据表内查找匹配的字段内容
     * suggest的用法
     *
     * @param fieldname
     * @param matchstr
     * @return
     */
    public List findMatchContents(String fieldname, String matchstr);

    /**
     * 根据匹配的字段名，到对应的数据表内查找匹配的字段内容
     * suggest的用法
     *
     * @param fieldname
     * @param matchstr
     * @return
     */
    public List findMatchContents1(String fieldname, String matchstr);

    /**
     * 自动获取拼音头
     *
     * @param s
     * @return
     */
    public String getStringHead(String s);

}
