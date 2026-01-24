package com.aladdin.util;

import java.util.ArrayList;
import java.util.List;

import com.aladdin.model.AxisEvent;
import com.aladdin.model.TimeAxis;

public class TimeAxisUtil {
	public  static List<TimeAxis> getTimeAxis(List<AxisEvent> axisTemp){
		String year = axisTemp.get(0).getEventtime().substring(0, 4);
		List<TimeAxis> axisList = new ArrayList<TimeAxis>();
		List<AxisEvent> eventList = new ArrayList<AxisEvent>();
		AxisEvent axisEvent = new AxisEvent();
		axisEvent.setEventtype(axisTemp.get(0).getEventtype());
		axisEvent.setEventtime(axisTemp.get(0).getEventtime());
		axisEvent.setEventname(axisTemp.get(0).getEventname());
		axisEvent.setEventdetail(axisTemp.get(0).getEventdetail());
		eventList.add(axisEvent);
		for(int i=1;i<axisTemp.size();i++){
			TimeAxis timeAxis = new TimeAxis();
			if(!year.equals(axisTemp.get(i).getEventtime().substring(0, 4))){
				timeAxis.setYear(year);
				timeAxis.setEventList(eventList);
				axisList.add(timeAxis);
				eventList = new ArrayList<AxisEvent>();
			}
			year = axisTemp.get(i).getEventtime().substring(0, 4);
			axisEvent = new AxisEvent();
			axisEvent.setEventtype(axisTemp.get(i).getEventtype());
			axisEvent.setEventtime(axisTemp.get(i).getEventtime());
			axisEvent.setEventname(axisTemp.get(i).getEventname());
			axisEvent.setEventdetail(axisTemp.get(i).getEventdetail());
			eventList.add(axisEvent);
		}
		TimeAxis timeAxis = new TimeAxis();
		timeAxis.setYear(year);
		timeAxis.setEventList(eventList);
		axisList.add(timeAxis);
		return axisList;
	}
}
