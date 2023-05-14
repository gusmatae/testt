package kr.bit.entity;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	 private int memIdx;
	 private String memID;
	 private String memPassword;
	 private String memName; 
	 private int memAge; 
	 private String memGender;
	 private String memEmail;
	 private String memProfile;
	 private List<AuthVO> authList; 
}