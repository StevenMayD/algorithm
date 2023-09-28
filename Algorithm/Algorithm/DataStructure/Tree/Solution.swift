//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/9/28.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Tree {
    /* 验证二叉搜索树
     
     Int.min 和 Int.max 是用来表示整数类型 Int 的最小和最大可能值的常量。它们的具体含义如下：
     Int.min：这个常量代表了 Int 类型的最小值。在大多数平台上，它等于 -2,147,483,648（如果系统使用 32 位整数）。这是一个整数可以表示的最小值。
     Int.max：这个常量代表了 Int 类型的最大值。在大多数平台上，它等于 2,147,483,647（如果系统使用 32 位整数）。这是一个整数可以表示的最大值。
     */
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, Int.min, Int.max)
    }
    
    func isValidBST(_ node: TreeNode?, _ minVal: Int, _ maxVal: Int) -> Bool {
        // 如果节点为空，说明是有效的
        if node == nil {
            return true
        }
        
        // 检查当前节点的值是否在合法范围内
        if node!.val <= minVal || node!.val >= maxVal {
            return false
        }
        
        // 递归检查左子树和右子树：针对左、右树，调整合理范围的阈值
        return isValidBST(node!.left, minVal, node!.val) && isValidBST(node!.right, node!.val, maxVal)
    }
}
