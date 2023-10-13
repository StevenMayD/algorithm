//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/10/10.
//

import Foundation

// 广度优先搜索 与 深度优先搜索：
public class BFS_DFS {
    var DFS_resultArr : [[Int]]? // 声明一个类 属性
    
    /* 1、二叉树的层序遍历
     给你二叉树的根节点 root ，返回其节点值的 层序遍历 。 （即逐层地，从左到右访问所有节点）。
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        return levelOrder_1(root)
        
        return levelOrder_2(root)
    }
    
    /* 解法1：广度优先搜索BFS
     人的思维，一层一层的添加。时间复杂度O(n)
     [
        [3],
        [9, 10],
        [15, 7]
     ]
     */
    func levelOrder_1(_ root: TreeNode?) -> [[Int]] {
        // ！！！先排除空节点的情况，避免很多麻烦
        if (root == nil) {
            return []
        }
        
        var resultArr : [[Int]] = [] // 结果数组：声明一个空数组，存放最终结果，注意[[]]，这样可不是空数组
        var levelArr : [TreeNode] = [] // 层级数组：放置树中一层级的节点
        levelArr.append(root!) // 初始加入根节点
        
        while levelArr.count > 0 { // 只要一层中还有节点没有处理，就进行循环处理
            var eleValueArr : [Int] = []
            
            var levelCount = levelArr.count // 固定值 作为当前层级的循环次数
            for _ in 0..<levelCount {
                // 注意：！！这里按数组元素固定个数遍历，而不是遍历数组，因为for里面不断在给数组levelArr添加元素。这样只会循环当前层级的次数
                var levelNodeFirst : TreeNode = levelArr.removeFirst() // 取出并移除第一个节点，进行处理
                eleValueArr.append(levelNodeFirst.val)
                
                var leftNode : TreeNode? = nil // 先声明可以为nil，这样后续就能存在nil值了
                leftNode = levelNodeFirst.left
                var rightNode : TreeNode? = nil
                rightNode = levelNodeFirst.right
                if (leftNode != nil) {
                    levelArr.append(leftNode!)
                }
                if (rightNode != nil) {
                    levelArr.append(rightNode!)
                }
            }
            resultArr.append(eleValueArr)
        }
        return resultArr
    }
    
    
    /* 解法2：深度优先搜索DFS
     计算机的思维，递归遍历一根分支，再遍历另一分支。时间复杂度O(n)
     [
level0  [[3]]
level1  [[9,20]]
level2  [[15,7]]
     ]
     */
    func levelOrder_2(_ root: TreeNode?) -> [[Int]] {
        if (root == nil) { return [] }
        /* 这里需要使用是一个类属性，被公共使用
         因为如果在levelOrder_2方法中声明私有属性DFS_resultArr，再传递给dfsOrder中使用, DFS_resultArr会在递归不断传递，从而被反复操作 出错
         */
        self.DFS_resultArr = [[]]
        dfsOrder(root!, 0) // 将结果数组 交给递归计算
        return self.DFS_resultArr!
    }
    // 遍历单根分支 level记录层级，代表数组中的元素下标
    func dfsOrder(_ node: TreeNode?, _ level:Int) {
        if (node == nil) { return }
        
        // 先给数组DFS_resultArr添加好 元素（子数组），无法给nil调用append方法
        if (self.DFS_resultArr!.count < level+1) {
            self.DFS_resultArr?.append([])
        }
        
        // 不能取出DFS_resultArr的元素，再添加元素
//        var eleArr = self.DFS_resultArr![level]
//        eleArr.append(node!.val)
        
        // 得直接对DFS_resultArr进行操作 添加元素
        self.DFS_resultArr![level].append(node!.val)
        
        var leftNode : TreeNode? = nil
        leftNode = node!.left
        if (leftNode != nil) {
            dfsOrder(leftNode!, level+1)
        }
        var rightNode : TreeNode? = nil
        rightNode = node!.right
        if (rightNode != nil) {
            dfsOrder(rightNode!, level+1)
        }
    }
}
