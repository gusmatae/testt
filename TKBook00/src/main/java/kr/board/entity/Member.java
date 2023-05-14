package kr.board.entity;

import java.util.List;

import lombok.Data;

@Data
public class Member {
	 private int memIdx; //번호
	 private String memID; //회원 아이디
	 private String memPassword; //비밀번호
	 private String memName; //이름
	 private int memAge; //나이
	 private String memGender;// 성별
	 private String memEmail; // 이메일
	 private String memProfile; // 회원사진
	 private List<AuthVO> authList; //권한 리스트
	 //authList[0].auth, authList[1].auth, authList[2].auth
}