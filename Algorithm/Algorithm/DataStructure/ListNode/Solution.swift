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
            var next = cur?.next // =号右边.next，表示获取下一个节点对象，保存当前的next节点
            // =号左边.next，表示cur的下一节点指向pre节点（注意，这里cur.next是cur的指向赋值，并不是上一步的cur的next节点 ，不能直接temp=pre）
            cur?.next = pre
            pre = cur // pre赋值为新对象cur，pre逐步移动指向
            cur = next // cur复制为新对象cur的下一个节点，cur逐步移动指向(swift可以赋值 cur=cur?.next)
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
    
    /* 环形链表
     目标：判断一个链表中，是否有环
     破局：链表中有环的话，不论环多长，只可能有一个环，且是封闭的环，因为链表的节点可以是其他连个节点的next，但节点本身不可能有连个next
     解决：快、慢两个指针对象，判断是否相等过，相等过 则存在环， 否则是直链
     */
    func hasCycle(_ head: ListNode?) -> Bool {
        // 解法1：硬找 是否存在最终节点为nil. 如果有环，会永远执行，所以需要限定一个时间，计算了0.5s，没有到头，认为是链表中有环
        //获取当前时间戳
        /*
        let currentTime = Date().timeIntervalSince1970 // 10位数时间戳 精确到秒
        let timestamp = Int64(currentTime * 1000) // 13位数时间戳 精确到毫秒
        
        var pre = head
        while pre?.next != nil {
            var next = pre?.next
            pre = next?.next
            
            let currentTime2 = Date().timeIntervalSince1970
            let timestamp2 = Int64(currentTime2 * 1000)
            if timestamp2-timestamp>500 {
                return true
            }
        }
        return false
         */
        
        // 解法2：集合set收集遍历过的节点，每次比较，新的节点是否属于set中 : 需要ListNode遵循并实现Hashable协议，无法写到leetcode中
//        var set = Set<ListNode>()
//        var cur = head
//        set.insert(cur!)
//        while cur?.next != nil {
//            var latter = cur?.next
//            if set.contains(latter!) { // 判断集合中是否含有新节点
//                return true
//            } else {
//                set.insert(latter!)
//            }
//        }
//        return false
        
        
        
        /* 解法3：快、慢两个指针对象，判断是否相等过，相等过 则存在环， 否则是直链
         == 操作检测实例的值是否相等，"equal to"
         === 操作检测指针引用的是否为同一个实例，"identical to"
         */
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            if (fast === slow) { // 判断连个节点对象 是否相等
                return true
            }
        }
        return false
    }
    
    /* 链表2：给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
     破局：  1.入环的第一个节点，一定是第一个经历两次遍历的节点
            2. 一定有两个前向节点，一个next节点
            3.入环的第一个节点，是环之前的线性链与环的交叉点
     解决：使用快慢指针的方法来实现。首先判断链表是否存在环，如果存在环，找到环的起始节点
     */
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        var isCycle = false
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            if (fast === slow) { // 这样是找快慢节点相遇的点，不一定就在环的第一个节点相遇
                isCycle = true
                break
            }
        }
        
        if isCycle == false {
            return nil
        } else {
            var new = head
            while new !== slow {
                new = new?.next
                slow = slow?.next
            }
            return new
        }
    }
    
    /* K个一组翻转链表
     目标: 给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。
     破局: 1. 如何知道 组内不到k个节点 就不翻转：先循环链表，记录链表个数是否足够k个
          2. 有整体的重复操作，就有递归：反转链表，反转了k个节点，就递归调用
     解决: 反转 + 递归
     */
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var current = head
            var count = 0
            
            // 统计链表节点总数 小于 k
            while current != nil && count < k {
                current = current?.next
                count += 1
            }
            
            // 链表比k长 则进行按k分组 反转
            if count == k {
                var prev: ListNode? = nil
                var tempCurrent = head
                
                // 反转k个节点
                for _ in 0..<k {
                    let tempNext = tempCurrent?.next
                    tempCurrent?.next = prev
                    prev = tempCurrent
                    tempCurrent = tempNext // 循环结束，tempCurrent为下一组的头节点
                }
                
                // 递归反转其余组
                if tempCurrent != nil {
                    // 反转一组节点之后 head从头节点变成了尾节点，重新赋值head的后向节点（该后向节点就是 下一组链表反转后的头节点）
                    head?.next = reverseKGroup(tempCurrent, k)
                }
                return prev
            }
            // k比链表还长 则直接返回原链表
            return head
    }
    
}
