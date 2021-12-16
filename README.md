# Twith

- 여행 관련 커뮤니티/예약 등 팀프로젝트
- 해당 코드는 개인 파트인 Calendar관련된 부분만 들어가있습니다
- db는 Oracle을 사용하였으며, sql문도 첨부하겠습니다



## Index

1. Main
2. DateDetail
3. Date
4. 개선점



## Main



- ![image-20211216144438578](C:\ITA\1900_web_ktw\Spring\workspace\TWith\readmeImg\image-20211216144438578.png)calendar/main 화면입니다. 해당하는 부분의 Controller 코드입니다.

  ```` java
  @GetMapping("/main")
  	public void main(DateData data, Model model, HttpServletRequest request) 	{
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
  ````

- LocalDate 클래스를 이용해 현재 날짜를 설정해주고 main.jsp에 데이터를 전송합니다.

  ```` java
  @Getter
  @Setter
  @ToString
  public class DateData {
  	private Calendar cal;
  	private int total;
  	private int startday;
  	private boolean back;
  }
  ````

- DateData 클래스는 Calendar 클래스를 사용해 날짜를 기록합니다.

- jsp에 출력할 정보들을 담고 있습니다.

- 위의 코드에 적어놓은 부분을 제외하고, 인스턴스를 제어하기 위한 기타 메소드가 존재합니다.

- 년/월 표시 옆에 있는 화살표를 클릭하면 Ajax를 이용해 달력을 갱신합니다.

  ````java
  @GetMapping("/pageMove")
  @ResponseBody
  public String pageMove(int year, int month, DateData data) {
  	data.getCal().set(Calendar.MONTH, month);
  	data.getCal().set(Calendar.YEAR, year);
  	data.updateData();
  	
  	String result = "";
  	
  	result += data.getTotal() + "%" + data.getStartday() + "%" + year + 			"%" + month;
  		
  	return result;
  }
  ````

- Controller의 ajax 부분입니다.

- 특정 날짜를 클릭하면 페이지를 이동합니다.

## DateDetail

![image-20211216150506839](C:\ITA\1900_web_ktw\Spring\workspace\TWith\readmeImg\image-20211216150506839.png)

- main에서 특정 날짜를 입력시, 해당 날짜의 내용이 없을 때 이동하는 화면입니다.

- 제목과 내용을 입력할 수 있는 공간이 있고 오른쪽의 add 버튼을 클릭시 이미지를 첨부할 수 있습니다.

  ![image-20211216164417025](C:\ITA\1900_web_ktw\Spring\workspace\TWith\readmeImg\image-20211216164417025.png)

- 아래에는 첨부된 이미지를 확인할 수 있게 작은 이미지를 출력하고, 클릭시 업로드 목록에서 제외합니다.

- 마지막으로 submit From 버튼을 클릭하면 메인 화면으로 돌아갑니다.

  ````java
  @GetMapping("/date")
  public String date(int year, int month, int date, Model model, 			HttpServletRequest request) {
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
  ````

- Controller 코드입니다. 전달받은 날짜 값을 정제하여 db에서 select하여 해당하는 날짜에 이미 기입한 값이 있을때와 없을때를 판별해 다른 jsp를 불러오도록 처리합니다.

- session에 들어간 usernum은 임의의 값을 미리 집어넣어놓은 상태입니다.

- submitForm 버튼을 클릭시 Controller의 regist로 이동합니다.

  ```java
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
  ```

- service를 통해 해당 날짜에 기입된 제목, 내용, 이미지를 업로드합니다. 해당 문서에서는 파일 입출력에 관련된 부분만 코드를 첨부하겠습니다.

  ```java
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
  ```

- jsp에서 받아온 파일 목록의 이름을 Iterator로 받아온 뒤, 반복문을 통해 순차적으로 저장하는 과정입니다.

- 파일 원본의 제목과 별개로, 저장될 파일의 이름은 현재 시간을 받아와 뒤에 붙여주는 식으로 중복을 방지했습니다.

- 크기가 0이 아닌 파일들을 저장하고 db에 파일의 원본이름과 저장된 이름, 유저의 이름과 날짜를 저장합니다.



## Date

- 위의 과정을 통해 저장된 내용들을 확인하는 페이지입니다.

- Main화면에서 내용이 적힌 날짜를 클릭하는 것으로 확인할 수 있습니다.

  ![image-20211216171445950](C:\ITA\1900_web_ktw\Spring\workspace\TWith\readmeImg\image-20211216171445950.png)

- 차례대로 아까 적은 제목, 내용, 그리고 이미지가 삽입된 것을 확인할 수 있습니다.

- 이미지의 경우 클릭시 크게 확인할 수 있습니다.

  ![image-20211216171610857](C:\ITA\1900_web_ktw\Spring\workspace\TWith\readmeImg\image-20211216171610857.png)

- 클릭한 이미지가 상단의 공간에 큰 화면으로 출력됩니다.



## 개선점

- Date 화면상에서 Update를 클릭하면 다시 DateDetail로 이동하지만 업로드한 이미지를 다시 불러와 이미지를 추가하거나, 업로드된 이미지를 삭제하는 기능이 없어 수정이 필요합니다.
- Main화면의 달력 우측에 해당 월의 활동 기록을 기입하려고 했으나, 현재 구현되지 않은 상태입니다.
- 업로드한 내용을 삭제하는 기능이 없습니다.