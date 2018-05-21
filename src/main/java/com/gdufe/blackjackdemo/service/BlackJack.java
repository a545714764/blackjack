package com.gdufe.blackjackdemo.service;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@Component
public class BlackJack {

    private Map<String,Deck> deckMap;
    private Map<String,Player> playerMap;
    private Map<String,Dealer> dealerMap;
    private Map<String,Integer> moneyMap;


    public BlackJack(){

        deckMap = new HashMap<>();
        playerMap = new HashMap<>();
        dealerMap = new HashMap<>();
        moneyMap = new HashMap<>();

    }

    public void init(String sessionId){

        deckMap.put(sessionId,new Deck());
        playerMap.put(sessionId,new Player());
        dealerMap.put(sessionId,new Dealer());
        moneyMap.put(sessionId,5000);


    }

    public void begin(String sessionId,Integer bet){
        Deck deck = deckMap.get(sessionId);
        Player player = playerMap.get(sessionId);
        Dealer dealer = dealerMap.get(sessionId);
        moneyMap.put(sessionId,moneyMap.get(sessionId)-bet);
        player.begin(deck);
        dealer.begin(deck);

    }

    public void begin(String sessionId){

        Deck deck = deckMap.get(sessionId);
        Player player = playerMap.get(sessionId);
        Dealer dealer = dealerMap.get(sessionId);
        player.begin(deck);
        dealer.begin(deck);

    }

    /**
     * 计算玩家牌点数的总和,计算步骤如下:
     * 1.如果 point 有 joker,queen和king 则点数+10,反则,点数+point
     * 2.如果实现步骤1后,点数+10<21且牌堆中有point=1,则点数+10
     * @param cards
     * @return
     */
    public int getSum(List<Card> cards){
        int sum = 0;
        for (Card card : cards){
            String point = card.getPoint();
            if (point.equals("10")||point.equals("joker")||point.equals("queen")
                    ||point.equals("king")){
                sum += 10;
            } else {
                sum += Integer.valueOf(point);
            }
        }
        if (sum + 10 <= 21 && haveOne(cards)){
            sum += 10;
        }
        return sum;
    }

    public boolean lessThan17(List<Card> cards){
        int sum = getSum(cards);
        if (sum < 17){
            return true;
        }
        return false;
    }

    /**
     * 计算玩家的牌是否有 point = 1 的牌
     * @param cards
     * @return
     */
    private boolean haveOne(List<Card> cards){
        for (Card card : cards){
            String point = card.getPoint();
            if (point.equals("1")){
                return true;
            }
        }
        return false;
    }





}
