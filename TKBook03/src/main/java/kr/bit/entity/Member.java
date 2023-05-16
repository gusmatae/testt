package kr.bit.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;

import lombok.Data;
 
@Entity
@Data
public class Member {
	
	@Id
	private String username; //Security에서는 ID를 username이라 정의
	private String password;
	private String name;
	@Enumerated(EnumType.STRING) // EnumType.ORDINAL : 0 1 2
	private Role role;
	private boolean enabled; // 계정의 활성화/비활성화 여부
}
