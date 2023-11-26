package kr.bit.entity;

import lombok.Data;

/**
 * entity
 */
@Data
public class entity {
    String road;
    String jibun;
    String x;
    String y;
    String today;
    
    public entity(String road, String jibun, String x, String y){
        this.road = road;
        this.jibun = jibun;
        this.x = x;
        this.y = y;
    }
}