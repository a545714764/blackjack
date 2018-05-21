package com.gdufe.blackjackdemo.vo;

import com.gdufe.blackjackdemo.service.Card;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class HitVO {
    private Integer code;
    private String msg;
    private Integer position;
    private Card card;
}
