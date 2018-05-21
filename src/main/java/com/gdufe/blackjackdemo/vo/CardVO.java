package com.gdufe.blackjackdemo.vo;

import com.gdufe.blackjackdemo.service.Card;
import com.gdufe.blackjackdemo.service.Dealer;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CardVO {

    private Integer code;

    private String msg;

    private List<Card> playerCard = new ArrayList<>();

    private List<Card> dealerCard = new ArrayList<>();
}
