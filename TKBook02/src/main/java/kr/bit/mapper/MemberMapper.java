package kr.bit.mapper;


import org.apache.ibatis.annotations.Mapper;

import kr.bit.entity.MemberVO;
import kr.bit.entity.AuthVO;

//-MyBatis API DAO라고 볼 수 있음
@Mapper
public interface MemberMapper {
	public int register(MemberVO m); //회원등록( 1, 0 )
	public void authInsert(AuthVO saveVO);
	public MemberVO registerCheck(String memID);
}
 