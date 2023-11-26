package kr.bit.controller;

import java.awt.Point;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.entity;
import kr.bit.entity.busan;
import kr.bit.service.PointMemberService;

@Controller
public class controller {
	@Autowired
	PointMemberService pointMemberService;

	@RequestMapping("/openLayers") //오픈레이어 메인 페이지 열기
	public String directAjaxView() {
		return "OpenLayersView";
	}
	@RequestMapping("/cesium") // 세슘 페이지 열기(practice)
	public String directSampleCode() {
		return "CesiumView";
	}
	@RequestMapping("/busanList.do") // 부산 출연 기관(ajax)
	public @ResponseBody List<busan> busanList(Model model) {
		List<busan> busanList = pointMemberService.selectBusan();
		return busanList;
	}
	@RequestMapping("/citizenMap.do") // 시민제보 map(ajax)
	public @ResponseBody List<entity> citizenMap(Model model) {
		List<entity> sp = pointMemberService.selectPoint();
		for(int i=0; i<sp.size(); i++) {
			String today = sp.get(i).getToday();
			String toto= today.substring(0,19);
			sp.get(i).setToday(toto);
		}
		return sp;
	}
	@RequestMapping("/citizenMapInsert.do") //시민제보 등록(ajax)
	public void citizenMapInsert(@RequestParam String fData, RedirectAttributes rttr, HttpServletRequest rq, HttpServletResponse rs) {
		//entity vo = new entity("1","2","3","4");
		String apiURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=";
		String client_id="dse3utw77j";
		String client_secret="SPheOtHEYF8KK2JqyrYBjcYooVNS0AMTjX7P75Ws";
		//주소 입력을 위한 버퍼 폼으로 대체
		//BufferedReader io = new BufferedReader(new InputStreamReader(System.in));
		try{  // readLine, encode는 예외를 던질 수 있음
			System.out.println("주소를 입력하세요");
			String address = fData;
			//주소에 공백이 들어가면 안되므로 %20으로 인코딩
			String addr = URLEncoder.encode(address, "UTF-8");
			String reqUrl = apiURL+addr;
			// 객체가 유효한 주소인지 URL 객체 사용, 유효X 일시 url익셉션 에러
			URL url = new URL(reqUrl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", client_id);
			con.setRequestProperty("X-NCP-APIGW-API-KEY", client_secret);

			BufferedReader br;
			int responseCode = con.getResponseCode(); //200일 시 success
			if(responseCode == 200){
				//json 받기위해 버퍼 생성, 데이터 얻기위해 con.getInputStream
				//바이트스트림과 리드는 연결이 바로 안되므로 inputStreamReader 객체를 이용
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			}else{
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}
			// 한줄 씩 저장
			String line;
			// 한줄 씩 저장
			StringBuffer response = new StringBuffer();
			while((line=br.readLine())!=null) {
				response.append(line);
			}
			br.close();
			JSONTokener tokener = new JSONTokener(response.toString());
			JSONObject object = new JSONObject(tokener);
			//System.out.println(object.toString(2));
			
			JSONArray arr = object.getJSONArray("addresses");
			String road = null;
			String jibun = null;
			String x = null;
			String y = null;
			for(int i=0; i<arr.length(); i++){
				JSONObject temp = (JSONObject) arr.get(i);
				System.out.println("주소:" + temp.get("roadAddress"));
				System.out.println("지번주소" + temp.get("jibunAddress"));
				System.out.println("경도" + temp.get("x"));
				System.out.println("위도" + temp.get("y"));
				  road = temp.get("roadAddress").toString();
				  jibun = temp.get("jibunAddress").toString();
				  x = temp.get("x").toString();
				  y = temp.get("y").toString();
			}
			entity vo = new entity(road, jibun, x, y);
			if(vo.getRoad() == null) {
				rs.sendRedirect("/openLayers");
			}else {
				pointMemberService.insertPoint(vo);
			}
			
			//System.out.println(enti);
		}catch(Exception e){
			e.printStackTrace();
		}

	}


}

