package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 * 风险人员增量同步表 p_fxpersonnel_add_t
 */
public class FxPersonnelAdd {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private String id;           // 记录ID（UUID格式，text类型）
	private String cardnumber;   // 身份证号
	private String personname;   // 姓名
	private String houseplace;   // 户籍地详址
	private String extra1;
	private String extra2;       // 同步标记字段 (added表示已同步)
	private String insert_time;  // 插入时间（text类型）

	/*---------------------------------------getter and setter------------------------------------------------------------------------*/
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCardnumber() {
		return cardnumber;
	}

	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}

	public String getPersonname() {
		return personname;
	}

	public void setPersonname(String personname) {
		this.personname = personname;
	}

	public String getHouseplace() {
		return houseplace;
	}

	public void setHouseplace(String houseplace) {
		this.houseplace = houseplace;
	}

	public String getExtra1() {
		return extra1;
	}

	public void setExtra1(String extra1) {
		this.extra1 = extra1;
	}

	public String getExtra2() {
		return extra2;
	}

	public void setExtra2(String extra2) {
		this.extra2 = extra2;
	}

	public String getInsert_time() {
		return insert_time;
	}

	public void setInsert_time(String insert_time) {
		this.insert_time = insert_time;
	}
}

