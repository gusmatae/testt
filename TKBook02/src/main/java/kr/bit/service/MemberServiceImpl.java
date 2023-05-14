package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.AuthVO;
import kr.bit.entity.BoardVO;
import kr.bit.entity.CriteriaVO;
import kr.bit.entity.MemberVO;
import kr.bit.mapper.BoardMapper;
import kr.bit.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper memberMapper;

	@Override
	public int register(MemberVO m) {
		int result = memberMapper.register(m);
		return result;
	}

	@Override
	public void authInsert(AuthVO saveVO) {
		memberMapper.authInsert(saveVO);
	}

	@Override
	public MemberVO registerCheck(String memID) {
		MemberVO m =memberMapper.registerCheck(memID);
		return m;
	}
	
	
	
}
