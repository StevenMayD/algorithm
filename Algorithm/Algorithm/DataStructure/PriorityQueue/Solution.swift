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

 解法2 标准解法：双端队列(头和尾都能添加和移除元素)，时间复杂度为 O(N) = N*O(1)
 1.入队列：N个元素
 2.维护查询：O(1)
 */
class Solution2 {
    // 解法2 标准解法：双端队列队列，时间复杂度为 O(N) = N*O(1)
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        // 先容错 更专业
        if nums.isEmpty {
            return []
        }
        /* 存储k个元素的滑动窗口，存储元素下标，而不是存储值
         这个算法通过维护一个双端队列 window，在每次移动滑动窗口时，将队列内比当前元素小的元素全部弹出，保持队列递减。然后，检查队首元素是否超出窗口范围，如果超出则弹出。将当前元素的索引加入队列，并在窗口内有 k 个元素时，将队首元素对应的数组值加入结果列表。

         这个算法的时间复杂度为 O(n)，因为每个元素只会被添加到队列和从队列中移除一次。它可以在滑动窗口内高效地找到最大值。
         */
        var result: [Int] = [] // 记录结果值
        var window: [Int] = [] // 滑动窗口，记录下标

        for i in 0..<nums.count {
            // 保持窗口内元素递减，确保最大值在队首：如果新晋元素比 窗口末尾 值大，就循环移除末尾值（哪怕就剩新晋元素一个位于队首，那么在它移除之前，他就是最大值）
            while !window.isEmpty && nums[i] >= nums[window.last!] {
                window.removeLast()
            }

            // 移除窗口外的元素：窗口移动中，移除最老的元素
            while !window.isEmpty && window.first! <= i - k {
                window.removeFirst()
            }

            window.append(i)

            // 当窗口内达到了 k 个元素时，记录当前窗口的最大值（即窗口首个元素）
            if i >= k - 1 {
                result.append(nums[window.first!])
            }
        }

        return result
    }
}

