//
//  Trie_Solution.swift
//  Algorithm
//
//  Created by 酷学院i7 on 2023/11/2.
//

import Foundation

/* 数据结构7 - 字典树 Trie
 */

// MARK: 1、实现 Trie (前缀树)：https://leetcode.cn/problems/implement-trie-prefix-tree/description/
    /*
     请你实现 Trie 类：
     Trie() 初始化前缀树对象。
     void insert(String word) 向前缀树中插入字符串 word 。
     boolean search(String word) 如果字符串 word 在前缀树中，返回 true（即，在检索之前已经插入）；否则，返回 false 。
     boolean startsWith(String prefix) 如果之前已经插入的字符串 word 的前缀之一为 prefix ，返回 true ；否则，返回 false 。
     */

// Trie节点类
class TrieNode {
    // 孩子字典对象，用于存储节点的路劲和子节点
    var children : [Character : TrieNode] = [:]
    // 结尾标志：用于表示该节点是否是一个单词的结尾. 初始值默认为false
    var isEndOfWord : Bool = false
}

// Trie类
class Trie {
    private var root:TrieNode
    
    init() {
        root = TrieNode()
    }
    
    /*
     ⭐️ 注意：insert时，每次node都会移动到newNode一个新空间，循环中的node是不一样的；
     就算出现wowowo的单词，也不会发生回路指向
     */
    func insert(_ word: String) {
        var node = root
        for char in word {
            if (node.children[char] == nil) {
                // 如果路劲char不存在，那么就是一条新路径，创建一个新节点，作为路径char的目的地，并将node指向该新节点
                var newNode = TrieNode()
                node.children[char] = newNode
                node = newNode
            } else {
                // ⭐️：如果路径char存在 直接将node指向路径节点，不需要创建新节点空间（单个单词的遍历不会运行到这里。但是重复insert同一个单词，会执行到这里，以免重复破坏Trie路径的唯一性）
                node = node.children[char]!
            }
        }
        // 遍历完字符串，末尾节点的结尾标志为true
        node.isEndOfWord = true
    }
    
    // 字典树中是否存在word单词: 意思是 准确存在，word得是叶子节点，而不是存在word前缀
    func search(_ word: String) -> Bool {
        var node = root
        for char in word {
            if (node.children[char] != nil) {
                node = node.children[char]!
            } else {
                return false
            }
        }
        // 能顺利遍历完word且word是叶子节点，说明word存在
        return node.isEndOfWord
    }
    
    // 字典树种是否存在前缀为prefix的单词：意思是包括 以prefix为前缀，或者单子就是prefix 叶子节点
    func startsWith(_ prefix: String) -> Bool {
        var node = root
        for char in prefix {
            if (node.children[char] != nil) {
                node = node.children[char]!
            } else {
                return false
            }
        }
        return true
    }
    
    
    // MARK: 2、单词搜索 II https://leetcode.cn/problems/word-search-ii/
        /* 未完成
         给定一个 m x n 二维字符网格 board 和一个单词（字符串）列表 words， 返回所有二维网格上的单词 。
         单词必须按照字母顺序，通过 相邻的单元格 内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母在一个单词中不允许被重复使用。
         */
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {

        return findWords_DFS(board, words)
        
        return findWords_Trie(board, words)
    }
    
    /* 解法1：DFS 深度优先遍历
     */
    func findWords_DFS(_ board: [[Character]], _ words: [String]) -> [String] {

        return []
    }
    
    /* 解法2：Trie 字典树
     */
    func findWords_Trie(_ board: [[Character]], _ words: [String]) -> [String] {

        return []
    }
}
