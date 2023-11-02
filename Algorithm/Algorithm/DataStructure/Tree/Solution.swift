//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/9/28.
//

import Foundation

/* 数据结构6 - 树 Tree
 */

// 树节点类
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

// 树类
class Tree {
    /* 1、验证二叉搜索树
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
        
        /* 递归 检查左子树和右子树：针对左、右树，调整合理范围的阈值
         ⭐️ 注意：递归左分支时，左分支的右节点的maxVal，始终就是根节点的值，而不是无穷大
                即意味着整树的左分支的右子分支的节点的有效范围就是（该节点的父节点(动态的)，树的根节点(固定的)）
         同理，递归右分支时，右分支的左节点的minVal，始终就是根节点的值，而不是无穷小
                即意味着整树的右分支的左子分支的节点的有效范围就是（树的根节点(固定的)，该节点的父节点(动态的)）
         */
        return isValidBST(node!.left, minVal, node!.val) && isValidBST(node!.right, node!.val, maxVal)
    }
    
    
    
    /* 2、二叉树的最近公共祖先
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        // 先排除空树
        if root == nil {
            return root
        }
        // 再排除p或q其中一个就是根节点的情况
        if (root === p || root === q) {
            return root
        }
        
        /* 剩下的情况：要么p和q在根节点的同一侧子树，要么在左、右两个子树中 */
        
        // 进行递归调用：分别以根节点的左、右节点为根节点，来寻找p、q的公共祖先
        let leftTreeCommonAncestor = lowestCommonAncestor(root?.left, p, q)
        let rightTreeCommonAncestor = lowestCommonAncestor(root?.right, p, q)
        // 先判断 如果左右两侧都找到了非空值，则p、q位于根节点两侧，直接返回root
        if (leftTreeCommonAncestor != nil && rightTreeCommonAncestor != nil) {
            return root
        }
        // 判断非两侧后，如果在左子树中找到非空值，则p、q都位于根节点左子树一侧，该非空值左节点就是公共祖先
        if (leftTreeCommonAncestor != nil) {
            return leftTreeCommonAncestor
        }
        // 如果在右子树中找到非空值，则p、q都位于根节点右子树一侧，该非空值右节点就是公共祖先
        if (rightTreeCommonAncestor != nil) {
            return rightTreeCommonAncestor
        }
        
        return nil
    }
}
