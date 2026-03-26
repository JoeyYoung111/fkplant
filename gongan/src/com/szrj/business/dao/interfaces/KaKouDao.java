package com.szrj.business.dao.interfaces;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.interfaces.Hotel;
import com.szrj.business.model.interfaces.InternetBar;
import com.szrj.business.model.interfaces.KaKou;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;
import com.szrj.business.model.interfaces.Yujing;
import com.szrj.business.model.personel.Personnel;

public interface KaKouDao {

	
	public NewPageModel searchtrajectoryKK(KaKou  kakou,NewPageModel pm) throws DataAccessException;
	
	public KaKou searchtrajectoryKK_count(KaKou  kakou)throws DataAccessException;
	
	public NewPageModel searchHotel(Hotel  hotel,NewPageModel pm) throws DataAccessException;
	
	public NewPageModel searchInternetBar(InternetBar  internetbar,NewPageModel pm) throws DataAccessException;
	
	public NewPageModel searchXdJqxx(XdJqxx  xdjqxx,NewPageModel pm) throws DataAccessException;
	
	public NewPageModel searchXdAjxx(XdAjxx  xdajxx,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 查询涉警信息并附带关联信息（涉赌/涉娼/陪侍记录ID）
	 */
	public NewPageModel queryZaJqxxWithRel(XdJqxx xdjqxx, NewPageModel pm) throws DataAccessException;

	/**
	 * 查询涉案信息并附带关联信息（涉赌/涉娼/陪侍记录ID）
	 */
	public NewPageModel queryZaAjxxWithRel(XdAjxx xdajxx, NewPageModel pm) throws DataAccessException;

	public List<String> gettrajectoryKKtypes() throws DataAccessException;
	
	public NewPageModel searchAlltrajectoryKK(KaKou  kakou,NewPageModel pm) throws DataAccessException;
	
	public String findYbssRkByCardnumber(String cardnumber) throws DataAccessException;
	
	public Personnel getYbssRkByID(String ID) throws DataAccessException;
	
	public int findYujingByColumn(Yujing yujing) throws DataAccessException;
	
	public int addYujing(Yujing yujing) throws DataAccessException;
	
	public NewPageModel searchYujing(Yujing yujing,NewPageModel pm) throws DataAccessException;
	
	public int feedbackYujing(Yujing yujing) throws DataAccessException;
	
	public Yujing getYujingById(int id) throws DataAccessException;

	/**
	 * 根据身份证号列表批量查询案件信息
	 * @param cardnumbers 身份证号列表，逗号分隔
	 * @return
	 * @throws DataAccessException
	 */
	public List<Object> getAjxxByCardnumbers(String cardnumbers) throws DataAccessException;

	/**
	 * 根据身份证号列表批量查询警情信息
	 * @param cardnumbers 身份证号列表，逗号分隔
	 * @return
	 * @throws DataAccessException
	 */
	public List<Object> getJqxxByCardnumbers(String cardnumbers) throws DataAccessException;
}
