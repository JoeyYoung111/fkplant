package com.szrj.business.service.personel.impl;

import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.personel.CasePoliceDataSyncDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.model.Department;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.service.personel.CasePoliceDataSyncService;

/**
 * 案件/警情数据同步服务实现类
 */
@Service("casePoliceDataSyncService")
@Transactional
public class CasePoliceDataSyncServiceImpl implements CasePoliceDataSyncService {

	private static final Logger logger = Logger.getLogger(CasePoliceDataSyncServiceImpl.class);

	@Autowired
	private CasePoliceDataSyncDao casePoliceDataSyncDao;

	@Autowired
	private PersonnelDao personnelDao;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	// 治安人员标签值
	private static final String ZA_LABEL = "2046";

	// 派出所部门ID范围（含）
	private static final int PCT_DEPT_ID_MIN = 240;
	private static final int PCT_DEPT_ID_MAX = 263;

	// 治安大队或其他 部门ID
	private static final String ZA_DAQV_DEPT_ID = "47";

	/**
	 * sldw 前9位编码 -> deptId 映射表
	 * 规则：取 sldw 前9位，匹配后直接返回对应 deptId，无需查询数据库
	 * 示例：320281510123 -> 前9位 320281510 -> 君山派出所(deptId=240)
	 */
	private static final Map<String, Integer> SLDW_PREFIX_DEPT_MAP;
	static {
		Map<String, Integer> map = new LinkedHashMap<>();
		map.put("320281510", 240); // 君山派出所
		map.put("320281520", 241); // 城中派出所
		map.put("320281530", 242); // 要塞派出所
		map.put("320281570", 243); // 西郊派出所
		map.put("320281590", 244); // 滨江派出所
		map.put("320281600", 245); // 城东派出所
		map.put("320281620", 246); // 云亭派出所
		map.put("320281630", 247); // 南闸派出所
		map.put("320281640", 248); // 利港派出所
		map.put("320281660", 249); // 夏港派出所
		map.put("320281670", 250); // 申港派出所
		map.put("320281680", 251); // 璜土派出所
		map.put("320281710", 252); // 青阳派出所
		map.put("320281730", 253); // 月城派出所
		map.put("320281750", 254); // 徐霞客派出所
		map.put("320281760", 255); // 峭岐派出所
		map.put("320281770", 256); // 周庄派出所
		map.put("320281780", 257); // 三房巷派出所
		map.put("320281800", 258); // 华士派出所
		map.put("320281810", 259); // 华西派出所
		map.put("320281830", 260); // 新桥派出所
		map.put("320281840", 261); // 长泾派出所
		map.put("320281860", 262); // 顾山派出所
		map.put("320281890", 263); // 祝塘派出所
		SLDW_PREFIX_DEPT_MAP = Collections.unmodifiableMap(map);
	}

	// ajlb -> zslabel2 映射
	private static final Map<String, String> AJLB_ZSLABEL2_MAP;
	static {
		Map<String, String> map = new LinkedHashMap<>();
		map.put("引诱未成年人聚众淫乱案", "2219");
		map.put("卖淫", "2219");
		map.put("嫖娼", "2219");
		map.put("拉客招嫖", "2219");
		map.put("引诱、容留、介绍卖淫", "2219");
		map.put("组织、强迫、引诱、容留、介绍卖淫案", "2219");
		map.put("组织卖淫案", "2219");
		map.put("强迫卖淫案", "2219");
		map.put("协助组织卖淫案", "2219");
		map.put("引诱、容留、介绍卖淫案", "2219");
		map.put("引诱卖淫案", "2219");
		map.put("容留卖淫案", "2219");
		map.put("介绍卖淫案", "2219");
		map.put("制作、贩卖、传播淫秽物品案", "2219");
		map.put("聚众淫乱案", "2219");
		map.put("赌博案", "2178");
		map.put("开设赌场案", "2178");
		map.put("组织参与国（境）外赌博案", "2178");
		map.put("制作、运输、复制、出售、出租淫秽物品", "2219");
		map.put("传播淫秽信息", "2219");
		map.put("组织播放淫秽音像", "2219");
		map.put("组织淫秽表演", "2219");
		map.put("进行淫秽表演", "2219");
		map.put("参与聚众淫乱", "2219");
		map.put("为淫秽活动提供条件", "2219");
		map.put("为赌博提供条件", "2178");
		map.put("赌博", "2178");
		AJLB_ZSLABEL2_MAP = Collections.unmodifiableMap(map);
	}

	@Override
	public void processDailyCasePoliceData() throws Exception {
		logger.info("Start processing daily case/police incident data");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(new Date());

		// 0. 去重预处理：同一 sfzh+jjbh 仅保留 insert_time 最大的一条
		deduplicateCaseData();
		deduplicatePoliceIncidentData();

		// 1. Process daily new case data
		processNewCaseData(currentTime);

		// 2. Process daily new police incident data
		processNewPoliceIncidentData(currentTime);

		logger.info("Daily case/police incident data processing completed");
	}

	/**
	 * 对 f_xt_xd_ajxx_new 表去重：
	 * 同一 sfzh + jjbh 的数据，仅保留 insert_time 最大的一条，其余直接删除。
	 */
	private void deduplicateCaseData() {
		try {
			logger.info("[去重] 开始对 f_xt_xd_ajxx_new 表进行去重处理...");
			String sql = "DELETE FROM f_xt_xd_ajxx_new " +
					"WHERE id NOT IN (" +
					"  SELECT id FROM (" +
					"    SELECT id FROM f_xt_xd_ajxx_new t1 " +
					"    WHERE t1.insert_time = (" +
					"      SELECT MAX(t2.insert_time) FROM f_xt_xd_ajxx_new t2 " +
					"      WHERE t2.sfzh = t1.sfzh AND t2.jjbh = t1.jjbh" +
					"    )" +
					"    GROUP BY t1.sfzh, t1.jjbh" +
					"  ) tmp" +
					")";
			int deleted = jdbcTemplate.update(sql);
			logger.info("[去重] f_xt_xd_ajxx_new 去重完成，删除重复记录数: " + deleted);
		} catch (Exception e) {
			logger.error("[去重] f_xt_xd_ajxx_new 去重失败", e);
		}
	}

	/**
	 * 对 f_xt_xd_jqxx_new 表去重：
	 * 同一 sfzh + jjbh 的数据，仅保留 insert_time 最大的一条，其余直接删除。
	 */
	private void deduplicatePoliceIncidentData() {
		try {
			logger.info("[去重] 开始对 f_xt_xd_jqxx_new 表进行去重处理...");
			String sql = "DELETE FROM f_xt_xd_jqxx_new " +
					"WHERE id NOT IN (" +
					"  SELECT id FROM (" +
					"    SELECT id FROM f_xt_xd_jqxx_new t1 " +
					"    WHERE t1.insert_time = (" +
					"      SELECT MAX(t2.insert_time) FROM f_xt_xd_jqxx_new t2 " +
					"      WHERE t2.sfzh = t1.sfzh AND t2.jjbh = t1.jjbh" +
					"    )" +
					"    GROUP BY t1.sfzh, t1.jjbh" +
					"  ) tmp" +
					")";
			int deleted = jdbcTemplate.update(sql);
			logger.info("[去重] f_xt_xd_jqxx_new 去重完成，删除重复记录数: " + deleted);
		} catch (Exception e) {
			logger.error("[去重] f_xt_xd_jqxx_new 去重失败", e);
		}
	}

	/**
	 * Process daily new case data
	 */
	private void processNewCaseData(String currentTime) throws Exception {
		logger.info("Start processing daily new case data");

		// Query daily new case data
		List<XdAjxx> dailyCases = casePoliceDataSyncDao.queryDailyNewCases();
		logger.info("Queried daily new case data: " + dailyCases.size() + " records");

		if (dailyCases.isEmpty()) {
			logger.info("No new case data for today");
			return;
		}

		// Collect department IDs and personnel info for notifications
		Map<String, Set<String>> deptNotificationMap = new HashMap<>();

		int processedCount = 0;
		int skippedCount = 0;

		for (XdAjxx ajxx : dailyCases) {
			String jjbh = ajxx.getJjbh();
			String recordId = ajxx.getId();  // 获取记录ID（UUID）
			try {
				// 【ajlb过滤】只处理 AJLB_ZSLABEL2_MAP 中定义的案件类型，其他类型直接置 flag=add 跳过
				String ajlbVal = ajxx.getAjlb();
				if (ajlbVal == null || ajlbVal.trim().isEmpty() || !AJLB_ZSLABEL2_MAP.containsKey(ajlbVal.trim())) {
					logger.info("[ajlb过滤] 案件类型不在处理范围内，跳过，recordId=" + recordId + ", caseNo=" + jjbh + ", ajlb=" + ajlbVal);
					casePoliceDataSyncDao.updateCaseFlag(recordId);
					skippedCount++;
					continue;
				}

				// 【年份过滤】若存在处罚记录（cfrq不为空），判断 JDSJ（cfrq）前4位年份是否 >= 2016，不符合直接置 flag=add 跳过
				// 注意：新逻辑下 cfrq 来自 t_xjw_aj_clcs_jgzxb.JDSJ（8位yyyyMMdd），若无处罚记录则为 null，null 时不过滤直接继续处理
				String cfrq = ajxx.getCfrq();
				if (cfrq != null && cfrq.trim().length() >= 4) {
					int cfrqYear;
					try {
						cfrqYear = Integer.parseInt(cfrq.trim().substring(0, 4));
					} catch (NumberFormatException nfe) {
						logger.warn("Case cfrq year parse failed, skip processing (mark as add), recordId=" + recordId + ", caseNo=" + jjbh + ", cfrq=" + cfrq);
						casePoliceDataSyncDao.updateCaseFlag(recordId);
						skippedCount++;
						continue;
					}
					if (cfrqYear < 2016) {
						logger.info("Case cfrq year=" + cfrqYear + " < 2016, skip processing (mark as add), recordId=" + recordId + ", caseNo=" + jjbh + ", cfrq=" + cfrq);
						casePoliceDataSyncDao.updateCaseFlag(recordId);
						skippedCount++;
						continue;
					}
				}

				String sfzh = ajxx.getSfzh();
				String sldw = ajxx.getSldw();
				String insertTime = ajxx.getInsert_time();

				logger.info("Processing case data: recordId=" + recordId + ", caseNo=" + jjbh + ", idCard=" + sfzh + ", deptCode=" + sldw + ", cfrq=" + cfrq);

				if (sfzh == null || sfzh.trim().isEmpty()) {
					logger.warn("Case data ID card is empty, skip processing, caseNo: " + jjbh);
					skippedCount++;
					continue;
				}

				// Find corresponding personnel
				Personnel personnel = personnelDao.getPersonnelByCardnumber(sfzh);
				if (personnel == null) {
					logger.warn("Personnel not found, idCard: " + sfzh + ", caseNo: " + jjbh + " - Check p_personnel_t table");
					skippedCount++;
					continue;
				}

				logger.info("Found personnel: ID=" + personnel.getId() + ", name=" + personnel.getPersonname() + ", zslabel1=" + personnel.getZslabel1());

				// Check if it's security personnel (support comma-separated values)
				String zslabel1 = personnel.getZslabel1();
				boolean isZaPersonnel = false;
				if (zslabel1 != null && !zslabel1.trim().isEmpty()) {
					// Support both exact match and comma-separated values
					String[] labels = zslabel1.split(",");
					for (String label : labels) {
						if (ZA_LABEL.equals(label.trim())) {
							isZaPersonnel = true;
							break;
						}
					}
				}

				if (!isZaPersonnel) {
					logger.warn("Not security personnel, skip. idCard: " + sfzh + ", name: " + personnel.getPersonname() + ", zslabel1=" + zslabel1 + " (need=" + ZA_LABEL + ")");
					skippedCount++;
					continue;
				}

				// Find department ID by sldw prefix mapping (前9位编码匹配)
				if (sldw == null || sldw.trim().isEmpty()) {
					logger.warn("Case accepting unit is empty, idCard: " + sfzh + ", caseNo: " + jjbh);
					skippedCount++;
					continue;
				}

				// 取 sldw 前9位进行映射
				String sldwTrimmed = sldw.trim();
				String sldwPrefix = sldwTrimmed.length() >= 9 ? sldwTrimmed.substring(0, 9) : sldwTrimmed;
				Integer mappedDeptId = SLDW_PREFIX_DEPT_MAP.get(sldwPrefix);

				// 标记：是否因 sldw 无法匹配派出所而回退到治安大队(47)
				boolean fallbackToZaDaQu = false;
				String deptId;
				if (mappedDeptId == null) {
					// sldw 无法匹配派出所时，回退到治安大队(47)，跳过发送消息提醒步骤
					logger.warn("Department mapping not found for sldw: " + sldw + ", prefix: " + sldwPrefix
							+ ", caseNo: " + jjbh + " -> fallback to handle_unit_code=47 (治安大队)");
					fallbackToZaDaQu = true;
					deptId = ZA_DAQV_DEPT_ID;
					mappedDeptId = Integer.parseInt(ZA_DAQV_DEPT_ID);
				} else {
					deptId = String.valueOf(mappedDeptId);
					logger.info("Mapped sldw: " + sldw + " -> prefix: " + sldwPrefix + " -> deptId: " + deptId);
				}

				// Update personnel's handle_unit_code
				boolean isNewDept = updateHandleUnitCode(personnel, deptId);

				if (isNewDept) {
					logger.info("New handling unit added, personnel: " + personnel.getPersonname() + ", deptID: " + deptId);
				} else {
					logger.info("Department already exists in handle_unit_code. Personnel: " + personnel.getPersonname() + ", deptID: " + deptId);
				}

				if (!fallbackToZaDaQu) {
					// 正常匹配派出所：加入通知队列并发送消息提醒
					if (!deptNotificationMap.containsKey(deptId)) {
						deptNotificationMap.put(deptId, new HashSet<String>());
					}
					deptNotificationMap.get(deptId).add(insertTime);

					// 【修复】无论是否新增handle_unit_code，只要有新案件就发送消息提醒
					insertCasePoliceMessage("aj", jjbh, personnel.getId(), sfzh, ajxx.getXm(), sldw,
							mappedDeptId, "", insertTime);
					logger.info("New case message sent to department ID=" + deptId + ", case: " + jjbh);
				} else {
					logger.info("sldw fallback to 治安大队(47), skip sending notification message, caseNo: " + jjbh);
				}

				// 【新增】根据ajlb给对应人员添加zslabel2子标签
				String ajlb = ajxx.getAjlb();
				addZslabel2ByAjlb(personnel, ajlb, jjbh);

				// Mark as processed only after successful processing
				casePoliceDataSyncDao.updateCaseFlag(recordId);  // 使用recordId（UUID）更新flag
				processedCount++;

			} catch (Exception e) {
				logger.error("Failed to process case data, recordId: " + recordId + ", caseNo: " + jjbh, e);
				// Don't update flag on exception, will retry next time
				skippedCount++;
			}
		}

		// Log notification info - notifications will be delivered through system polling mechanism
		logger.info("Case data processing completed. " + deptNotificationMap.size() +
				" department(s) will receive notifications through system polling.");
		logger.info("Notifications will be automatically displayed via getNewMessageRemind.do polling (every 6 seconds)");

		// 详细记录应该收到通知的部门ID列表
		if (!deptNotificationMap.isEmpty()) {
			logger.info("[Key Information] The following department IDs should receive notifications for new cases：");
			for (String deptId : deptNotificationMap.keySet()) {
				logger.info("  - department ID: " + deptId + ", case time: " + deptNotificationMap.get(deptId));
			}
			logger.info("[Key Information] During front-end polling, only departmentid = [[" + deptNotificationMap.keySet() + "]] Users will be able to see the notification.");
		}

		logger.info("Daily case data processing completed, successfully processed: " + processedCount + " records, skipped: " + skippedCount + " records");
	}

	/**
	 * Process daily new police incident data
	 */
	private void processNewPoliceIncidentData(String currentTime) throws Exception {
		logger.info("Start processing daily new police incident data");

		// Query daily new police incident data
		List<XdJqxx> dailyIncidents = casePoliceDataSyncDao.queryDailyNewPoliceIncidents();
		logger.info("Queried daily new police incident data: " + dailyIncidents.size() + " records");

		if (dailyIncidents.isEmpty()) {
			logger.info("No new police incident data for today");
			return;
		}

		// Collect department IDs and police incident info for notifications
		Map<String, Set<String>> deptNotificationMap = new HashMap<>();

		int processedCount = 0;
		int skippedCount = 0;

		for (XdJqxx jqxx : dailyIncidents) {
			String jjbh = jqxx.getJjbh();
			String recordId = jqxx.getId();  // 获取记录ID（UUID）
			try {
				// 【年份过滤】判断 jjrqsj 前4位年份是否 >= 2016，不符合直接置 flag=add 跳过
				String jjrqsj = jqxx.getJjrqsj();
				if (jjrqsj == null || jjrqsj.trim().length() < 4) {
					logger.warn("Incident jjrqsj is empty or too short, skip processing (mark as add), recordId=" + recordId + ", incidentNo=" + jjbh + ", jjrqsj=" + jjrqsj);
					casePoliceDataSyncDao.updatePoliceIncidentFlag(recordId);
					skippedCount++;
					continue;
				}
				int jjrqsjYear;
				try {
					jjrqsjYear = Integer.parseInt(jjrqsj.trim().substring(0, 4));
				} catch (NumberFormatException nfe) {
					logger.warn("Incident jjrqsj year parse failed, skip processing (mark as add), recordId=" + recordId + ", incidentNo=" + jjbh + ", jjrqsj=" + jjrqsj);
					casePoliceDataSyncDao.updatePoliceIncidentFlag(recordId);
					skippedCount++;
					continue;
				}
				if (jjrqsjYear < 2016) {
					logger.info("Incident jjrqsj year=" + jjrqsjYear + " < 2016, skip processing (mark as add), recordId=" + recordId + ", incidentNo=" + jjbh + ", jjrqsj=" + jjrqsj);
					casePoliceDataSyncDao.updatePoliceIncidentFlag(recordId);
					skippedCount++;
					continue;
				}

				String sfzh = jqxx.getSfzh();
				String cjdw = jqxx.getCjdw();
				String insertTime = jqxx.getInsert_time();

				logger.info("Processing police incident data: recordId=" + recordId + ", incidentNo=" + jjbh + ", idCard=" + sfzh + ", deptCode=" + cjdw + ", jjrqsj=" + jjrqsj);

				if (sfzh == null || sfzh.trim().isEmpty()) {
					logger.warn("Police incident ID card is empty, skip processing, incidentNo: " + jjbh);
					skippedCount++;
					continue;
				}

				// Find corresponding personnel
				Personnel personnel = personnelDao.getPersonnelByCardnumber(sfzh);
				if (personnel == null) {
					logger.warn("Personnel not found, idCard: " + sfzh + ", incidentNo: " + jjbh + " - Check p_personnel_t table");
					skippedCount++;
					continue;
				}

				logger.info("Found personnel: ID=" + personnel.getId() + ", name=" + personnel.getPersonname() + ", zslabel1=" + personnel.getZslabel1());

				// Check if it's security personnel (support comma-separated values)
				String zslabel1 = personnel.getZslabel1();
				boolean isZaPersonnel = false;
				if (zslabel1 != null && !zslabel1.trim().isEmpty()) {
					// Support both exact match and comma-separated values
					String[] labels = zslabel1.split(",");
					for (String label : labels) {
						if (ZA_LABEL.equals(label.trim())) {
							isZaPersonnel = true;
							break;
						}
					}
				}

				if (!isZaPersonnel) {
					logger.warn("Not security personnel, skip. idCard: " + sfzh + ", name: " + personnel.getPersonname() + ", zslabel1=" + zslabel1 + " (need=" + ZA_LABEL + ")");
					skippedCount++;
					continue;
				}

				// Find department ID by department code
				if (cjdw == null || cjdw.trim().isEmpty()) {
					logger.warn("Police incident handling unit is empty, idCard: " + sfzh + ", incidentNo: " + jjbh);
					skippedCount++;
					continue;
				}

				Department dept = casePoliceDataSyncDao.getDepartmentByDepartcode(cjdw);
				if (dept == null) {
					logger.warn("Department not found, deptCode: " + cjdw + ", incidentNo: " + jjbh + " - Check sys_department_t_new table");
					skippedCount++;
					continue;
				}

				logger.info("Found department: ID=" + dept.getId() + ", name=" + dept.getDepartname() + ", code=" + dept.getDepartcode());

				String deptId = String.valueOf(dept.getId());

				// Update personnel's handle_unit_code
				boolean isNewDept = updateHandleUnitCode(personnel, deptId);

				// Add to notification queue - now triggers for all new police incidents
				if (!deptNotificationMap.containsKey(deptId)) {
					deptNotificationMap.put(deptId, new HashSet<String>());
				}
				deptNotificationMap.get(deptId).add(insertTime);

				if (isNewDept) {
					logger.info("New handling unit added, personnel: " + personnel.getPersonname() + ", deptID: " + deptId + ", deptName: " + dept.getDepartname());
				} else {
					logger.info("Department already exists in handle_unit_code. Personnel: " + personnel.getPersonname() + ", deptID: " + deptId);
				}

				// 【修复】无论是否新增handle_unit_code，只要有新警情就发送消息提醒
				insertCasePoliceMessage("jj", jjbh, personnel.getId(), sfzh, jqxx.getXm(), cjdw,
						Integer.parseInt(deptId), dept.getDepartname(), insertTime);
				logger.info("New police incident message sent to department: " + dept.getDepartname() + " (ID=" + deptId + "), incident: " + jjbh);

				// Mark as processed only after successful processing
				casePoliceDataSyncDao.updatePoliceIncidentFlag(recordId);  // 使用recordId（UUID）更新flag
				processedCount++;

			} catch (Exception e) {
				logger.error("Failed to process police incident data, recordId: " + recordId + ", incidentNo: " + jjbh, e);
				// Don't update flag on exception, will retry next time
				skippedCount++;
			}
		}

		// Log notification info - notifications will be delivered through system polling mechanism
		logger.info("Police incident data processing completed. " + deptNotificationMap.size() +
				" department(s) will receive notifications through system polling.");
		logger.info("Notifications will be automatically displayed via getNewMessageRemind.do polling (every 6 seconds)");

		// 详细记录应该收到通知的部门ID列表
		if (!deptNotificationMap.isEmpty()) {
			logger.info("[Key Information] The following department IDs should receive new incident alerts:");
			for (String deptId : deptNotificationMap.keySet()) {
				logger.info("  - department id: " + deptId + ", jj time: " + deptNotificationMap.get(deptId));
			}
			logger.info("[Key Information] During front-end polling, only departmentid = [[" + deptNotificationMap.keySet() + "]] Users will be able to see the notification.");
		}

		logger.info("Daily police incident data processing completed, successfully processed: " + processedCount + " records, skipped: " + skippedCount + " records");
	}

	/**
	 * Update personnel's handle_unit_code
	 * @param personnel Personnel object
	 * @param newDeptId New department ID
	 * @return true if new department added, false if already exists
	 */
	private boolean updateHandleUnitCode(Personnel personnel, String newDeptId) {
		// 【关键修复】从数据库实时查询最新的handle_unit_code值，避免使用缓存数据
		String currentHandleUnitCode = casePoliceDataSyncDao.getCurrentHandleUnitCode(personnel.getId());

		logger.info("[handle_unit_code] person ID: " + personnel.getId() + ", name: " + personnel.getPersonname());
		logger.info("[handle_unit_code】current department id: " + (currentHandleUnitCode == null ? "NULL" : "'" + currentHandleUnitCode + "'"));
		logger.info("[handle_unit_code] add  department ID: " + newDeptId);

		// Parse current handle_unit_code
		Set<String> deptIdSet = new LinkedHashSet<>();
		if (currentHandleUnitCode != null && !currentHandleUnitCode.trim().isEmpty()) {
			String[] deptIds = currentHandleUnitCode.split(",");
			for (String deptId : deptIds) {
				if (deptId != null && !deptId.trim().isEmpty()) {
					deptIdSet.add(deptId.trim());
				}
			}
		}

		logger.info("[handle_unit_code] change after IDs: " + deptIdSet);

		// 判断新deptId是否属于派出所范围（240-263）
		boolean isPctDept = false;
		try {
			int deptIdInt = Integer.parseInt(newDeptId);
			isPctDept = (deptIdInt >= PCT_DEPT_ID_MIN && deptIdInt <= PCT_DEPT_ID_MAX);
		} catch (NumberFormatException e) {
			logger.warn("[handle_unit_code] deptId格式非数字，跳过派出所范围判断: " + newDeptId);
		}

		// 确定实际要添加的ID：
		//   - deptId 在 240-263 范围内：直接添加该 deptId
		//   - deptId 不在 240-263 范围内：仅添加 47（治安大队），不添加原始 deptId
		String idToAdd = isPctDept ? newDeptId : ZA_DAQV_DEPT_ID;

		if (!isPctDept) {
			logger.info("[handle_unit_code] deptId=" + newDeptId + " 不属于派出所范围(240-263)，仅添加47（治安大队或其他）");
		}

		// Check if the target ID already exists
		if (deptIdSet.contains(idToAdd)) {
			logger.info("[handle_unit_code] id=" + idToAdd + " is exists, no update needed");
			logger.debug("Department ID already exists in handle_unit_code: " + idToAdd);
			return false;
		}

		// Add the resolved department ID
		deptIdSet.add(idToAdd);

		// Rebuild string
		StringBuilder sb = new StringBuilder();
		for (String deptId : deptIdSet) {
			if (sb.length() > 0) {
				sb.append(",");
			}
			sb.append(deptId);
		}

		String updatedHandleUnitCode = sb.toString();

		logger.info("[handle_unit_code] new : '" + updatedHandleUnitCode + "'");

		// Update database
		casePoliceDataSyncDao.updateHandleUnitCode(personnel.getId(), updatedHandleUnitCode);
		logger.info("Updated handle_unit_code successfully, personnelID: " + personnel.getId() + ", newValue: " + updatedHandleUnitCode);

		return true;
	}

	/**
	 * 插入消息到 p_case_police_message_t 表
	 * @param messageType 消息类型：aj-案件，jj-警情
	 * @param jjbh 案件编号/接警编号
	 * @param personnelId 人员ID
	 * @param sfzh 身份证号
	 * @param xm 姓名
	 * @param sldw 受理单位code
	 * @param departmentId 处理单位部门ID
	 * @param departmentName 处理单位名称
	 * @param insertTime 案件/警情录入时间
	 */
	private void insertCasePoliceMessage(String messageType, String jjbh, int personnelId,
			String sfzh, String xm, String sldw, int departmentId, String departmentName, String insertTime) {
		try {
			String sql = "INSERT INTO p_case_police_message_t " +
					"(message_type, jjbh, personnelid, sfzh, xm, sldw, department_id, department_name, " +
					"insert_time, message_content, read_flag, validflag, addoperator, addtime) " +
					"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			String messageContent;
			if ("aj".equals(messageType)) {
				messageContent = "【新案件-提醒】" + insertTime + " 新案件入库，涉及人员：" + xm + "，请及时处理";
			} else {
				messageContent = "【新警情-提醒】" + insertTime + " 新警情入库，涉及人员：" + xm + "，请及时处理";
			}

			int result = jdbcTemplate.update(sql,
					messageType,           // message_type
					jjbh,                  // jjbh
					personnelId,           // personnelid
					sfzh,                  // sfzh
					xm,                    // xm
					sldw,                  // sldw
					departmentId,          // department_id
					departmentName,        // department_name
					insertTime,            // insert_time
					messageContent,        // message_content
					0,                     // read_flag (未读)
					1,                     // validflag (有效)
					"system",              // addoperator
					TimeFormate.getISOTimeToNow()  // addtime
			);

			if (result > 0) {
				logger.info("[Message inserted successfully] Type: " + messageType + ", department: " + departmentId +
						", person: " + xm + ", msg: " + messageContent);
			}
		} catch (Exception e) {
			logger.error("Failed to insert message to p_case_police_message_t, messageType: " + messageType +
					", jjbh: " + jjbh + ", personnelId: " + personnelId, e);
		}
	}

	/**
	 * 根据案件类别(ajlb)获取对应的zslabel2子标签值
	 * @param ajlb 案件类别
	 * @return 对应的zslabel2标签值，若无匹配则返回null
	 */
	private String getZslabel2LabelByAjlb(String ajlb) {
		if (ajlb == null || ajlb.trim().isEmpty()) {
			return null;
		}
		return AJLB_ZSLABEL2_MAP.get(ajlb.trim());
	}

	/**
	 * 根据ajlb给人员添加对应的zslabel2子标签
	 * @param personnel 人员对象
	 * @param ajlb 案件类别
	 * @param jjbh 案件编号（用于日志）
	 */
	private void addZslabel2ByAjlb(Personnel personnel, String ajlb, String jjbh) {
		try {
			String labelToAdd = getZslabel2LabelByAjlb(ajlb);
			if (labelToAdd == null) {
				logger.info("[zslabel2] ajlb='" + ajlb + "' 无匹配子标签规则，跳过更新，caseNo=" + jjbh);
				return;
			}

			// 从数据库实时读取当前zslabel2值
			String currentZslabel2 = casePoliceDataSyncDao.getCurrentZslabel2(personnel.getId());
			logger.info("[zslabel2] 人员ID=" + personnel.getId() + " 当前zslabel2='" + currentZslabel2 + "', ajlb='" + ajlb + "', 待添加标签=" + labelToAdd);

			// 检查是否已存在该标签
			boolean alreadyExists = false;
			if (currentZslabel2 != null && !currentZslabel2.trim().isEmpty()) {
				String[] existingLabels = currentZslabel2.split(",");
				for (String lbl : existingLabels) {
					if (labelToAdd.equals(lbl.trim())) {
						alreadyExists = true;
						break;
					}
				}
			}

			if (alreadyExists) {
				logger.info("[zslabel2] 标签 " + labelToAdd + " 已存在，保持不变，人员ID=" + personnel.getId());
				return;
			}

			// 拼接新标签
			String newZslabel2;
			if (currentZslabel2 == null || currentZslabel2.trim().isEmpty()) {
				newZslabel2 = labelToAdd;
			} else {
				newZslabel2 = currentZslabel2.trim() + "," + labelToAdd;
			}

			casePoliceDataSyncDao.updateZslabel2(personnel.getId(), newZslabel2);
			logger.info("[zslabel2] 已添加标签 " + labelToAdd + " 给人员ID=" + personnel.getId()
					+ "，新zslabel2='" + newZslabel2 + "'，caseNo=" + jjbh);

		} catch (Exception e) {
			logger.error("[zslabel2] 更新zslabel2失败，人员ID=" + personnel.getId() + ", ajlb=" + ajlb + ", caseNo=" + jjbh, e);
		}
	}

	/**
	 * 清理已读且超过30天的旧消息
	 * 将validflag设置为0（无效）
	 */
	@Override
	public void cleanOldMessages() {
		try {
			String sql = "UPDATE p_case_police_message_t " +
					"SET validflag = 0 " +
					"WHERE read_flag = 1 " +
					"AND addtime < DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 30 DAY), '%Y-%m-%d 00:00:00')";
			int count = jdbcTemplate.update(sql);
			logger.info("clear " + count + " old msg");
		} catch (Exception e) {
			logger.error("old msg clear failed", e);
		}
	}
}
