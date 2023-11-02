//
//  ListNode.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/11.
//

import Foundation

/* 链表节点类
 */

public class ListNode: Hashable {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int = 0, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
    
    // 实现Hashable协议
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(next)
    }
}
