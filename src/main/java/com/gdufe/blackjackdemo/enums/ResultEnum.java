package com.gdufe.blackjackdemo.enums;

import lombok.Getter;

@Getter
public enum ResultEnum {

    SUCCESS(1,"成功"),

    DEALERWIN(2,"庄家赢"),

    PLAYERWIN(3,"闲家赢"),

    TIE(4,"平局")
    ;

    private Integer code;

    private String message;

    ResultEnum(Integer code,String message){
        this.code = code;
        this.message = message;
    }
}
