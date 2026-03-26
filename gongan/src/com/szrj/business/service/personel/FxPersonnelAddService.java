package com.szrj.business.service.personel;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szrj.business.dao.personel.FxPersonnelAddDao;
import com.szrj.business.model.personel.FxPersonnelAdd;

/**
 * 风险人员增量同步服务
 */
@Service
public class FxPersonnelAddService {

	private static final Logger logger = Logger.getLogger(FxPersonnelAddService.class);

	@Autowired
	private FxPersonnelAddDao fxPersonnelAddDao;

	/**
	 * 同步新增人员数据
	 * 从 p_fxpersonnel_add_t 增量同步到 p_personnel_t
	 */
	public void syncNewPersonnel() {
		logger.info("+++++++++++ CasePoliceDataSyncServiceImpl start +++++++++++");

		try {
			// 1. 查询所有未同步的数据
			List<FxPersonnelAdd> notAddedList = fxPersonnelAddDao.selectNotAdded();

			if (notAddedList == null || notAddedList.isEmpty()) {
				logger.info("没有需要同步的数据");
				return;
			}

			logger.info("本次需要同步 " + notAddedList.size() + " 条数据");

			int successCount = 0;
			int failCount = 0;

			// 2. 循环处理每一条数据
			for (FxPersonnelAdd entity : notAddedList) {
				try {
					// 单条事务处理
					syncSingleRecord(entity);
					successCount++;
					logger.info("同步成功：ID=" + entity.getId() + ", 身份证=" + entity.getCardnumber() + ", 姓名=" + entity.getPersonname());
				} catch (Exception e) {
					failCount++;
					logger.error("同步失败：ID=" + entity.getId() + ", 身份证=" + entity.getCardnumber() + ", 原因：" + e.getMessage(), e);
					// 单条失败不影响其他数据，继续处理
				}
			}

			logger.info("+++++++++++ CasePoliceDataSyncServiceImpl +++++++++++");
			logger.info("成功：" + successCount + " 条，失败：" + failCount + " 条");

		} catch (Exception e) {
			logger.error("风险人员增量同步任务执行异常", e);
		}
	}

	/**
	 * 单条记录同步（事务性）
	 * 逻辑：先检查 p_personnel_t 中是否存在相同身份证号的记录
	 *       - 如果存在：直接标记为 added（跳过插入）
	 *       - 如果不存在：先插入，再标记为 added
	 * @param entity 待同步的记录
	 */
	@Transactional(rollbackFor = Exception.class)
	public void syncSingleRecord(FxPersonnelAdd entity) throws Exception {
		String cardnumber = entity.getCardnumber();
		
		// 1. 检查人员是否已存在
		int existsCount = fxPersonnelAddDao.checkPersonnelExists(cardnumber);
		
		if (existsCount > 0) {
			// 1.1 已存在：直接标记为 added，跳过插入
			logger.info("人员已存在（身份证=" + cardnumber + "），跳过插入，直接标记为已同步");
		} else {
			// 1.2 不存在：执行插入操作
			int insertResult = fxPersonnelAddDao.insertIntoPersonnel(entity);
			if (insertResult <= 0) {
				throw new Exception("插入 p_personnel_t 失败");
			}
			logger.info("人员不存在（身份证=" + cardnumber + "），已成功插入");
		}
		
		// 2. 更新同步标记为 'added'
		int updateResult = fxPersonnelAddDao.markAsAdded(entity.getId());

		if (updateResult <= 0) {
			throw new Exception("更新同步标记失败");
		}
	}
}

