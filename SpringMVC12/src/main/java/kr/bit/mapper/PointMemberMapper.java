package kr.bit.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.bit.entity.entity;
import kr.bit.entity.busan;

@Mapper
public interface PointMemberMapper {

	public void insertPoint(entity vo);
	public List<entity> selectPoint();
	public List<busan> selectPusan();
}
