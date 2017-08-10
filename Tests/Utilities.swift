//
//  Utilities.swift
//  TestProblems
//
//  Created by Colin Caufield on 2017-05-16.
//  Copyright © 2017 Secret Geometry, Inc. All rights reserved.
//

import Foundation

// Functions

func equal2DArrays<T: Equatable>(_ a: [[T]], _ b: [[T]]) -> Bool {
    
    if a.count != b.count {
        return false
    }
    
    for i in 0 ..< a.count {
        
        if a[i] != b[i] {
            return false
        }
    }
    
    return true
}

// Stack

class Stack {
    
    var values = [Character]()
    
    var isEmpty: Bool {
        return values.isEmpty
    }
    
    var top: Character? {
        return values.last
    }
    
    func push(_ c: Character) {
        values.append(c)
    }
    
    func pop() {
        values.removeLast()
    }
}

// ListNode

class ListNode: CustomStringConvertible {
    
    public var val: Int
    public var next: ListNode?
    
    public init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
    
    public init(values: Int...) {
        
        self.val = 0
        self.next = nil
        
        var previous: ListNode?
        
        for val in values {
            
            if previous == nil {
                self.val = val
                previous = self
            } else {
                let newNode = ListNode(val)
                previous!.next = newNode
                previous = newNode
            }
        }
    }
    
    func tail() -> ListNode {
    
        var node = self
        
        while node.next != nil {
            node = node.next!
        }
        
        return node
    }
    
    func append(_ value: Int) {
        
        self.tail().next = ListNode(value)
    }
    
    func remove(_ value: Int) -> (head: ListNode?, target: ListNode?) {
        
        let head = self
        var prev: ListNode?
        var node: ListNode? = head
        
        while node != nil {
            
            if node!.val == value {
                
                if node! === head {
                    
                    let newHead = head.next
                    head.next = nil
                    return (head: newHead, target: head)
                    
                } else {
                    
                    prev!.next = node!.next
                    node!.next = nil
                    return (head: head, target: node)
                }
            }
            
            prev = node
            node = node!.next
        }
        
        return (head: head, target: nil)
    }
    
    public var description: String {
        
        var result = "("
        var current: ListNode? = self
        
        while current != nil {
            
            if current! !== self {
                result += " -> "
            }
            
            result += String(describing: current!.val)
            
            current = current!.next
        }
        
        result += ")"
        
        return result
    }
}

// TreeNode

public class TreeNode: CustomStringConvertible {
    
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public init(values: Int?...) {
        
        self.val = values[0]!
        
        var parents: [TreeNode?] = [self]
        var children: [TreeNode?] = []
        
        var index = 1
        
        while index < values.count {
            
            for n in parents {
                
                if n == nil {
                    continue
                }
                
                if let val = values[index] {
                    n?.left = TreeNode(val)
                }
                
                index += 1
                children += [n?.left]
                
                if index >= values.count {
                    return
                }
                
                if let val = values[index] {
                    n?.right = TreeNode(val)
                }
            
                index += 1
                children += [n?.right]
                
                if index >= values.count {
                    return
                }
            }
            
            parents = children
            children = []
        }
    }
    
    public var values: [Int?] {
        
        var array = [Int?]()
        var nodes: [TreeNode?] = [self]
        
        while !nodes.isEmpty {
            
            var hasNonNils = false
            
            for n in nodes {
                if n != nil {
                    hasNonNils = true
                }
            }
            
            if !hasNonNils {
                break
            }
            
            array += nodes.map { return $0?.val }
            
            nodes = nodes.flatMap { return [$0?.left, $0?.right] }
        }
        
        return array
    }
    
    public var description: String {
        
        var str = "["
        
        for (i, val) in self.values.enumerated() {
            
            if i != 0 {
                str += ", "
            }
            
            if let val = val {
                str += String(val)
            } else {
                str += "nil"
            }
        }
        
        str += "]"
        
        return str
    }
}
