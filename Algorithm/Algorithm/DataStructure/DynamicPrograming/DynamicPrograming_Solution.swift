//
//  DynamicPrograming_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/11/10.
//

import Foundation

/* 算法6 - 动态规划 Dynamic Programing
 */
class DynamicPrograming {
    private var climbed : [Int : Int] = [:] // 记忆已爬过的楼梯
    private var minimumTotalArr : [Int] = []

// MARK: 1、 爬楼梯 https://leetcode.cn/problems/climbing-stairs/
    /*
     假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
     每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
     */
    func climbStairs(_ n: Int) -> Int {
        return climbStairs_1(n)
        
        return climbStairs_2(n)
    }
    
    /* 解法1：回溯：从上到下，递归调用自己，解决问题
     回溯：递归(能解决问题，但只递归可能超出时间限制) + 记忆化(提升效率，避免重复计算)
     递归思路：可以爬1或2个台阶，那么 到顶楼的方法数量 = 到(顶楼-1)的台阶的方法数 + 到(顶楼-2)的台阶的方法数
     1、递归终止条件：f(0)=f(1)=1
     2、相关操作处理：取记忆
     3、进行下一次递归：f(n) = f(n-1)+f(n-2)
     4、收尾工作：进行记忆
     */
    func climbStairs_1(_ n: Int) -> Int {
        // 1、递归终止条件
        if (n == 0 || n==1) {
            return 1
        }
        // 2、相关操作处理：记忆化（该题，只递归的话，运算超时）
        if (climbed[n] != nil) {
            // 取记忆
            return climbed[n]!
        } else {
            // 3、进行下一次递归
            var climbStairs_n = climbStairs_1(n-1) + climbStairs_1(n-2)
            // 4、收尾工作：进行记忆
            climbed[n] = climbStairs_n
            return climbStairs_n
        }
    }
    
    /* 解法2：动态规划DP：从下往上，递推
     DP思路：四步走
     1、循环递推：递归+记忆化 (利用循环，⭐️从下往上递推，这样其实就不用记忆化了，不会出现重复，更高级； 递归是从上到下)
     2、状态的定义：定义状态数组
     3、状态转移方程：确定由下往上递推的公式
     4、最优子结构：确保递推过程高效合理的，每个子结构是最优的，那么整个最终结果就是最优的
     */
    func climbStairs_2(_ n: Int) -> Int {
        // 递推初始状态 (利用循环，从下往上递推，这样其实就不用记忆化了，不会出现重复)：递归+记忆化
        climbed[0] = 1
        climbed[1] = 1
        // 1、循环进行递推
        for i in 2..<n+1 {
            // 2、状态的定义：定义一个状态数组climbed，数组元素是每一个结果climbStairs(n)
            // 3、状态转移方程 f(n) = f(n-1) + f(n-2)
            climbed[i] = climbed[i-1]! + climbed[i-2]!
        }
        return climbed[n]!
    }
    
    
    
// MARK: 2、三角形最小路径和 https://leetcode.cn/problems/triangle/
    /*
     给定一个三角形 triangle ，找出自顶向下的最小路径和。
     每一步只能移动到下一行中相邻的结点上。相邻的结点 在这里指的是 下标 与 上一层结点下标 相同或者等于 上一层结点下标 + 1 的两个结点。也就是说，如果正位于当前行的下标 i ，那么下一步可以移动到下一行的下标 i 或 i + 1 。
     */
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        return minimumTotal_1(triangle)
        return minimumTotal_2(triangle)
    }
    
    /* 解法1：
     DFS+递归：常规人的思维，自顶向下，所有结果走一遍，选出所有结果中的最小值。其中，可以使用记忆化，提高效率
     
     */
    func minimumTotal_1(_ triangle: [[Int]]) -> Int {
        getMinimumTotal(triangle)
        return minimumTotalArr.min()!
    }
    func getMinimumTotal(_ triangle: [[Int]]) {
        // 两层循环，深度优先遍历，递归进行遍历
        var total = 0
        for (i, itemI) in triangle.enumerated() {
            for (j, itemJ) in itemI.enumerated() {
                if ()
            }
            
        }
    }
    // 解法2：贪心算法，行不通，步步为营，并不能确保最后就是所有可能的最佳结果
    
    /* 解法3：
     DP：计算机思维，从下往上递推
     1、循环递推
     初始条件：f(0, 0) = val(0, 0)
     2、状态定义
     数组保存路径过程中的节点
     3、递推公式：f(i, j) = min[f(i+1, j), f(i+1, j+1)] + val(i, j)
     */
    func minimumTotal_2(_ triangle: [[Int]]) -> Int {
        // 1、循环递推
        
        // 2、状态定义
        
        // 3、递推公式
        var total = triangle[0][0]
        for (i, itemI) in triangle.enumerated() {
            if (i != triangle.count-1) {
                var itemNext = triangle[i+1]
                total = total + min(itemNext[i], itemNext[i+1])
            } else {
                
            }
            
            
        }
        return 1
    }
}

