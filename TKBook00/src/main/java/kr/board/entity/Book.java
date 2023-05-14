package kr.board.entity;

import lombok.Data;

@Data
public class Book {
	private int bkCd;
    private String bkNm;
    private String bkPrice; 
    private String bkContent;
    private String bkImage;
    private String bkCreDt;
}