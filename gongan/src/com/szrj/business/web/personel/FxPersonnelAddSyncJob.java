package com.szrj.business.web.personel;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.szrj.business.service.personel.FxPersonnelAddService;

/**
 * 风险人员增量同步定时任务
 */
@Controller
public class FxPersonnelAddSyncJob {

	private static final Logger logger = Logger.getLogger(FxPersonnelAddSyncJob.class);

	@Autowired
	private FxPersonnelAddService fxPersonnelAddService;

	/**
	 * 定时同步任务
	 * TODO: 后续可能修改执行时间
	 */
	public void executeSyncTask() {
		logger.info("Trigger the scheduled task for synchronizing incremental updates of at-risk personnel data.");
		try {
			fxPersonnelAddService.syncNewPersonnel();
		} catch (Exception e) {
			logger.error("定时任务执行失败", e);
		}
	}
}

