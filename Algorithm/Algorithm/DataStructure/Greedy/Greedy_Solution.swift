//
//  Greedy_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/10/10.
//

import Foundation

/* 算法2 - 贪心算法 Greedy
 */

public class Greedy {
    /* 给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。
     在每一天，你可以决定是否购买和/或出售股票。你在任何时候 最多 只能持有 一股 股票。你也可以先购买，然后在 同一天出售。
     返回 你能获得的 最大 利润 。
     */
    func maxProfit(_ prices: [Int]) -> Int {
        return maxProfit_1(prices);
        
        return maxProfit_2(prices);
        
        return maxProfit_3(prices);
    }
    
    /* 解法1：DFS深度搜索
     解法：遍历数组时，每次经历元素时，递归“买卖”两种结果，记录所有可能后，得到最大利润
     优点：普遍广泛适用不同前提条件的买卖股票最佳时机的问题
     缺点：效率低，时间复杂度O(2^n)
     */
    func maxProfit_1(_ prices: [Int]) -> Int {
        
         return 0
    }
    
    /* 解法2：Greedy贪心算法
     解法：每一天都比较和前一天是否应该卖出，在和后一天比较是否应该买入
     优点：效率不错，时间复杂度O(n)
     缺点：有局限性，不是普遍使用，该题有前提“每天都可以买卖”，所以当天可以卖了，再比较后一天，同一天又买入
     */
    func maxProfit_2(_ prices: [Int]) -> Int {
     
        return 0
    }
    
    /* 解法3：DP(dynamic programming) 动态规划
     解法：针对每一天列一个状态，每天都跟前一天比较，当天是持有一股，还是持有0股的利润最大，保存记录最大的利润
     优点：效率不错，时间复杂度O(n)，且没有局限性，能普遍适用
     缺点：写法复杂，难度高
     */
    func maxProfit_3(_ prices: [Int]) -> Int {
        
        return 0
    }
}
