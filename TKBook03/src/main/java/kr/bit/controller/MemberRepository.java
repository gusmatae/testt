package kr.bit.controller;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.bit.entity.Member;

public interface MemberRepository extends JpaRepository<Member, String>{ //Member ID의 타입

}
