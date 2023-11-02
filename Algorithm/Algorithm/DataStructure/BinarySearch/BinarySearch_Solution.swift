//
//  BinarySearch_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/10/31.
//

import Foundation

/* 算法4 - 二分查找 BinarySearch
 */

public class BinarySearch {
    
// MARK: 1、x 的平方根：https://leetcode.cn/problems/sqrtx/
    /*
     给你一个非负整数 x ，计算并返回 x 的 算术平方根 。
     由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。
     注意：题干说明了 条件是整数，返回也是整数
     */
    func mySqrt(_ x: Int) -> Int {
        if (x <= 1) {
            return x
        }
        var left = 1 // 可不必定义类型 var left : Int = 1
        var right = x
        while left <= right {
            var mid = (right+left)/2
            if (mid*mid == x) {
                return mid
            } else if (mid*mid < x) {
                left = mid+1
            } else {
                right = mid-1
            }
        }
        /*
         由于题干：由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去。
         一旦找right-1 减到小于left，说明就是 平方根的整数部分了
         反而解法不能一味循环，取小数的整数部分
         */
        return right
    }
}
