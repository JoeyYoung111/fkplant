package com.szrj.business.model.personel;

import java.io.Serializable;

public class ControlPower implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int personnelid;
    private String personname;
    private String sexes;
    private String cardnumber;
    private String workunit;
    private String workjob;
    private String mobile;
    private String addoperator;
    private String addtime;
    private String updateoperator;
    private String updatetime;
    private String memo;
    private int validflag;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPersonnelid() {
        return personnelid;
    }

    public void setPersonnelid(int personnelid) {
        this.personnelid = personnelid;
    }

    public String getPersonname() {
        return personname;
    }

    public void setPersonname(String personname) {
        this.personname = personname;
    }

    public String getSexes() {
        return sexes;
    }

    public void setSexes(String sexes) {
        this.sexes = sexes;
    }

    public String getCardnumber() {
        return cardnumber;
    }

    public void setCardnumber(String cardnumber) {
        this.cardnumber = cardnumber;
    }

    public String getWorkunit() {
        return workunit;
    }

    public void setWorkunit(String workunit) {
        this.workunit = workunit;
    }

    public String getWorkjob() {
        return workjob;
    }

    public void setWorkjob(String workjob) {
        this.workjob = workjob;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddoperator() {
        return addoperator;
    }

    public void setAddoperator(String addoperator) {
        this.addoperator = addoperator;
    }

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime;
    }

    public String getUpdateoperator() {
        return updateoperator;
    }

    public void setUpdateoperator(String updateoperator) {
        this.updateoperator = updateoperator;
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public int getValidflag() {
        return validflag;
    }

    public void setValidflag(int validflag) {
        this.validflag = validflag;
    }
}