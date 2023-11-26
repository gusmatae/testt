package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.entity;
import kr.bit.entity.busan;
import kr.bit.mapper.PointMemberMapper;

@Service
public class PointMemberServiceMpl implements PointMemberService{

	@Autowired
	PointMemberMapper pointMemberMapper;

	@Override
	public void insertPoint(entity vo) {
		pointMemberMapper.insertPoint(vo);
	}
	@Override
	public List<entity> selectPoint() {
		List<entity> sp =pointMemberMapper.selectPoint();
		return sp;
	}
	@Override
	public List<busan> selectBusan() {
		List<busan> sp =pointMemberMapper.selectPusan();
		return sp;
	}
	
	}
	
	

