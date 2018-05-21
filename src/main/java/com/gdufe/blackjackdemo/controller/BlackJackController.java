package com.gdufe.blackjackdemo.controller;

import com.gdufe.blackjackdemo.enums.ResultEnum;
import com.gdufe.blackjackdemo.service.*;
import com.gdufe.blackjackdemo.vo.CardVO;
import com.gdufe.blackjackdemo.vo.HitVO;
import com.gdufe.blackjackdemo.vo.StandVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
public class BlackJackController {

    @Autowired
    private BlackJack blackJack;


    @GetMapping("/game")
    public ModelAndView game(HttpServletResponse response, HttpServletRequest request){
        String game_id = UUID.randomUUID().toString();
        return new ModelAndView("game");
    }

    @GetMapping("/play")
    public ModelAndView gameBegin(HttpServletRequest request,
                                  Map<String,Object> map
                                  ){
        String sessionId = request.getSession().getId();
        map.put("sessionId",sessionId);
//        map.put("bet",blackJack.getMoneyMap().get(sessionId));
        return new ModelAndView("gameBegin",map);
    }

    @GetMapping("/deal")
    public CardVO deal(@RequestParam(value = "sessionId")String sessionId,
                       @RequestParam(value = "bet",required = false)Integer bet){
        System.out.println(sessionId);
        CardVO cardVO = new CardVO();
        blackJack.init(sessionId);
        if (bet == null){
            blackJack.begin(sessionId);
        } else {
            blackJack.begin(sessionId,bet);
        }

        Map<String, Dealer> dealerMap = blackJack.getDealerMap();
        Map<String, Player> playerMap = blackJack.getPlayerMap();
        Dealer dealer = dealerMap.get(sessionId);
        Player player = playerMap.get(sessionId);
        cardVO.setCode(ResultEnum.SUCCESS.getCode());
        cardVO.setMsg(ResultEnum.SUCCESS.getMessage());
        cardVO.setDealerCard(dealer.getCardList());
        cardVO.setPlayerCard(player.getCardList());
        return cardVO;
    }

    @GetMapping("/stand")
    public StandVO stand(@RequestParam(value = "sessionId")String sessionId){
        //一.发送请求,得到 dealer 最终的牌
        Map<String, Deck> deckMap = blackJack.getDeckMap();
        Map<String, Dealer> dealerMap = blackJack.getDealerMap();
        Map<String, Player> playerMap = blackJack.getPlayerMap();
        Deck deck = deckMap.get(sessionId);
        Dealer dealer = dealerMap.get(sessionId);
        Player player = playerMap.get(sessionId);
        //1.如果 初始的两张牌点数 <17 点,则必须要牌,如果要牌后点数 >17 则停止要牌
        while (blackJack.lessThan17(dealer.getCardList())){
            dealer.takeAnother(deck);
        }
        //2.计算庄家的点数和
        int dealerSum = blackJack.getSum(dealer.getCardList());
        //3.计算闲家的点数和
        int playerSum = blackJack.getSum(player.getCardList());
        //4.根据游戏规则,判断出胜负:
        //①.庄家胜,输,平局
        StandVO standVO = new StandVO();
        standVO.setDealerCard(dealer.getCardList());

        if (dealerSum > 21){
            standVO.setCode(ResultEnum.PLAYERWIN.getCode());
            standVO.setMsg(ResultEnum.PLAYERWIN.getMessage());
            return standVO;
        }

        if (dealerSum == playerSum){
            standVO.setCode(ResultEnum.TIE.getCode());
            standVO.setMsg(ResultEnum.TIE.getMessage());
        } else if(dealerSum > playerSum){
            standVO.setCode(ResultEnum.DEALERWIN.getCode());
            standVO.setMsg(ResultEnum.DEALERWIN.getMessage());
        } else {
            standVO.setCode(ResultEnum.PLAYERWIN.getCode());
            standVO.setMsg(ResultEnum.PLAYERWIN.getMessage());
        }

        return standVO;
    }

    @GetMapping("/hit")
    public HitVO hit(@RequestParam(value = "sessionId")String sessionId){
        Map<String, Player> playerMap = blackJack.getPlayerMap();
        Map<String, Deck> deckMap = blackJack.getDeckMap();
        Player player = playerMap.get(sessionId);
        //闲家得到 另一张牌
        player.takeAnother(deckMap.get(sessionId));
        //得到闲家手中的牌
        List<Card> cardList = player.getCardList();

        //如果闲家的牌大于21点,返回牌的信息,并且告诉前端闲家点数溢出,游戏结束
        if (blackJack.getSum(cardList)>21){
            HitVO hitVO = new HitVO();
            hitVO.setCode(ResultEnum.DEALERWIN.getCode());
            hitVO.setMsg(ResultEnum.DEALERWIN.getMessage());
            hitVO.setPosition(cardList.size());
            hitVO.setCard(cardList.get(cardList.size()-1));
            return hitVO;
        }
        //如果闲家的牌大于21点,返回牌的信息
        HitVO hitVO = new HitVO();
        hitVO.setCode(ResultEnum.SUCCESS.getCode());
        hitVO.setMsg(ResultEnum.SUCCESS.getMessage());
        hitVO.setPosition(cardList.size());
        hitVO.setCard(cardList.get(cardList.size()-1));
        
        return hitVO;
    }


}
