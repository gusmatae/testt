package kr.bit.service;


import kr.bit.entity.BoardVO;
import kr.bit.entity.MemberVO;
import kr.bit.entity.AuthVO;


public interface MemberService {

	public int register(MemberVO m);
	public void authInsert(AuthVO saveVO);
	public MemberVO registerCheck(String memID);
}
