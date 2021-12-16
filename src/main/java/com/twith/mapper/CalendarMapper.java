package com.twith.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.twith.domain.CalImgDTO;
import com.twith.domain.CalendarDTO;

public interface CalendarMapper {
	public CalendarDTO getDetail(@Param("caldate")String caldate, @Param("usernum")int usernum);
	public List<CalImgDTO> getImg(@Param("caldate")String caldate, @Param("usernum")int usernum);
	public int addDate(CalendarDTO calendarDTO);
	public int addImg(CalImgDTO calimgDTO);
	public boolean updateDate(@Param("caldate")String caldate, @Param("usernum")int usernum);
}
