//
//  Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/11.
//

import Foundation

public class Solution {
    // 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        var cur = head // 当前节点
        var pre:ListNode? = nil // 前向节点
        while (cur != nil) {
            var next = cur?.next // =号右边.next，表示获取下一个节点对象，swift无法赋值 cur=cur?.next
            // =号左边.next，表示cur的下一节点指向pre节点（注意，这里cur.next是cur的指向赋值，并不是上一步的cur的next节点 ，不能直接temp=pre）
            cur?.next = pre
            pre = cur // pre赋值为新对象cur，pre逐步移动指向
            cur = next // cur复制为新对象cur的下一个节点，cur逐步移动指向
        }
        return pre
    }
    
    // 两两交换链表中的节点
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummy:ListNode = ListNode() // 创建一个新节点，作为头节点
        dummy.next = head // 该节点下一节点指向head
        var prev = dummy // 新变量引用该节点
        
        while let first = prev.next, let second = first.next { // 获取待比较的两个节点
            let temp = second.next // 获取第三个节点
            second.next = first // 让第二个节点的next指向第一个节点
            first.next = temp // 第一个节点的next指向第三节点
            prev.next = second // 新节点指向第二节点
            prev = first // 新节点赋值为第一节点
        }
        
        return dummy.next
    }
    
    // 环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        // 解法1：硬找 是否存在最终节点为nil. 如果有环，会永远执行，所以需要限定一个时间，1s内不退出循环，认为是环
//        var pre = head
//        while pre?.next != nil {
//            var next = pre?.next
//            pre = next?.next
//        }
//        return false
        
        // 解法2：集合set收集遍历过的节点，每次比较，新的节点是否属于set中
        
        // 解法3：两个指针对象，判断是否相等过，相等过 则存在环， 否则是直链

        return true
    }
    
    
    
    
}
