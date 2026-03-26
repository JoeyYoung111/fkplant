package com.szrj.business.impl.interfaces;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.model.interfaces.Hotel;
import com.szrj.business.model.interfaces.InternetBar;
import com.szrj.business.model.interfaces.KaKou;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;
import com.szrj.business.model.interfaces.Yujing;
import com.szrj.business.model.personel.Personnel;

public class KaKouDaoImpl extends BaseDaoiBatis implements KaKouDao {

	public NewPageModel searchtrajectoryKK(KaKou  kakou, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.searchtrajectoryKK_count",kakou);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchtrajectoryKK",kakou,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}
	public KaKou searchtrajectoryKK_count(KaKou  kakou) throws DataAccessException {
		return (KaKou)getSqlMapClientTemplate().queryForObject("kakou.searchtrajectoryKK_count1", kakou);
	}
	
	
	public NewPageModel searchHotel(Hotel  hotel, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.searchHotel_count",hotel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchHotel",hotel,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}
	public NewPageModel searchInternetBar(InternetBar internetbar,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.searchInternetBar_count",internetbar);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchInternetBar",internetbar,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}
	public NewPageModel searchXdAjxx(XdAjxx xdajxx, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.searchxdajxx_count",xdajxx);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchxdajxx",xdajxx,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}
	public NewPageModel searchXdJqxx(XdJqxx xdjqxx, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.searchxdjqxx_count",xdjqxx);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchxdjqxx",xdjqxx,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}
	
	/**
	 * 查询涉警信息并附带关联信息（涉赌/涉娼/陪侍记录ID）
	 */
	public NewPageModel queryZaJqxxWithRel(XdJqxx xdjqxx, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.queryZaJqxxWithRel_count",xdjqxx);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.queryZaJqxxWithRel",xdjqxx,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	/**
	 * 查询涉案信息并附带关联信息（涉赌/涉娼/陪侍记录ID）
	 */
	public NewPageModel queryZaAjxxWithRel(XdAjxx xdajxx, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.queryZaAjxxWithRel_count",xdajxx);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.queryZaAjxxWithRel",xdajxx,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<String> gettrajectoryKKtypes() throws DataAccessException {
		return (List<String>)getSqlMapClientTemplate().queryForList("kakou.gettrajectoryKKtypes");
	}
	
	public NewPageModel searchAlltrajectoryKK(KaKou  kakou, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("kakou.searchAlltrajectoryKK_count",kakou);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchAlltrajectoryKK",kakou,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}
	public String findYbssRkByCardnumber(String cardnumber)
			throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("kakou.findYbssRkByCardnumber",cardnumber);
	}
	public Personnel getYbssRkByID(String ID) throws DataAccessException {
		return (Personnel)getSqlMapClientTemplate().queryForObject("kakou.getYbssRkByID",ID);
	}
	public int addYujing(Yujing yujing) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kakou.addYujing", yujing);
	}
	public int findYujingByColumn(Yujing yujing) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("kakou.findYujingByColumn", yujing);
	}
	public NewPageModel searchYujing(Yujing yujing,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kakou.searchYujing_count", yujing);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kakou.searchYujing", yujing, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	public int feedbackYujing(Yujing yujing) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kakou.feedbackYujing", yujing);
	}
	public Yujing getYujingById(int id) throws DataAccessException {
		return (Yujing)getSqlMapClientTemplate().queryForObject("kakou.getYujingById",id);
	}

	@SuppressWarnings("unchecked")
	public List<Object> getAjxxByCardnumbers(String cardnumbers) throws DataAccessException {
		if (cardnumbers == null || cardnumbers.trim().isEmpty()) {
			return new java.util.ArrayList<Object>();
		}
		return getSqlMapClientTemplate().queryForList("kakou.getAjxxByCardnumbers", cardnumbers);
	}

	@SuppressWarnings("unchecked")
	public List<Object> getJqxxByCardnumbers(String cardnumbers) throws DataAccessException {
		if (cardnumbers == null || cardnumbers.trim().isEmpty()) {
			return new java.util.ArrayList<Object>();
		}
		return getSqlMapClientTemplate().queryForList("kakou.getJqxxByCardnumbers", cardnumbers);
	}
}
