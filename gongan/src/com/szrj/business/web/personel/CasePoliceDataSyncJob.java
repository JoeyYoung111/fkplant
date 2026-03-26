package com.szrj.business.web.personel;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.szrj.business.service.personel.CasePoliceDataSyncService;

/**
 * 案件/警情数据定时处理任务
 * 功能：每日轮询新入库的案件/警情数据，自动更新对应治安人员的打处单位，并向相关打处单位人员发送弹窗提醒
 * 执行时间：每天 01:30
 * Cron表达式：0 30 1 * * ?
 */
@Controller
public class CasePoliceDataSyncJob {

	private static final Logger logger = Logger.getLogger(CasePoliceDataSyncJob.class);

	@Autowired
	private CasePoliceDataSyncService casePoliceDataSyncService;

	/**
	 * 定时同步任务入口
	 */
	public void executeSyncTask() {
		logger.info("=== Start executing case/police incident data scheduled task ===");
		try {
			casePoliceDataSyncService.processDailyCasePoliceData();
			logger.info("=== Case/police incident data scheduled task execution completed ===");

			// 清理已读且超过30天的旧消息
			casePoliceDataSyncService.cleanOldMessages();
			logger.info("=== Old message cleanup completed ===");
		} catch (Exception e) {
			logger.error("Case/police incident data scheduled task execution failed", e);
		}
	}
}

