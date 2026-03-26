package com.szrj.business.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * 治安人员权限工具类
 * 用于判断当前用户是否有权限对治安人员（涉赌、涉娼、陪侍）进行增删改操作
 */
public class ZaPersonnelPermissionUtil {

	/**
	 * 治安人员标识值（zslabel1字段值）
	 */
	private static final String ZA_PERSONNEL_LABEL = "2046";

	/**
	 * 默认授权部门ID集合（拥有全部治安人员增删改权限）
	 */
	private static final Set<Integer> DEFAULT_AUTHORIZED_DEPARTMENTS = new HashSet<>(
		Arrays.asList(1, 47,48, 49, 51, 53, 65)
	);

	/**
	 * 判断人员是否为治安人员
	 * @param zslabel1 人员的正式标签1级字段值
	 * @return true-是治安人员, false-不是治安人员
	 */
	public static boolean isZaPersonnel(String zslabel1) {
		if (zslabel1 == null || zslabel1.trim().isEmpty()) {
			return false;
		}
		// zslabel1 可能是逗号分隔的多个标签，需要检查是否包含 2046
		String[] labels = zslabel1.split(",");
		for (String label : labels) {
			if (ZA_PERSONNEL_LABEL.equals(label.trim())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 判断当前登录用户是否有权限对指定治安人员进行增删改操作
	 *
	 * @param loginUserDepartmentId 登录用户的部门ID
	 * @param personnelZslabel1 人员的正式标签1级字段值（用于判断是否为治安人员）
	 * @param handleUnitCode 人员的打处单位编码（逗号分隔的部门ID字符串）
	 * @return true-有权限, false-无权限
	 */
	public static boolean hasPermission(int loginUserDepartmentId, String personnelZslabel1, String handleUnitCode) {
		// Step 1：判断是否为治安人员
		if (!isZaPersonnel(personnelZslabel1)) {
			// 不是治安人员，返回true，沿用原系统权限逻辑
			return true;
		}

		// Step 2：判断是否为默认授权部门
		if (DEFAULT_AUTHORIZED_DEPARTMENTS.contains(loginUserDepartmentId)) {
			// 默认授权部门，拥有全部治安人员权限
			return true;
		}

		// Step 3：判断是否在该人员的打处单位中
		if (handleUnitCode == null || handleUnitCode.trim().isEmpty()) {
			// handle_unit_code 为空，只有默认授权部门可操作
			return false;
		}

		// 解析 handle_unit_code，检查是否包含当前用户的部门ID
		String[] unitCodes = handleUnitCode.split(",");
		for (String code : unitCodes) {
			if (code == null || code.trim().isEmpty()) {
				continue;
			}
			try {
				int deptId = Integer.parseInt(code.trim());
				if (deptId == loginUserDepartmentId) {
					return true;
				}
			} catch (NumberFormatException e) {
				// 忽略非法值
				continue;
			}
		}

		// 不在打处单位中，无权限
		return false;
	}

	/**
	 * 检查权限并返回结果消息
	 * 如果无权限，返回错误消息；如果有权限，返回null
	 *
	 * @param loginUserDepartmentId 登录用户的部门ID
	 * @param personnelZslabel1 人员的正式标签1级字段值
	 * @param handleUnitCode 人员的打处单位编码
	 * @param operationType 操作类型（新增、修改、删除）
	 * @return 无权限时返回错误消息，有权限时返回null
	 */
	public static String checkPermissionWithMessage(int loginUserDepartmentId, String personnelZslabel1,
			String handleUnitCode, String operationType) {
		if (!hasPermission(loginUserDepartmentId, personnelZslabel1, handleUnitCode)) {
			return "权限不足：您没有权限对该治安人员进行" + operationType + "操作！";
		}
		return null;
	}

	/**
	 * 判断部门是否为默认授权部门
	 * @param departmentId 部门ID
	 * @return true-是默认授权部门, false-不是
	 */
	public static boolean isDefaultAuthorizedDepartment(int departmentId) {
		return DEFAULT_AUTHORIZED_DEPARTMENTS.contains(departmentId);
	}
}

