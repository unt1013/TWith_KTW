package com.twith.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twith.domain.CalImgDTO;
import com.twith.domain.CalendarDTO;
import com.twith.mapper.CalendarMapper;

import lombok.Setter;

@Service
public class CalendarServiceImpl implements CalendarService {
	@Setter(onMethod_ = @Autowired)
	private CalendarMapper mapper;
	
	@Override
	public CalendarDTO getDetail(String caldate, int usernum) {
		return mapper.getDetail(caldate, usernum);
	}
	
	@Override
	public boolean addDate(CalendarDTO calendarDTO) {
		// TODO Auto-generated method stub
		return 1==mapper.addDate(calendarDTO);
	}
	
	@Override
	public boolean addImg(CalImgDTO calimgDTO) {
		// TODO Auto-generated method stub
		return 1==mapper.addImg(calimgDTO);
	}
	
	@Override
	public List<CalImgDTO> getImg(String caldate, int usernum) {
		// TODO Auto-generated method stub
		return mapper.getImg(caldate, usernum);
	}
}
