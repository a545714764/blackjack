package com.gdufe.blackjackdemo.util;

import com.gdufe.blackjackdemo.service.Player;
import org.junit.Test;
import redis.clients.jedis.Jedis;

import java.util.HashMap;
import java.util.Map;

public class testRedis {

    @Test
    public void test01(){
        Jedis jedis = new Jedis("47.106.84.130",6379);
        jedis.set("hello","world");
        String value = jedis.get("hello");
        System.out.println(value);
    }

    @Test
    public void testSessionMap(){
        Map<String,Player> map = new HashMap<>();
        map.put("1",new Player());
        System.out.println(map.get("1"));

        map.put("1",new Player());
        System.out.println(map.get("1"));

    }
}
