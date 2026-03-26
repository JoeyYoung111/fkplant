package com.szrj.business.web.personel;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.szrj.business.service.personel.MinorLabelSyncService;

/**
 * 未成年人标签同步定时任务
 * 每天00:15执行，根据年龄自动维护zslabel2中的未成年标签（5002）
 */
@Controller
public class MinorLabelSyncJob {

	private static final Logger logger = Logger.getLogger(MinorLabelSyncJob.class);

	@Autowired
	private MinorLabelSyncService minorLabelSyncService;

	/**
	 * Scheduled sync task
	 * Execution time: 00:15 daily
	 */
	public void executeSyncTask() {
		logger.info("Triggered minor label sync scheduled task");
		try {
			minorLabelSyncService.syncMinorLabel();
		} catch (Exception e) {
			logger.error("Minor label sync scheduled task execution failed", e);
		}
	}
}

