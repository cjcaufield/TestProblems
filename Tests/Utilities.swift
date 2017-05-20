//
//  Utilities.swift
//  TestProblems
//
//  Created by Colin Caufield on 2017-05-16.
//  Copyright © 2017 Secret Geometry, Inc. All rights reserved.
//

import Foundation

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
