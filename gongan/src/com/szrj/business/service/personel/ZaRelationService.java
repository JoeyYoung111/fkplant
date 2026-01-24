package com.szrj.business.service.personel;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.personel.ZaExtendDao;
import com.szrj.business.model.personel.ZaDu;
import com.szrj.business.model.personel.ZaChang;
import com.szrj.business.model.personel.ZaPei;
import com.szrj.business.model.personel.ZaDuAjRel;
import com.szrj.business.model.personel.ZaDuJqRel;
import com.szrj.business.model.personel.ZaChangAjRel;
import com.szrj.business.model.personel.ZaChangJqRel;
import com.szrj.business.model.personel.ZaPeiAjRel;
import com.szrj.business.model.personel.ZaPeiJqRel;

/**
 * 治安人员关联关系业务逻辑层
 * 实现涉赌/涉娼/陪侍记录与案件/警情的关联管理
 */
@Service
public class ZaRelationService {

    @Autowired
    private ZaExtendDao zaExtendDao;

    // ========== 涉赌相关 ==========

    /**
     * 保存或更新涉赌记录及其关联的案件
     * @param zaDu 涉赌记录实体
     * @param ajIds 选中的案件ID列表
     */
    @Transactional
    public void saveZaDuWithAjRelations(ZaDu zaDu, List<Integer> ajIds) {
        // 1. 保存或更新涉赌主记录
        if (zaDu.getId() == 0) {
            zaExtendDao.addZaDu(zaDu);
        } else {
            zaExtendDao.updateZaDu(zaDu);
            // 2. 如果是更新，先清理该涉赌记录原有的关联
            zaExtendDao.deleteByDuId(zaDu.getId());
        }

        // 3. 插入新的关联关系
        if (ajIds != null && !ajIds.isEmpty()) {
            List<ZaDuAjRel> relList = new ArrayList<ZaDuAjRel>();
            String addtime = TimeFormate.getISOTimeToNow();
            for (Integer ajId : ajIds) {
                ZaDuAjRel rel = new ZaDuAjRel();
                rel.setDuId(zaDu.getId());
                rel.setPersonnelid(zaDu.getPersonnelid());
                rel.setAjId(ajId);
                rel.setValidflag(1);
                rel.setAddtime(addtime);
                // 可以根据 ajId 查出对应的 sldw 填充
                relList.add(rel);
            }
            zaExtendDao.batchInsertDuAjRel(relList);
        }
    }

    /**
     * 保存或更新涉赌记录及其关联的警情
     * @param zaDu 涉赌记录实体
     * @param jqIds 选中的警情ID列表
     */
    @Transactional
    public void saveZaDuWithJqRelations(ZaDu zaDu, List<Integer> jqIds) {
        // 1. 保存或更新涉赌主记录
        if (zaDu.getId() == 0) {
            zaExtendDao.addZaDu(zaDu);
        } else {
            zaExtendDao.updateZaDu(zaDu);
            // 2. 如果是更新，先清理该涉赌记录原有的关联
            zaExtendDao.deleteDuJqByDuId(zaDu.getId());
        }

        // 3. 插入新的关联关系
        if (jqIds != null && !jqIds.isEmpty()) {
            List<ZaDuJqRel> relList = new ArrayList<ZaDuJqRel>();
            String addtime = TimeFormate.getISOTimeToNow();
            for (Integer jqId : jqIds) {
                ZaDuJqRel rel = new ZaDuJqRel();
                rel.setDuId(zaDu.getId());
                rel.setPersonnelid(zaDu.getPersonnelid());
                rel.setJqId(jqId);
                rel.setValidflag(1);
                rel.setAddtime(addtime);
                // 可以根据 jqId 查出对应的 cjdw 填充
                relList.add(rel);
            }
            zaExtendDao.batchInsertDuJqRel(relList);
        }
    }

    /**
     * 根据涉赌记录ID查询关联的案件列表
     */
    public List<Object> getAjListByDuId(int duId) {
        return zaExtendDao.findAjByDuId(duId);
    }

    /**
     * 根据涉赌记录ID查询关联的警情列表
     */
    public List<Object> getJqListByDuId(int duId) {
        return zaExtendDao.findJqByDuId(duId);
    }

    /**
     * 根据案件ID查询关联的涉赌记录列表
     */
    public List<ZaDu> getDuListByAjId(int ajId) {
        return zaExtendDao.findDuByAjId(ajId);
    }

    /**
     * 根据警情ID查询关联的涉赌记录列表
     */
    public List<ZaDu> getDuListByJqId(int jqId) {
        return zaExtendDao.findDuByJqId(jqId);
    }

    /**
     * 根据人员ID查询关联的所有涉赌案件
     */
    public List<Object> getAjListByPersonnelId(int personnelId) {
        return zaExtendDao.findAjByPersonnelId(personnelId);
    }

    /**
     * 根据人员ID查询关联的所有涉赌警情
     */
    public List<Object> getJqListByPersonnelId(int personnelId) {
        return zaExtendDao.findJqByPersonnelId(personnelId);
    }

    // ========== 涉娼相关 ==========

    /**
     * 保存或更新涉娼记录及其关联的案件
     */
    @Transactional
    public void saveZaChangWithAjRelations(ZaChang zaChang, List<Integer> ajIds) {
        if (zaChang.getId() == 0) {
            zaExtendDao.addZaChang(zaChang);
        } else {
            zaExtendDao.updateZaChang(zaChang);
            zaExtendDao.deleteByChangId(zaChang.getId());
        }

        if (ajIds != null && !ajIds.isEmpty()) {
            List<ZaChangAjRel> relList = new ArrayList<ZaChangAjRel>();
            String addtime = TimeFormate.getISOTimeToNow();
            for (Integer ajId : ajIds) {
                ZaChangAjRel rel = new ZaChangAjRel();
                rel.setChangId(zaChang.getId());
                rel.setPersonnelid(zaChang.getPersonnelid());
                rel.setAjId(ajId);
                rel.setValidflag(1);
                rel.setAddtime(addtime);
                relList.add(rel);
            }
            zaExtendDao.batchInsertChangAjRel(relList);
        }
    }

    /**
     * 保存或更新涉娼记录及其关联的警情
     */
    @Transactional
    public void saveZaChangWithJqRelations(ZaChang zaChang, List<Integer> jqIds) {
        if (zaChang.getId() == 0) {
            zaExtendDao.addZaChang(zaChang);
        } else {
            zaExtendDao.updateZaChang(zaChang);
            zaExtendDao.deleteChangJqByChangId(zaChang.getId());
        }

        if (jqIds != null && !jqIds.isEmpty()) {
            List<ZaChangJqRel> relList = new ArrayList<ZaChangJqRel>();
            String addtime = TimeFormate.getISOTimeToNow();
            for (Integer jqId : jqIds) {
                ZaChangJqRel rel = new ZaChangJqRel();
                rel.setChangId(zaChang.getId());
                rel.setPersonnelid(zaChang.getPersonnelid());
                rel.setJqId(jqId);
                rel.setValidflag(1);
                rel.setAddtime(addtime);
                relList.add(rel);
            }
            zaExtendDao.batchInsertChangJqRel(relList);
        }
    }

    /**
     * 根据涉娼记录ID查询关联的案件列表
     */
    public List<Object> getAjListByChangId(int changId) {
        return zaExtendDao.findAjByChangId(changId);
    }

    /**
     * 根据涉娼记录ID查询关联的警情列表
     */
    public List<Object> getJqListByChangId(int changId) {
        return zaExtendDao.findJqByChangId(changId);
    }

    /**
     * 根据案件ID查询关联的涉娼记录列表
     */
    public List<ZaChang> getChangListByAjId(int ajId) {
        return zaExtendDao.findChangByAjId(ajId);
    }

    /**
     * 根据警情ID查询关联的涉娼记录列表
     */
    public List<ZaChang> getChangListByJqId(int jqId) {
        return zaExtendDao.findChangByJqId(jqId);
    }

    /**
     * 根据人员ID查询关联的所有涉娼案件
     */
    public List<Object> getChangAjListByPersonnelId(int personnelId) {
        return zaExtendDao.findChangAjByPersonnelId(personnelId);
    }

    /**
     * 根据人员ID查询关联的所有涉娼警情
     */
    public List<Object> getChangJqListByPersonnelId(int personnelId) {
        return zaExtendDao.findChangJqByPersonnelId(personnelId);
    }

    // ========== 陪侍相关 ==========

    /**
     * 保存或更新陪侍记录及其关联的案件
     */
    @Transactional
    public void saveZaPeiWithAjRelations(ZaPei zaPei, List<Integer> ajIds) {
        if (zaPei.getId() == 0) {
            zaExtendDao.addZaPei(zaPei);
        } else {
            zaExtendDao.updateZaPei(zaPei);
            zaExtendDao.deleteByPeiId(zaPei.getId());
        }

        if (ajIds != null && !ajIds.isEmpty()) {
            List<ZaPeiAjRel> relList = new ArrayList<ZaPeiAjRel>();
            String addtime = TimeFormate.getISOTimeToNow();
            for (Integer ajId : ajIds) {
                ZaPeiAjRel rel = new ZaPeiAjRel();
                rel.setPeiId(zaPei.getId());
                rel.setPersonnelid(zaPei.getPersonnelid());
                rel.setAjId(ajId);
                rel.setValidflag(1);
                rel.setAddtime(addtime);
                relList.add(rel);
            }
            zaExtendDao.batchInsertPeiAjRel(relList);
        }
    }

    /**
     * 保存或更新陪侍记录及其关联的警情
     */
    @Transactional
    public void saveZaPeiWithJqRelations(ZaPei zaPei, List<Integer> jqIds) {
        if (zaPei.getId() == 0) {
            zaExtendDao.addZaPei(zaPei);
        } else {
            zaExtendDao.updateZaPei(zaPei);
            zaExtendDao.deletePeiJqByPeiId(zaPei.getId());
        }

        if (jqIds != null && !jqIds.isEmpty()) {
            List<ZaPeiJqRel> relList = new ArrayList<ZaPeiJqRel>();
            String addtime = TimeFormate.getISOTimeToNow();
            for (Integer jqId : jqIds) {
                ZaPeiJqRel rel = new ZaPeiJqRel();
                rel.setPeiId(zaPei.getId());
                rel.setPersonnelid(zaPei.getPersonnelid());
                rel.setJqId(jqId);
                rel.setValidflag(1);
                rel.setAddtime(addtime);
                relList.add(rel);
            }
            zaExtendDao.batchInsertPeiJqRel(relList);
        }
    }

    /**
     * 根据陪侍记录ID查询关联的案件列表
     */
    public List<Object> getAjListByPeiId(int peiId) {
        return zaExtendDao.findAjByPeiId(peiId);
    }

    /**
     * 根据陪侍记录ID查询关联的警情列表
     */
    public List<Object> getJqListByPeiId(int peiId) {
        return zaExtendDao.findJqByPeiId(peiId);
    }

    /**
     * 根据案件ID查询关联的陪侍记���列表
     */
    public List<ZaPei> getPeiListByAjId(int ajId) {
        return zaExtendDao.findPeiByAjId(ajId);
    }

    /**
     * 根据警情ID查询关联的陪侍记录列表
     */
    public List<ZaPei> getPeiListByJqId(int jqId) {
        return zaExtendDao.findPeiByJqId(jqId);
    }

    /**
     * 根据人员ID查询关联的所有陪侍案件
     */
    public List<Object> getPeiAjListByPersonnelId(int personnelId) {
        return zaExtendDao.findPeiAjByPersonnelId(personnelId);
    }

    /**
     * 根据人员ID查询关联的所有陪侍警情
     */
    public List<Object> getPeiJqListByPersonnelId(int personnelId) {
        return zaExtendDao.findPeiJqByPersonnelId(personnelId);
    }
}

