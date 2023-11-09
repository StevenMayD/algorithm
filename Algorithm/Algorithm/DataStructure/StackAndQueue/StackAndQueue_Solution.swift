//
//  StackAndQueue_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/8/16.
//

import Foundation

/* 数据结构2 - 栈 stack
   数据结构3 - 队列 queue
 */

public class solution {
    /* 有效的括号
     目标: 判断一个只含有大、中、小括号的字符串，是否有效
     破局: 1.不管大中小括号，它们有左、右一对的概念
          2.成对出现的括号，才有效
          3.利用成对抵消，最终应该为空。 想到利用栈的概念处理
     解决: 根据左、右括号，进行栈的进栈和出栈操作，最终空栈，则为有效字符串

     */
    func isValid(_ s: String) -> Bool {
        /* 没有现成的栈类，通过数组来实现栈，入栈，出栈，空栈判断
         ⭐️ !!! 注意 数组的第一个元素.first是栈底，数组的最后一个元素.last是栈顶
         */
        var stack:[String] = [] // 栈 保存括号字符串
        var bracketDict:[String:String] = [")":"(", "]":"[", "}":"{"] // 字典存储“括号对“参照
        var sArr:[String] = s.map{ String($0) } // 将原字符串 转为 数组
        
        var isValidResult = true
        for keyStr in sArr {
            var valueStr = bracketDict[keyStr]
            if valueStr != nil && stack.isEmpty {
                // 如果字符是左括号 且此时栈中为空 则直接是无效字符串
                isValidResult = false
                break
            } else {
                // 如果是右括号
                if !stack.isEmpty {
                    // 非空栈
                    if valueStr == stack.last {
                        // 如果新括号 跟栈顶括号 配对了，则移除栈顶括号
                        stack.removeLast() // stack一定是非空栈，所以可以用removeLast()不会崩溃，否则得用popLast()
                    } else {
                        // 否则 入栈
                        stack.append(keyStr)
                    }
                } else {
                    // 空栈则 则将右括号进栈
                    stack.append(keyStr)
                }
                isValidResult = stack.isEmpty
            }
        }
        return isValidResult
    }
    
    // 简化原方法
    func isValid2(_ s: String) -> Bool {
        var stack:[Character] = []
        var bracketDict:[Character:Character] = [")":"(", "]":"[", "}":"{"] // 字符键值对
        
        for character in s { // 直接遍历字符串，元素为字符。 所以bracketDict中 为字符键值对
            if let valueStr = bracketDict[character] { // 如果字典值存在 则是左括号(来配对的)
                // 将判断栈顶内容.last 和 移除栈顶内容.removeLast()，用一个方法.popLast()来简化代替
                if stack.isEmpty || stack.popLast() != valueStr { // 栈顶内容 无法配对 或者 空栈
                    return false
                }
            } else {
                stack.append(character) // 如果是右括号（需要等待左括号配对），则直接添加
            }
        }
        return stack.isEmpty
    }
}

/* 用栈实现队列
 目标: 请你仅使用两个栈实现先入先出队列。队列应当支持一般队列支持的所有操作（push、pop、peek、empty）
 实现 MyQueue 类：
    void push(int x) 将元素 x 推到队列的末尾
    int pop() 从队列的开头移除并返回元素
    int peek() 返回队列开头的元素
    boolean empty() 如果队列为空，返回 true ；否则，返回 false
 
 破局: 1.用数组来实现栈
      2.用先入后出的栈结构，来实现先入先出的队列结构
 解决: 用数组实现栈，用两个栈来实现队列
 */
class MyQueue {
    var stack1:[Int]
    
    init() {
        self.stack1 = []
    }
    // 入列
    func push(_ x: Int) {
        self.stack1.append(x)
    }
    // 出列：swift高级语言 可以直接返回 return self.stack1.removeFirst()
    func pop() -> Int {
        var stack2:[Int] = []
        for item in self.stack1.reversed() { // 逆序遍历stack1，添加到stack2中
            stack2.append(item)
        }
        self.stack1.removeFirst() // 原先的stack1中也要移除
        return stack2.popLast()!
    }
    // 获取队列顶部元素：swift高级语言 可以直接 return stack1.first
    func peek() -> Int {
        var stack2:[Int] = []
        for item in self.stack1.reversed() { // 逆序遍历
            stack2.append(item)
        }
        return stack2.last!
    }
    // 判断是否空队列
    func empty() -> Bool {
        return self.stack1.isEmpty
    }
}

/* 用队列实现栈：虽然swift的数组有高级的方法可以直接获取首位元素，但是按算法的要求，需要自己实现
目标：请你仅使用两个队列实现一个后入先出（LIFO）的栈，并支持普通栈的全部四种操作（push、top、pop 和 empty）。
 实现 MyStack 类：

 void push(int x) 将元素 x 压入栈顶。
 int pop() 移除并返回栈顶元素。
 int top() 返回栈顶元素。
 boolean empty() 如果栈是空的，返回 true ；否则，返回 false 。
 */
class MyStack {
    var inputQueue:[Int]
    var outputQueue:[Int]
    
    init() {
        inputQueue = []
        outputQueue = []
    }
    // 进栈
    func push(_ x: Int) {
        inputQueue.append(x)
    }
    // 出栈
    func pop() -> Int {
        for item in inputQueue {
            outputQueue.append(item)
        }
        inputQueue.removeLast()
        return outputQueue.removeLast()
    }
    // 获取栈顶元素
    func top() -> Int {
        for item in inputQueue {
            outputQueue.append(item)
        }
        return outputQueue.last!
    }
    // 判断是否空栈
    func empty() -> Bool {
        return inputQueue.isEmpty
    }
}
