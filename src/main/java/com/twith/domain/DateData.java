package com.twith.domain;

import java.util.Calendar;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DateData {
	private Calendar cal;
	private int total;
	private int startday;
	private boolean back;
	
	public DateData() {
		cal = Calendar.getInstance();
		this.initData();
	}
	
	public void initData() {
		cal.set(Calendar.DATE, 1);
		this.updateData();
	}
	
	public void updateData(){
		this.total = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		this.startday = cal.get(Calendar.DAY_OF_WEEK);
	}
	
	public int getYear() {
		return cal.get(Calendar.YEAR);
	}
	
	public int getMonth() {
		return cal.get(Calendar.MONTH);
	}
}
