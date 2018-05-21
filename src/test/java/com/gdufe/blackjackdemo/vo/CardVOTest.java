package com.gdufe.blackjackdemo.vo;

import com.gdufe.blackjackdemo.constant.SuitConstant;
import com.gdufe.blackjackdemo.service.Card;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class CardVOTest {

    @Test
    public void testVO(){
        CardVO cardVO = new CardVO();
        Card card = new Card();
        card.setSuit(SuitConstant.HEART);
        card.setPoint("1");
        List<Card> playCard = cardVO.getPlayerCard();
        playCard.add(card);
        for (Card c : playCard){
            System.out.println(c);
        }
    }

}