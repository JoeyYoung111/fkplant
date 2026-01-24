package com.aladdin.util;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.util.MatchUtilDao;


import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import org.springframework.util.StringUtils;
import org.springframework.dao.DataAccessException;

/**
 * Created by IntelliJ IDEA.
 * User: wangting
 * Date: 2009-7-6
 * Time: 16:49:06
 * To change this template use File | Settings | File Templates.
 */
public class MatchUtil extends BaseDaoiBatis implements MatchUtilDao {
    private Map matchfieldMap = new HashMap();
    private Map matchfieldMap1 = new HashMap();

    public Map getMatchfieldMap() {
        return matchfieldMap;
    }

    public void setMatchfieldMap(Map matchfieldMap) {
        this.matchfieldMap = matchfieldMap;
    }

    public Map getMatchfieldMap1() {
        return matchfieldMap1;
    }

    public void setMatchfieldMap1(Map matchfieldMap1) {
        this.matchfieldMap1 = matchfieldMap1;
    }

    /**
     * 根据匹配的字段名，到对应的数据表内查找匹配的字段内容
     * suggest的用法
     *
     * @param fieldname
     * @param matchstr
     * @return
     */
    public List findMatchContents(String fieldname, String matchstr) {
        String sql = (String) matchfieldMap.get(fieldname);
        if (sql != null) {
            sql = StringUtils.replace(sql, "{}", matchstr);
             // System.out.println("sql=="+sql);
            return getSqlMapClientTemplate().queryForList("common.match", sql);
        } else 
        	return new ArrayList();
    }

    /**
     * 根据匹配的字段名，到对应的数据表内查找匹配的字段内容
     * suggest列表的用法
     *
     * @param fieldname
     * @param matchstr
     * @return
     */
    public List findMatchContents1(String fieldname, String matchstr) {
        String sql = (String) matchfieldMap1.get(fieldname);
        System.out.println("sql===================="+sql);
        if (sql != null) {
            sql = StringUtils.replace(sql, "{}", matchstr);
            System.out.println("sql=="+sql);
            return getSqlMapClientTemplate().queryForList("common.match1", sql);
        } else 
        	return new ArrayList();
    }

    /**
     * 自动匹配拼音头
     *
     * @param s
     * @return
     */
    public String getStringHead(String s) {
        String ss = StringUtil.getFirstLetter(s);
        return ss;
    }

}