package com.gdufe.blackjackdemo.service;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

@Getter
public class Dealer {
    //玩家手中的牌
    List<Card> cardList;

    public Dealer(){
        cardList = new ArrayList<>();
    }

    /**
     * 游戏开始,得到两张牌
     * @param deck 牌堆
     */
    public void begin(Deck deck){
        Stack<Card> cardDeck = deck.getCardDeck();
        cardList.add(cardDeck.pop());
        cardList.add(cardDeck.pop());
    }

    /**
     * 再拿一张牌
     * @param deck
     */
    public void takeAnother(Deck deck){
        Stack<Card> cardDeck = deck.getCardDeck();
        cardList.add(cardDeck.pop());
    }
}
