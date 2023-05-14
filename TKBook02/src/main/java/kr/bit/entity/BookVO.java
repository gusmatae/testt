package kr.bit.entity;

import java.util.Date;

import lombok.Data;

@Data
public class BookVO {
		private int bookIdx; //책 번호
		private String bookName;// 책 이름
		private String bookWriter;// 책 작가
		private String bookContent; // 책 설명
	    private int bookPrice; // 책 가격
	    private String bookImage; // 책 이미지
}
