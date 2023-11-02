//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/10/9.
//

import Foundation

/* 算法1 - 递归与分治 Recursion、Divide&Conquer
 */

public class Recursion {
    /* 1、实现 pow(x, n) ，即计算 x 的整数 n 次幂函数（即，xn ）。
     */
    func myPow(_ x: Double, _ n: Int) -> Double {
        // 解法1：暴力傻乘递归，不能通过100%的测试用例，虽然用了递归操作，但n巨大时，算力崩溃
        return myPow_1(x, n)
        
        // 解法2：递归结合分治
        return myPow_2(x, n)
    }
    
    func myPow_1(_ x: Double, _ n: Int) -> Double {
        if (n > 1) {
            return x * myPow_1(x, n-1)
        }
        if (n == 1) {
            return x
        }
        if (n == 0) {
            return 1
        }
        if (n < 0) {
            return 1 / myPow_1(x, -n)
        }
        return 0
    }
    
    func myPow_2(_ x: Double, _ n: Int) -> Double {
        if (n == 0) {
            return 1
        }
        if (n < 0) {
            return 1 / myPow_2(x, -n)
        }
        // n很大，分而治之：拆成相同的两段，那么单个因子就是 x*x
        if (n%2 == 1) {
            // n为奇数
            return myPow_2(x*x, (n-1)/2) * x
        } else {
            // n为偶数
            return myPow_2(x*x, n/2)
        }
    }
    
    /* 2、多数元素：给定一个大小为 n 的数组 nums ，返回其中的多数元素。多数元素是指在数组中出现次数 大于 ⌊ n/2 ⌋ 的元素。
     */
    func majorityElement(_ nums: [Int]) -> Int {
        // 解法1：字典计数比较
        return majorityElement_1(nums)
        
        // 解法2：先排序，再计数比较
        return majorityElement_2(nums)
        
        // 解法3：分治算法
        return majorityElement_3(nums)
    }
    
    func majorityElement_1(_ nums: [Int]) -> Int {
        var countDict : [Int : Int] = [:] // 字典用于技术
        for item in nums {
            countDict[item, default: 0] += 1
        }
        let maxEntry = countDict.max(by: { $0.value < $1.value })
        return maxEntry!.key
    }
    
    func majorityElement_2(_ nums: [Int]) -> Int {
        var midIndex = nums.count/2
        var sortNums = nums.sorted()
        var countDict : [Int : Int] = [:] // 字典用于技术
        // 排序之后的数组，依据题意：一定存在唯一的个数大于n/2的元素
        for item in sortNums {
            countDict[item, default: 0] += 1
            let itemCount = countDict[item]
            if (itemCount! > midIndex) {
                return item
            }
        }
        return 0
    }
    
    // 未完成 未能理解
    func majorityElement_3(_ nums: [Int]) -> Int {
        return findMajorityElement(nums, 0, nums.count - 1)
    }
    
    func findMajorityElement(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
        // 基本情况：当子数组只包含一个元素时，返回该元素
        if left == right {
            return nums[left]
        }
        
        // 将数组分成两半
        let mid = (left + right) / 2
        
        // 递归地找到左半部分和右半部分的多数元素
        let leftMajority = findMajorityElement(nums, left, mid)
        let rightMajority = findMajorityElement(nums, mid + 1, right)
        
        // 合并左半部分和右半部分的多数元素
        if leftMajority == rightMajority {
            return leftMajority
        }
        
        let leftCount = countOccurrences(nums, left, right, leftMajority)
        let rightCount = countOccurrences(nums, left, right, rightMajority)
        
        return leftCount > rightCount ? leftMajority : rightMajority
    }

    func countOccurrences(_ nums: [Int], _ left: Int, _ right: Int, _ target: Int) -> Int {
        var count = 0
        for i in left...right {
            if nums[i] == target {
                count += 1
            }
        }
        return count
    }
}
