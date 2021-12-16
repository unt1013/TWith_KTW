package com.twith.service;

import java.util.List;

import com.twith.domain.CalImgDTO;
import com.twith.domain.CalendarDTO;

public interface CalendarService {
	public CalendarDTO getDetail(String caldate, int usernum);
	public boolean addDate(CalendarDTO calendarDTO);
	public boolean addImg(CalImgDTO calimgDTO);
	public List<CalImgDTO> getImg(String caldate, int usernum);
}
