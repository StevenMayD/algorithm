//
//  Hash_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/29.
//

import Foundation

/* 数据结构5 - 哈希表 HashMap
 */

class Map {
    
    /* 有效的字母异位词
     目标：给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
          注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。

     */
    func isAnagram(_ s: String, _ t: String) -> Bool {
        // 方法一：直接对字符串排序，比较排序后的字符串 值是否一样
//        return s.sorted() == t.sorted()
        
        // 方法二：Map做映射，时间复杂度更优
        /*
         Swift的字典，键可以是 char类型，值可以存放基本数据类型 Int、Double.
         OC中的字典，值只能存储对象，NSNumber
         */
        var dictS: [Character:Int] = [:]
        for char in s {
//            var charNum: Int = dictS[char] ?? 0 // 如果dictS[charStr]不存在，则取0
//            dictS[char] = charNum+1
            
//            dictS[char] = dictS[char, default: 0]+1 // 简化方法
            
            dictS[char, default: 0] += 1 // 再简化方法
        }
        
        var dictT: [Character:Int] = [:]
        for char in t {
//            var charNum: Int = dictT[char] ?? 0
//            dictT[char] = charNum+1
            dictT[char] = dictT[char, default: 0]+1
        }
        // == 比较值是否相等
        return dictS == dictT
    }
    
    /*  两数之和
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // 方法一：效率不高，没有用到 字典，靠字典自带的“contains”方法，其还是遍历循环实现的
//        for (indexX, itemX) in nums.enumerated() {
//            let itemY = target - itemX
//            if nums.contains(itemY) { // 判断数组是否包含 另一个因子
//                let indexY = nums.firstIndex(of: itemY)!
//                if indexX != indexY { // 不能两次 取同一个元素
//                    return [indexX, indexY]
//                }
//            }
//        }
//
        // 方法二：使用 Map字典
        var tempDict:[Int : Int] = [:]
        for (indexX, itemX) in nums.enumerated() {
            var itemY = target - itemX // 另一个因子
            
//            let indexY:Int! // 这里不能为 ? 因为?表示可以为nil，indexY需要加入字典中，nil加入字典会崩溃
//            indexY = tempDict[itemY]
//            if indexY != nil {
            
            // 声明变量并判断，代替上述三行代码的写法
            if let indexY:Int = tempDict[itemY] {
                // 如果另一个因子存在于 比对库
                return [indexX, indexY] // 则找到了 直接返回
            } else {
                // 否则 将当前因子加入比对库，供下一个因子比对
                tempDict[itemX] = indexX
            }
        }
        // 如果未找到匹配的数对，返回空数组或其他适当的标志
        return []
    }
    
    /*  三数之和
     Map字典，常用语处理查询和计数的算法题
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var resultArr:[[Int]] = []
        
        // 方法一：3次循环，性能差，O(N³)
//        var tempNums = nums
//        tempNums.sort() // 先排序
//        for (indexA, itemA) in tempNums.enumerated() {
//            for (indexB, itemB) in tempNums.enumerated() where indexB>indexA {
//                for (indexC, itemC) in tempNums.enumerated() where indexC>indexB {
//                    // 排除重复添加
//                    if (itemA + itemB + itemC == 0 && !resultArr.contains([itemA, itemB, itemC])) {
//                        resultArr.append([itemA, itemB, itemC])
//                    }
//                }
//
//            }
//        }
        
        // 方法二：利用Set集合，2次循环 O(N²)
        
        
        
        return resultArr
    }
        
        
   
}
