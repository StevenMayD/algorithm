//
//  ListNode.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/11.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int = 0, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}
