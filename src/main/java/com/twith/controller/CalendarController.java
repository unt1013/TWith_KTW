package com.twith.controller;

import java.io.File;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.twith.domain.CalImgDTO;
import com.twith.domain.CalendarDTO;
import com.twith.domain.DateData;
import com.twith.service.CalendarService;

import lombok.Setter;

@Controller
@RequestMapping("/calendar/*")
public class CalendarController {
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Setter(onMethod_ =  @Autowired)
	CalendarService service;
	
	@GetMapping("/main")
	public void main(DateData data, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("usernum", 1);
		if(!data.isBack()) {
			LocalDate date = LocalDate.now();
			data.getCal().set(Calendar.MONTH, date.getMonthValue()-1);
			data.getCal().set(Calendar.YEAR, date.getYear());
			data.initData();
		}
		model.addAttribute("data", data);
	}
	
	@GetMapping("/pageMove")
	@ResponseBody
	public String pageMove(int year, int month, DateData data) {
		data.getCal().set(Calendar.MONTH, month);
		data.getCal().set(Calendar.YEAR, year);
		data.updateData();
		
		String result = "";
		
		result += data.getTotal() + "%" + data.getStartday() + "%" + year + "%" + month;
		
		return result;
	}
	
	@GetMapping("/date")
	public String date(int year, int month, int date, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);
		
		String month_to_select = (month + 1) + "";
		String date_to_select = date + "";
		
		if(month_to_select.length() == 1) month_to_select = "0" + month_to_select;
		if(date_to_select.length() == 1) date_to_select = "0" + date_to_select;
		
		String date_to_select_convert = year + month_to_select + date_to_select;
		CalendarDTO cdto = service.getDetail(date_to_select_convert, (Integer)session.getAttribute("usernum"));
		List<CalImgDTO> cidtos = service.getImg(date_to_select_convert, (Integer)session.getAttribute("usernum"));
		
		if(cdto == null) {
			model.addAttribute("isUpdate", 0);
			return "/calendar/dateDetail";
		}
		else {
			model.addAttribute("data", cdto);
			if(cidtos.size() == 0) {
				model.addAttribute("isImg", 0);
			}else {
				model.addAttribute("isImg", 1);
				model.addAttribute("Img", cidtos);
			}
			
			return "/calendar/date";
		}
	}
	
	@GetMapping("/updateDate")
	public String updateDate(int year, int month, int date, Model model, HttpServletRequest req) {
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);
		model.addAttribute("isUpdate", 1);
		
		HttpSession session = req.getSession();
		
		String month_to_select = (month + 1) + "";
		String date_to_select = date + "";
		
		if(month_to_select.length() == 1) month_to_select = "0" + month_to_select;
		if(date_to_select.length() == 1) date_to_select = "0" + date_to_select;
		
		String date_to_select_convert = year + month_to_select + date_to_select;
		
		CalendarDTO cdto = service.getDetail(date_to_select_convert, (Integer)session.getAttribute("usernum"));
		List<CalImgDTO> cidtos = service.getImg(date_to_select_convert, (Integer)session.getAttribute("usernum"));
		
		model.addAttribute("data", cdto);
		if(cidtos.size() == 0) {
			model.addAttribute("isImg", 0);
		}else {
			model.addAttribute("isImg", 1);
			model.addAttribute("Img", cidtos);
		}
		
		return "/calendar/dateDetail";
	}
	
	@PostMapping("/regist")
	public String regist(MultipartRequest multi,
			HttpServletRequest request,
			DateData data, CalendarDTO cdto, RedirectAttributes ra) throws Exception {
		MultipartHttpServletRequest req = (MultipartHttpServletRequest)request;
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		cdto.setUsernum((Integer)(session.getAttribute("usernum")));
		String[] dates = cdto.getCaldate().split("-");
		
		data.getCal().set(Calendar.MONTH, Integer.parseInt(dates[1])-1);
		data.getCal().set(Calendar.YEAR, Integer.parseInt(dates[0]));
		
		if(dates[1].length() == 1) dates[1] = "0"+dates[1];
		if(dates[2].length() == 1) dates[2] = "0"+dates[2];
		cdto.setCaldate(dates[0] + dates[1] + dates[2]);
		
		service.addDate(cdto);
		CalImgDTO cidto = new CalImgDTO();
		cidto.setCaldate(dates[0] + dates[1] + dates[2]);
		cidto.setUsernum(cdto.getUsernum());
		fileUploadProcess(req, cidto);
		
		data.initData();
		data.setBack(true);
		ra.addFlashAttribute("data", data);

		return "redirect:/calendar/main";
	}
	
	private void fileUploadProcess(MultipartHttpServletRequest request, CalImgDTO cidto) throws Exception {
		Iterator<String> fileNames = request.getFileNames();
        
        while(fileNames.hasNext()) {
            String fileName = fileNames.next();
            MultipartFile mFile = request.getFile(fileName);
            String originalFileName = mFile.getOriginalFilename();
            File file = new File(uploadPath + "\\" + fileName);
            String saveFileName = System.currentTimeMillis() + originalFileName;
            if(mFile.getSize() != 0) {
                if(file.getParentFile().mkdir()) {
                    file.createNewFile();
                }
                mFile.transferTo(new File(uploadPath + "\\" + saveFileName));
                cidto.setImgorgname(originalFileName);
                cidto.setImgsavename(saveFileName);
                service.addImg(cidto);
            }
        }
	}
}
