//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/10/10.
//

import Foundation

/* 算法3 - 广度优先搜索 BFS、 深度优先搜索 DFS
 */

public class BFS_DFS {
    var DFS_resultArr : [[Int]]? // 声明一个类 属性
    
    /* 1、二叉树的层序遍历
     给你二叉树的根节点 root ，返回其节点值的 层序遍历 。 （即逐层地，从左到右访问所有节点）。
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        return levelOrder_1(root)
        
        return levelOrder_2(root)
    }
    
    /* 解法1：广度优先搜索BFS：while、for双循环（while循环条件：动态数组个数，for循环条件：静态数组个数）
     人的思维，一层一层的添加。时间复杂度O(n)
     BFS解法公式：while、for双循环（while循环条件：动态数组个数，for循环条件：静态数组个数）
     [
        [3],
        [9, 10],
        [15, 7]
     ]
     */
    func levelOrder_1(_ root: TreeNode?) -> [[Int]] {
        // ⭐️ ！！！先排除空节点的情况，避免很多麻烦
        if (root == nil) {
            return []
        }
        
        var resultArr : [[Int]] = [] // 结果数组：声明一个空数组，存放最终结果，注意[[]]，这样可不是空数组
        var levelArr : [TreeNode] = [] // 层级数组：放置树中一层级的节点
        levelArr.append(root!) // 初始加入根节点
        
        while !levelArr.isEmpty { // 只要一层中还有节点没有处理，就进行循环处理
            var eleValueArr : [Int] = []
            
            var levelCount = levelArr.count // 固定值 作为当前层级的循环次数
            for _ in 0..<levelCount {
                // ⭐️ 注意：！！这里按数组元素固定个数遍历，而不是遍历数组，因为for里面不断在给数组levelArr添加元素。这样只会循环当前层级的次数
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
     DFS解法公式：递归调用，处理单根分支，数组索引记录分支层级
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
    
    
    
    
    
    /* 2、二叉树的最大深度
     给定一个二叉树 root ，返回其最大深度。
     二叉树的 最大深度 是指从根节点到最远叶子节点的最长路径上的节点数。
     */
    func maxDepth(_ root: TreeNode?) -> Int {
        return maxDepth_1(root)
        
        return maxDepth_2(root)
    }
    
    /* 解法1：分治 + 递归
     效率不高, 只击败18%
     */
    func maxDepth_1(_ root: TreeNode?) -> Int {
        // 排除空的情况
        if (root == nil) { return 0 }
        
        // 获取左分支的最大值
        var maxLeftDepth : Int = 0
        var leftNode : TreeNode? = nil
        leftNode = root?.left
        if (leftNode != nil) {
            maxLeftDepth = maxDepth(leftNode)
        }
        
        // 获取右分支的最大值
        var maxRightDepth : Int = 0
        var rightNode : TreeNode? = nil
        rightNode = root?.right
        if (rightNode != nil) {
            maxRightDepth = maxDepth(rightNode)
        }
        
        // 返回左、右分支中的最大者
        return 1 + max(maxLeftDepth, maxRightDepth)
    }
    
    /* 解法2：BFS： while、for双循环（while循环条件：动态数组个数，for循环条件：静态数组个数）
     完成：击败 56%
     */
    func maxDepth_2(_ root: TreeNode?) -> Int {
        if (root == nil) { return 0 }
        var maxDep : Int = 0
        
        var levelArr : [TreeNode]? = []
        levelArr?.append(root!)
        while !levelArr!.isEmpty {
            maxDep += 1
            let levelArrCount = levelArr?.count
            for _ in 0..<levelArrCount! {
                var superNode : TreeNode = levelArr!.removeFirst()
                
                var leftNode : TreeNode? = nil
                leftNode = superNode.left
                if (leftNode != nil) {
                    levelArr?.append(leftNode!)
                }
                
                var rightNode : TreeNode? = nil
                rightNode = superNode.right
                if (rightNode != nil) {
                    levelArr?.append(rightNode!)
                }
            }
        }
        
        return maxDep
    }
    
    
    
    
    
    
    
    /* 3、二叉树的最小深度
     给定一个二叉树，找出其最小深度。
     最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
     说明：叶子节点是指没有子节点的节点。
     */
    func minDepth(_ root: TreeNode?) -> Int {
        return minDepth_1(root)
        
        return minDepth_2(root)
    }
    
    /* 解法1：分治
     击败 84.34%
     */
    // 获取整个分支的最小深度
    func minDepth_1(_ root: TreeNode?) -> Int {
        if (root == nil) { return 0 }
        var leftNode : TreeNode? = nil
        leftNode = root?.left
        var rightNode : TreeNode? = nil
        rightNode = root?.right
        // 如果没有左子树，只需计算右子树的深度：没有左子树，不意味着整个分支的最小深度为1
        if (leftNode == nil) {
            return 1 + minDepth_1(rightNode)
        }
        // 如果没有右子树，只需计算左子树的深度
        if (rightNode == nil) {
            return 1 + minDepth_1(leftNode)
        }
        // 取出左、右节点，分别获取左、右两个分支的最小深度
        return 1 + min(minDepth_1(leftNode), minDepth_1(rightNode))
    }
    
    
    /* 解法2：BFS
     击败 84.34%
     */
    func minDepth_2(_ root: TreeNode?) -> Int {
        if (root == nil) {
            return 0
        }
        
        var queue : [TreeNode] = []
        queue.append(root!)
        
        var minDepth : Int = 0
        
        while !queue.isEmpty {
            minDepth += 1
            var queueCount : Int = queue.count
            for _ in 0..<queueCount {
                var firstNode = queue.removeFirst()
                
                /* 先取出 左、右节点
                var leftNode : TreeNode? = nil
                leftNode = firstNode.left
                var rightNode : TreeNode? = nil
                rightNode = firstNode.right
                
                // 找到叶子节点 直接返回当前minDepth
                if (leftNode == nil && rightNode == nil) {
                    return minDepth
                }
                if (leftNode != nil) {
                    queue.append(leftNode!)
                }
                if (rightNode != nil) {
                    queue.append(rightNode!)
                }
                 */
                
                /* 简化写法 代替上述写法 */
                // 直接判断左、右节点
                if (firstNode.left == nil && firstNode.right == nil) {
                    return minDepth
                }
                // 获取节点，并判断是否为nil (注意此时if里反而不能写括号，否则报错)
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        
        return minDepth
    }
}
