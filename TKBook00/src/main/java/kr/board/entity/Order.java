package kr.board.entity;

import lombok.Data;

@Data
public class Order {
	private int orIdx; // 주문번호
	private String memID; // 주문 아이디
	private String bkCd; // 상품 코드
	private String bkNm; // 상품이름
	private String recvNm; // 수령인 이름
	private String recvAddr; // 수령인 주소
	private String recvPN; // 수령인 전화번호
	private String orDate; // 주문 일자
}