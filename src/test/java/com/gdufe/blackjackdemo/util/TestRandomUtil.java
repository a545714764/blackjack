package com.gdufe.blackjackdemo.util;

import org.junit.Test;

import java.time.Duration;
import java.time.Instant;
import java.util.Set;

import static org.junit.Assert.*;

public class TestRandomUtil {

    @Test
    public void getRandom() {

        int[] random = RandomUtil.getRandom(52, 0, 52);
        for (int a : random){
            System.out.println(a);
        }
    }



}