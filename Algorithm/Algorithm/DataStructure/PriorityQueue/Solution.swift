//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/17.
//

import Foundation

/*
 ⭐️数据流中的第 K 大元素：https://leetcode.cn/problems/kth-largest-element-in-a-stream/
  破局：优先队列的结构，是处理流式的数据，最好的结构（优先队列，自带排序位置，方便获取指定大小顺序的元素）

 但swift中，没有现成的优先队列数据结构，此题不方便使用优先队列俩解题。
 解决：需要使用数组排序和比较元素的方法，来获取指定大小顺序的元素。 但这样的性能会比使用优先队列差
 */
class KthLargest {
    var array:[Int]
    var numK:Int
    
    // 初始的数据流，就是数组nums
    init(_ k: Int, _ nums: [Int]) {
        array = nums.sorted(by: >) // 初始化时就按降序排序
        numK = k
    }
    // 每次调用add插入元素，返回数组中第k大的元素
    func add(_ val: Int) -> Int {
        // 插入的时候就进行 查找插入到指定位置
        var insetIndex:Int = 0
        // ⭐️注意： 这里是硬生生地遍历查找，再之后学习二分查找法后，可以优化
        for (index, item) in array.enumerated() {
            if val > item {
                insetIndex = index // 找到比插入值大的索引 就获取该索引
                // 遍历array时，也可以插入数组 array.insert(val, at: insetIndex)，swift不会崩溃
                break
            } else {
                // 没找到位置，则插入到最后
                insetIndex = index+1
            }
        }
        array.insert(val, at: insetIndex)
        return array[numK-1]
    }
}

/*
 ⭐️⭐️⭐️滑动窗口最大值：https://leetcode.cn/problems/sliding-window-maximum/
 滑动窗口SlidingWindow，算法题的高频考点

 对于应用题，理解题干，抽象化为选择适合的数据结构来解题

 解法1：堆，时间复杂度为 O(NlogK)
 1.维护位置heap：O(logK)
 2.取堆顶max值：O(N)

 解法2 标准解法：队列，时间复杂度为 O(N) = N*O(1)
 1.入队列：N个元素
 2.维护查询：O(1)
 */
class Solution2 {
    // 解法2 标准解法：队列，时间复杂度为 O(N) = N*O(1)
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        // 先容错 更专业
        if nums.isEmpty {
            return []
        }
        var kNums:[Int] = []
        var resultNums:[Int] = []
        for item in nums {
            if kNums.count < k {
                kNums.append(item) // 先添加
                if kNums.count == k { // 刚刚加满k个的时候 获取k个元素的最大值resultNumsresultNums
                    let temp = kNums.sorted(by: >)
                    resultNums.append(temp.first!)
                }
            } else { // 满k个后再添加，就移除第一个，再添加新的至最后，再获取k个元素的最大值进resultNums
                kNums.removeFirst()
                kNums.append(item)
                let temp = kNums.sorted(by: >)
                resultNums.append(temp.first!)
            }
        }
        return resultNums
    }
}

