package kr.bit.service;

import java.util.List;

import kr.bit.entity.entity;
import kr.bit.entity.busan;

public interface PointMemberService {

	public void insertPoint(entity vo);
	public List<entity> selectPoint();
	public List<busan> selectBusan();
}
