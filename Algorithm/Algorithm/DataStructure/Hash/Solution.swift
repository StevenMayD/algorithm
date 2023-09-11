//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/29.
//

import Foundation

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
}
