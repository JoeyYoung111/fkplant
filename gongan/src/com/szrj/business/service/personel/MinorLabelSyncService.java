package com.szrj.business.service.personel;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szrj.business.dao.personel.PersonnelDao;

/**
 * 未成年人标签同步服务
 * 根据人员年龄自动维护zslabel2中的未成年标签（5002）
 */
@Service
public class MinorLabelSyncService {

	private static final Logger logger = Logger.getLogger(MinorLabelSyncService.class);

	@Autowired
	private PersonnelDao personnelDao;

	/**
	 * 同步未成年人标签
	 * 1. 为未成年人（<18岁）添加zslabel2标签5002
	 * 2. 为已成年人（>=18岁）删除zslabel2标签5002
	 */
	@Transactional(rollbackFor = Exception.class)
	public void syncMinorLabel() {
		logger.info("========== Start Minor Label Sync Task ==========");

		try {
			// 1. Add label 5002 for minors (age < 18)
			int addCount = personnelDao.addMinorLabel();
			logger.info("Added label 5002 for minors, affected records: " + addCount);

			// 2. Remove label 5002 for adults (age >= 18)
			int removeCount = personnelDao.removeMinorLabel();
			logger.info("Removed label 5002 for adults, affected records: " + removeCount);

			logger.info("========== Minor Label Sync Task Completed ==========");
			logger.info("Summary: Added " + addCount + " records, Removed " + removeCount + " records");

		} catch (Exception e) {
			logger.error("Minor label sync task failed with exception", e);
			throw e;
		}
	}
}

