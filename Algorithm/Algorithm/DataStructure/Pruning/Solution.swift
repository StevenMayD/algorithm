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
    var solveNQueens_resultArr : [[Int]]? // solveNQueens问题最终结果
    var solveNQueens_onceResultArr : [Int]? // solveNQueens问题单个情况结果
    var solveNQueens_col: [Int]? // solveNQueens问题 列集合
    var solveNQueens_pie: [Int]? // solveNQueens问题 撇集合
    var solveNQueens_na: [Int]?  // solveNQueens问题 捺集合
    
// MARK: 1、括号生成：https://leetcode.cn/problems/generate-parentheses/
    /*
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
    
    
// MARK: 2、N 皇后：https://leetcode.cn/problems/n-queens/
    /*
     给你一个整数 n ，返回所有不同的 n 皇后问题 的解决方案。
     
     n 皇后问题： 研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
     
     解法：DFS搜索 + 剪枝优化， DFS分析列，撇，捺 三个直线位置的冲突
     同列：
     */
    func solveNQueens(_ n: Int) -> [[String]] {
        solveNQueens_resultArr = []
        solveNQueens_onceResultArr = []
        solveNQueens_col = []
        solveNQueens_pie = []
        solveNQueens_na = []
        
        DFS_solveNQueens(0, n)
        return format_solveNQueens()
    }
    
    // 行，矩阵总数，当前结果 -> 单个最终结果
    func DFS_solveNQueens(_ row: Int, _ total: Int) {
        // 行数遍历完达到总行数 结束循环
        if (row >= total) {
            solveNQueens_resultArr?.append(solveNQueens_onceResultArr!) // 加入单种情况
            return
        }
        // 遍历所有列的可能
        for col in 0..<total {
            /* 剪枝：冲突的列位置不合法。记录三个集合，列、撇、捺集合，用于进行冲突判断。一次完整的遍历后，清空
             同列冲突：列数组中存在 列值相等
             同撇冲突：撇数组中存在 撇值相等（列+行 相同 则为撇值相同）
             同捺冲突：捺数组中存在 捺值相等（列-行 相同 则为捺值相同）
             */
            let colContains = solveNQueens_col?.contains(col)
            let pieContains = solveNQueens_pie?.contains(col+row)
            let naContains = solveNQueens_na?.contains(abs(col-row))
            if (colContains==true || pieContains==true || naContains==true) {
                continue
            }
            solveNQueens_col?.append(col)
            solveNQueens_pie?.append(col+row)
            solveNQueens_na?.append(abs(col-row))
            
            solveNQueens_onceResultArr?.append(col)
            DFS_solveNQueens(row+1, total)
            
            solveNQueens_col?.removeAll { (item) -> Bool in
                item == col
            }
            solveNQueens_pie?.removeAll { (item) -> Bool in
                item == col+row
            }
            solveNQueens_na?.removeAll { (item) -> Bool in
                item == abs(col-row)
            }
            solveNQueens_onceResultArr?.removeAll() // 移除单个情况数组
        }
    }
    // 格式化solveNQueens_resultArr 为最终所需的内容格式
    func format_solveNQueens() -> [[String]] {
        var result : [[String]] = []
        for item in solveNQueens_resultArr! {
            var colArr : [String] = []
            for value in item {
                var str = ""
                for val in 0..<item.count {
                    if (val == value) {
                        str = str + "Q"
                    } else {
                        str = str + "."
                    }
                }
                colArr.append(str)
            }
            result.append(colArr)
        }
        return result
    }
    
    
// MARK: 3、N 皇后 II：https://leetcode.cn/problems/n-queens-ii/
    /*
     给你一个整数 n ，返回 n 皇后问题 不同的解决方案的数量。
     */
    func totalNQueens(_ n: Int) -> Int {
        
        return 0
    }
    
    
    
// MARK: 4、有效的数独 https://leetcode.cn/problems/valid-sudoku/
    /*
     请你判断一个 9 x 9 的数独是否有效。只需要 根据以下规则 ，验证已经填入的数字是否有效即可。而不是解出数独答案
     */
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        // 条件校验
        if (board.isEmpty) {
            // 空数组，非法
            return false
        }
        
        // 挨个获取数独矩阵中第row行，第col列的"非空值"位置，校验其有效性
        for row in 0..<9 {
            for col in 0..<9 {
                // 空值无需校验有效性
                if (board[row][col] == ".") {
                    continue
                }
                
                // 如果有效 则校验矩阵中下一个"非空值"位置
                if (isValidCheck(board, row, col)) {
                    continue
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    
    /* 具体校验数独矩阵是否有效
     board：待校验矩阵
     row：第row行
     col：第col列
     */
    func isValidCheck(_ board: [[Character]], _ row: Int, _ col: Int) -> Bool {
        // 行的校验：第row行中，不能重复数字
        for nextCol in col+1 ..< 9 {
            if (board[row][col] == board[row][nextCol]) {
                return false
            }
        }
        
        // 列的校验：每一列中，不能重复数字
        for nextRow in row+1 ..< 9 {
            if (board[row][col] == board[nextRow][col]) {
                return false
            }
        }
        
        // 小宫格校验：待校验位置(row、col)所在的3*3小宫格中，不能重复数字
        let lRow = row / 3 // 待校验行 所属的小宫格的行
        let lCol = col / 3 // 待校验列 所属的小宫格的列
        for i in lRow*3..<lRow*3 + 3 {
            for j in lCol*3..<lCol*3 + 3 {
                // 不是待校验位置本身
                if (i != row && j != col) {
                    if (board[row][col] == board[i][j]) {
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    
    
// MARK: 5、解数独 https://leetcode.cn/problems/sudoku-solver/
    /*
     编写一个程序，通过填充空格来解决数独问题。
     */
    func solveSudoku(_ board: inout [[Character]]) {

    }
}
