package com.szrj.business.model.personel;

/**
 * 涉赌记录与案件关联表实体类
 * 对应表：p_zaperson_du_aj_rel_t
 */
public class ZaDuAjRel {
    private int id;
    private int duId;          // 涉赌记录ID (p_zaperson_du_t.id)
    private int personnelid;   // 人员ID (冗余字段，便于查询)
    private int ajId;          // 案件ID (f_xt_xd_ajxx_new.id)
    private String sldw;       // 打处单位 (f_xt_xd_ajxx_new.sldw)
    private String remark;     // 备注
    private int validflag;     // 状态 1有效 0无效
    private String addtime;    // 创建时间

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDuId() {
        return duId;
    }

    public void setDuId(int duId) {
        this.duId = duId;
    }

    public int getPersonnelid() {
        return personnelid;
    }

    public void setPersonnelid(int personnelid) {
        this.personnelid = personnelid;
    }

    public int getAjId() {
        return ajId;
    }

    public void setAjId(int ajId) {
        this.ajId = ajId;
    }

    public String getSldw() {
        return sldw;
    }

    public void setSldw(String sldw) {
        this.sldw = sldw;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getValidflag() {
        return validflag;
    }

    public void setValidflag(int validflag) {
        this.validflag = validflag;
    }

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }
}

