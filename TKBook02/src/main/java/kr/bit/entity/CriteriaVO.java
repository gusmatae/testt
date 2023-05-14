package kr.bit.entity;

import java.util.Date;

import lombok.Data;

@Data
public class CriteriaVO {
	private int page; //현재 페이지 번호
	private int perPageNum; //한페이지에 보여줄 게시글의 수
	//검색기능에 필요한 변수
	private String type;
	private String keyword;
	public CriteriaVO() {
		this.page=1;
		this.perPageNum=5;//한페이지에 몇개
	}
	//현재 페이지의 게시글의 시작번호 인덱스를 0부터 시작하기 위해 -1
	public int getPageStart() { //1page  2page 3page
		return (page-1)*perPageNum; //0  10~   20~    :limit 0,10  : limit ${pageStart}, #{perPageNum}
	}

}
