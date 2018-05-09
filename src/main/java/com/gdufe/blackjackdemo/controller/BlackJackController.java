package com.gdufe.blackjackdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BlackJackController {

    @GetMapping("/game")
    public ModelAndView game(){
        return new ModelAndView("game");
    }

    @GetMapping("/gameBegin")
    public ModelAndView gameBegin(){
        return new ModelAndView("gameBegin");
    }
}
