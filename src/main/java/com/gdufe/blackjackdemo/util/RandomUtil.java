package com.gdufe.blackjackdemo.util;

import java.util.HashSet;
import java.util.Set;

public class RandomUtil {
    /**
     *
     * @param amount 随机数的数量
     * @param min 最小的随机数(包含min)
     * @param max 最大的随机数(不包含max)
     * @return
     */
    public static int[] getRandom(int amount,int min,int max){
        int index = 0;
        int[] randomArr = new int[52];
        randomArr[51] = -1;

        while(randomArr[51]==-1){
            boolean flag = true;
            int random = (int)(Math.random()*(max-min))+min;
            for (int i = 0;i<index;i++){
                if (random==randomArr[i]){
                    flag = false;
                    break;
                }
            }
            if (flag){
                randomArr[index++] = random;
            }
        }
        return randomArr;
    }
}
