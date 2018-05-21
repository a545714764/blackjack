package com.gdufe.blackjackdemo.vo;

import com.gdufe.blackjackdemo.service.Card;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class StandVO {
    private Integer code;
    private String msg;
    private List<Card> dealerCard = new ArrayList<>();
}
