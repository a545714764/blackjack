package com.gdufe.blackjackdemo.service;

import com.gdufe.blackjackdemo.util.RandomUtil;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.*;

@Getter
@Setter
public class Deck {
    Stack<Card> cardDeck;

    public Deck() {
        cardDeck = new Stack();
        List<Card> cards = new ArrayList<>();
        for (int i = 1;i<=4;i++){
            String suit ="";
            if (i==1){
                suit = "spade";
            } else if (i==2){
                suit = "heart";
            } else if (i==3){
                suit = "clubs";
            } else {
                suit = "dianmond";
            }
            for (int j = 1; j <= 10; j++) {
                Card card = new Card();
                card.setSuit(suit);
                card.setPoint(String.valueOf(j));
                cards.add(card);
            }

            Card joker = new Card();
            joker.setSuit(suit);
            joker.setPoint("joker");
            cards.add(joker);

            Card queen = new Card();
            queen.setSuit(suit);
            queen.setPoint("queen");
            cards.add(queen);

            Card king = new Card();
            king.setSuit(suit);
            king.setPoint("king");
            cards.add(king);
        }

        int[] random = RandomUtil.getRandom(52, 0, 52);
        for (int i =0;i<random.length;i++){
            cardDeck.push(cards.get(random[i]));
        }
        cards.clear();





        /*
        dianmond:方块
        spade:葵花
        clubs:梅花
        heart:桃花
         */
    }

}
