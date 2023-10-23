//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/10/23.
//

import Foundation

public class Pruning {
    // 声明一个全局变量，用于递归时使用
    var generateParenthesis_resultArr : [String]?
    
    /* 1、括号生成：https://leetcode.cn/problems/generate-parentheses/
     数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
     解决：
        解法1：DFS深度优先搜索(递归)来解决问题。当n给定了，其实字符串长度也就给定了2*n，()两个不同的字符，此长度的排列组合可能性有2^2nz种，再递归判断是否合法即可，时间复杂度O(2^2n)
        解法2：在解法1上，进行“剪枝”优化，一个符号一个符号添加，而不是排列组合所有的可能性。 优化后的时间复杂度O(2^n)
            a、添加字符时，发现局部不合法，就不在递归。例如：首个括号添加), 或())
            b、记录leftUsed，rightUsed。左右括号的已使用个数，因为左右括号的总数都是n，不能用超过了
                (在使用分治，递归，回溯等方法时，通常要再单独开一个函数，用于递归调用)
     */
    func generateParenthesis(_ n: Int) -> [String] {
        
        return generateParenthesis_2(n)
    }
    
    
    /* 解法2：在解法1上，进行“剪枝”优化
     由于leftUsed，rightUsed是依次递增+1的，这样遍历下来，能把所有括号情况考虑到，且不合法的情况不会递归执行
     */
    func generateParenthesis_2(_ n: Int) -> [String] {
        generateParenthesis_resultArr = []
        genRecursion(0, 0, n, "") // 从空字符串 开始添加括号字符
        return generateParenthesis_resultArr!
    }
    // 参数：左已使用个数，右已使用个数，总个数，已拼接的字符串
    func genRecursion(_ leftUsed: Int, _ rightUsed: Int, _ total: Int, _ jointedStr: String) {
        // 递归结束条件：如果左、右括号同时用完了，则完成拼接字符串 添加进结果数组
        if (leftUsed == total && rightUsed == total) {
            generateParenthesis_resultArr?.append(jointedStr)
            return
        }
        if (leftUsed < total) {
            genRecursion(leftUsed+1, rightUsed, total, jointedStr + "(")
        }
        // 已使用的左括号数量肯定大于已使用的右括号，因为 ()) 非法
        if (rightUsed < total && rightUsed < leftUsed) {
            genRecursion(leftUsed, rightUsed+1, total, jointedStr + ")")
        }
    }
}
