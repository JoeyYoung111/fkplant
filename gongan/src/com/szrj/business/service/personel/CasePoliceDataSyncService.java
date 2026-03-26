package com.szrj.business.service.personel;

/**
 * 案件/警情数据同步服务接口
 */
public interface CasePoliceDataSyncService {

	/**
	 * 处理当日新增的案件/警情数据
	 * 1. 轮询当日新入库的案件/警情数据
	 * 2. 自动更新对应治安人员的打处单位（handle_unit_code）
	 * 3. 向相关打处单位的人员发送弹窗提醒
	 */
	void processDailyCasePoliceData() throws Exception;

	/**
	 * 清理已读且超过30天的旧消息
	 * 将validflag设置为0（无效）
	 */
	void cleanOldMessages();
}

