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
    var minArr : [[Int]]? // 声明数组对象

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
        /* ✨✨✨✨ 先预先定义二维数组的大小
         创建一个大小为 triangle.count x triangle.count 的二维数组，并用 -1 填充初始化。这样，在访问 memo 的元素时就不会出现访问空数组的情况了。
         
         创建一个10个元素，元素值为-1的数组:
         var array: [Int] = [Int](repeating: -1, count: 10)
         创建二维数组，数组为10个元素，元素值为数组（10个元素的数组）:
         var array: [[Int]] = [[Int]](repeating: [Int](repeating: -1, count: 10), count: 10)
         */
        // 创建二维空数组
        self.minArr = [[Int]](repeating: [Int](repeating: -1, count: triangle.count), count: triangle.count)
        return dfs_minimumTotal(triangle, 0 , 0);
    }
    // 获取triangle数组中，第i行、第j列的节点，至三角形底部的最小路径
    func dfs_minimumTotal(_ triangle: [[Int]], _ i: Int, _ j: Int) -> Int {
        if (i == triangle.count - 1) {
            // 三角形底部行的最小路径，就是底部数值本身
            return triangle[i][j]
        }
        if self.minArr?[i][j] != -1 {
            return (self.minArr?[i][j])!
        }
        // (i, j)节点的左分支的最小路径
        let left = dfs_minimumTotal(triangle, i+1, j);
        // (i, j)节点的右分支的最小路径
        let right = dfs_minimumTotal(triangle, i+1, j+1);
        // 这里使用了数组的[i][j]空间，所以创建数组时，需要定义好数组空间大小
        self.minArr?[i][j] = min(left, right) + triangle[i][j];

        return (self.minArr?[i][j])!
    }


    
    /* 解法2：贪心算法，行不通，步步为营，并不能确保最后就是所有可能的最佳结果
     */
    
    
    /* 解法3：
      1、循环递推：反转循环递推
      2、状态数组定义：f(i, j)二维数组，表示(i, j)位置的最小路径
      3、状态转移方程：f(i, j) = min[f(i+1, j), f(i+1, j+1)] + val(i, j)
      */
    func minimumTotal_2(_ triangle: [[Int]]) -> Int {
        /* 注意：这里不能像dfs解法那样，创建二维空数组
         这两种解法之所以需要不同的数据结构，主要是因为它们在处理子问题时的方式不同。
         DFS（深度优先搜索）解法：是自上而下，由于需要循环遍历同一个数组，所以需要一个新数组作为状态数组来进行记录，不能用原有数组作为状态数组
         DFS 解法通常会采用递归的方式，因此需要一个用来存储已经计算过的子问题结果的缓存（memoization）。在这种情况下，memo 数组被用来记录每个位置的最小路径和。
         由于 DFS 是递归的，每次调用递归函数时，都需要将 memo 作为参数传递给递归函数，以确保递归过程中对 memo 的修改可以在不同的递归调用中共享。
         
         动态规划解法：是从下而上，底部访问过的元素，不再使用了，可以直接利用原来数组作为状态数组
         动态规划解法通常采用迭代的方式，从底部向顶部计算最优解。在这种情况下，不需要递归或者共享存储结果。
         动态规划解法中，dp 数组用来记录从底部到当前位置的最小路径和，每个位置都是通过比较当前位置下方的两个位置的最小路径和来计算的。
         因此，尽管这两种解法的思路是相同的，但由于实现方式不同，所以需要使用不同的数据结构来存储计算过程中的信息。
         */
        var minArr = triangle
        for i in (0..<triangle.count-1).reversed() {
            for j in 0..<triangle[i].count {
                if (i == triangle.count-1) {
                    minArr[i][j] = triangle[i][j]
                } else {
                    minArr[i][j] = min(minArr[i+1][j], minArr[i+1][j+1]) + triangle[i][j]
                }
            }
        }
        return minArr[0][0]
    }
    
    
    
    // MARK: 3、乘积最大子序列 https://leetcode.cn/problems/maximum-product-subarray/
        /*
         1、循环递推：累乘元素
         2、状态数组：由于负负得正，所以还需要记录一个最小值（即负的最大值）
         DP[i] = 累乘到第i个元素时的结果
         3、状态转移方程：
         DP[i] = DP[i-1] * val[i]
         */
        func maxProduct(_ nums: [Int]) -> Int {
            if (nums.isEmpty) {
                return 0
            }
            var dpMax = nums[0] // 记录最大值
            var dpMin = nums[0] // 记录最小值
            var result = nums[0]
            for i in 1..<nums.count {
                let dpMaxTmp = dpMax
                let dpMinTmp = dpMin
                dpMax = max(nums[i], max(dpMaxTmp * nums[i], dpMinTmp * nums[i]))
                dpMin = min(nums[i], min(dpMaxTmp * nums[i], dpMinTmp * nums[i]))
                result = max(result, dpMax) // 旧值和新最大值中，取其中的大
            }
            return result
        }
    
    
    // MARK: 4、最长上升子序列 https://leetcode.cn/problems/longest-increasing-subsequence/
    /*
     1、循环递推：
     2、状态数组：DP[i]为 从头到第i个元素的最长递增子序列
     DP[i] = 累乘到第i个元素时的结果
     3、状态转移方程：
     for(0 -> n-1) {
        for(0 -> i) {
            if (val(i) > val(j)) {
                dp[i] = max(dp[i], dp[j] + 1) // (i之前的最长子序列j， +1)
            }
        }
     }
     return max(DP[0], DP[1],...,DP[n-1])
     */
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else {
            return 0
        }
        var dp : [Int] = [Int](repeating: 0, count: nums.count)
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[i] > nums[j] {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
        }
        return dp.max() ?? 1
        
    }
    
    // MARK: 5、零钱兑换 https://leetcode.cn/problems/coin-change/description/
    /*
     1、循环递推：
     2、状态数组：dp[i]为总金额为i，需要的最少的硬币数
     3、状态转移方程：dp[i]等于 使用可选多种硬币的情况下，使用某个硬币之前，的最少硬币数情况 + 1个硬币
        dp[i] = min(dp[i - coins(j)]+1)
     */
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard amount != 0 else {
            return 0
        }
        // 需要取较小值，那么默认值就设置大值
        var dp = [Int](repeating: amount+1, count: amount+1)
        dp[0] = 0
        for i in 1...amount {
            for coin in coins {
                if (i >= coin) {
                    // 取多种硬币组合中的较小个数
                    dp[i] = min(dp[i], dp[i - coin]+1)
                }
            }
        }
        // 如果需要的硬币数量 比 总金额 还大，说明没有一种硬币能组合总金额
        return dp[amount]>amount ? -1 : dp[amount]
    }
    
    
    // MARK: 6、编辑距离 https://leetcode.cn/problems/edit-distance/description/
    /*
     1、状态数组：
     由于两个单词的变化，需要定义二维数组描述状态
     定义dp[i][j]：表示将word1的前i个字符，转换为word2的前j个字符，所需的最少操作数
     2、状态转移方程：dp[i][j]就等于“插入、删除、替换”这三种操作中的最少操作数
     dp[i-1][j]：word1前i-1个字符，变为word2前j个，插入一个字符即可
     dp[i][j-1]：word1前i个字符，变为word2前j-1个，删除一个字符即可
     dp[i-1][j-1]：word1前i个字符，变为word2前j-1个，替换一个字符即可
     dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1
    */
    func minDistance1(_ word1: String, _ word2: String) -> Int {
        let m = word1.count
        let n = word2.count
        
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        
        for i in 0...m {
            for j in 0...n {
                if i == 0 {
                    dp[i][j] = j
                } else if j == 0 {
                    dp[i][j] = i
                } else if Array(word1)[i - 1] == Array(word2)[j - 1] {
                    /*
                     word1构成的数组Array(word1)，元素个数为i-1，下标为i-1的元素，就是word1字符串的第i个字符
                     如果word1的第[i-1]个字符 跟 word2的第[j-1]个字符相同
                     */
                    dp[i][j] = dp[i - 1][j - 1]
                } else {
                    dp[i][j] = min(dp[i][j - 1], dp[i - 1][j], dp[i - 1][j - 1]) + 1
                }
            }
        }
        
        return dp[m][n]
    }

    
    
    
    
}

