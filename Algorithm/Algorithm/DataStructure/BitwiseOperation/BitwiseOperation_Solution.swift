//
//  BitwiseOperation_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/11/3.
//

import Foundation


/* 算法4 - 位运算 Bitwise Operation
 */

class BitwiseOperation {
// MARK: 1、 位1的个数 https://leetcode.cn/problems/number-of-1-bits/
        /*
         编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为汉明重量）。
         提示：
         请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
         在 Java 中，编译器使用二进制补码记法来表示有符号整数。因此，在 示例 3 中，输入表示有符号整数 -3。
         */
    func hammingWeight(_ n: Int) -> Int {
        return hammingWeight_1(n)
        
        return hammingWeight_2(n)
    }
    
    /* 解法1 - 清1为0：位运算，与操作，清零最低位的1
     X & (X-1)的操作，会将最低位的1清零，循环清理最低位的1，直到最终全部为0为止，统计循环次数
     */
    func hammingWeight_1(_ n: Int) -> Int {
        var newN = n
        var count = 0
        while (newN != 0) {
            count+=1
            newN = newN & (newN - 1)
        }
        return count
    }
    
    /* 解法2 - 移1为0 ：位运算，右移，不断移除奇数1
     循环右移1位，统计奇数的出现次数，就是"1"的个数
     */
    func hammingWeight_2(_ n: Int) -> Int {
        var newN = n
        var count = 0
        while (newN != 0) {
            /* 奇数的末位为1 */
            
            // 对2取模(对2求余)，来判断奇偶性
//            if (newN % 2 == 1) {
//                count += 1
//            }
            
            // 位运算与1，来判断奇偶性，更高效
            if (newN & 1 == 1) {
                count += 1
            }
            
            newN = newN >> 1
        }
        return count
    }
    
    
    
// MARK: 2、 2的幂 https://leetcode.cn/problems/power-of-two/
        /*
         给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true ；否则，返回 false 。
         如果存在一个整数 x 使得 n == 2x ，则认为 n 是 2 的幂次方。
         
         解法：位运算
         什么叫二进制？ 跟逢十进一一样，逢二进一，也就是说，10,100,1000...,  这些刚刚完成进位的数，是十的整数幂，也是二进制中二的整数幂 （注意不只是 整数倍）
        这些整数幂，具有“只有一个1”的特点，那么清零唯一的1，它就应该全是0
         */
    func isPowerOfTwo(_ n: Int) -> Bool {
        return n != 0 && (n&(n-1))==0
    }
    
    
    
// MARK: 3、 比特位计数 https://leetcode.cn/problems/counting-bits/
        /*
         给你一个整数 n ，对于 0 <= i <= n 中的每个 i ，计算其二进制表示中 1 的个数 ，返回一个长度为 n + 1 的数组 ans 作为答案。
         */
    // 获取0到n中每一个i的二进制表示中1的个数
    func countBits(_ n: Int) -> [Int] {
        return countBits_1(n)
        
        return countBits_2(n)
    }
    
    // 解法1：位运算(获得单个数中1的个数) + while循环获取n中每一位i
    func countBits_1(_ n: Int) -> [Int] {
        var countArr : [Int] = []
        var tempN = 0
        while tempN <= n {
            countArr.append(countBit(tempN))
            tempN += 1
        }
        return countArr
    }
    // 计算n的二进制表示中1的个数
    func countBit(_ n: Int) -> Int {
        // 方法1：循环调用
        var count = 0
        var tempN = n
        while tempN != 0 {
            count += 1
            tempN = tempN&(tempN-1)
        }
        return count
        
        // 方法2：递归调用
        return (n==0) ? 0 : countBit(n&(n-1))+1
    }
    
    
    /* 解法2 更优：位运算(获得单个数中1的个数) + 递归调用(构成数组)
     ⭐️ 思路：count(i) = count(i&(i-1)) + 1，
            即整数i中的1的个数 = 将i中末尾的1移除后的数，这个数它中的1的数量 + 1
            因为之前的已经算过了，且移除末尾1的数，肯定小于移除1之前的数，所以可以递归递推，提升效率
     */
    func countBits_2(_ n: Int) -> [Int] {
        // 定义一个n+1元素个数的数组，用于存放每个i中1的个数
        var countArr : [Int] = [Int](0...n)
        countArr[0] = 0
        for i in 1..<n+1 {
            countArr[i] = countArr[i&(i-1)] + 1
        }
        return countArr
    }
}
