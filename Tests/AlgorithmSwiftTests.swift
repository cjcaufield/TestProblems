//
//  AlgorithmSwiftTests.swift
//  TestProblems
//
//  Created by Colin Caufield on 2017-07-22.
//  Copyright © 2017 Secret Geometry, Inc. All rights reserved.
//

import XCTest

class AlgorithmSwiftTests: XCTestCase {
    
    func testSorts() {
        
        let sortFunctions = [bubbleSort, selectionSort, insertionSort, heapSort /*, mergeSort, quickSort*/]
        
        for functions in sortFunctions {
            
            XCTAssert(functions([]) == [])
            XCTAssert(functions([3, 2, 1]) == [1, 2, 3])
            XCTAssert(functions([1, 1, 1, 2, 1]) == [1, 1, 1, 1, 2])
            XCTAssert(functions([5, 1, 2, 3, 4]) == [1, 2, 3, 4, 5])
            XCTAssert(functions([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        }
    }
    
    //
    // Go through the array nums.count times and swap neighboring values as needed.
    //
    
    func bubbleSort(_ nums: [Int]) -> [Int] {
        
        var ns = nums
        
        for i in 0 ..< ns.count {
            
            let unsortedCount = ns.count - i
            
            for j in 0 ..< unsortedCount - 1 {
                
                if ns[j] > ns[j + 1] {
                    ns.swapAt(j, j + 1)
                }
            }
        }
        
        return ns
    }
    
    //
    //
    //
    
    func selectionSort(_ nums: [Int]) -> [Int] {
        
        var ns = nums
        
        for i in 0 ..< ns.count {
            
            let unsortedCount = ns.count - i
            
            var largest = Int.min
            var largestIndex = 0
            
            for j in 0 ..< unsortedCount {
                
                if ns[j] >= largest {
                    largest = ns[j]
                    largestIndex = j
                }
            }
            
            let from = largestIndex
            let to = unsortedCount - 1
            
            if from != to {
                ns.swapAt(from, to)
            }
        }
        
        return ns
    }
    
    //
    //
    //
    
    func insertionSort(_ nums: [Int]) -> [Int] {
        
        var ns = nums
        
        if nums.count == 0 {
            return []
        }
        
        for i in 1 ..< ns.count {
            
            let value = ns[i]
            
            var j = i
                
            while j > 0 && value < ns[j - 1] {
                
                ns[j] = ns[j - 1]
                j -= 1
            }
            
            ns[j] = value
        }
        
        return ns
    }
    
    //
    //
    //
    
    class FakeHeap<T: Comparable> {
        
        var array: [T]
        
        init(_ a: [T]) {
            array = a.sorted()
        }
        
        func insert(_ item: T) {
            array.append(item)
            array.sort()
        }
        
        func pop() -> T {
            return array.removeFirst()
        }
        
        var isEmpty: Bool {
            return array.isEmpty
        }
    }
    
    func heapSort(_ nums: [Int]) -> [Int] {
        
        let heap = FakeHeap(nums)
        
        var solution = [Int]()
        
        while !heap.isEmpty {
            solution.append(heap.pop())
        }
        
        return solution
    }
    
    //
    //
    //
    
    func mergeSort(_ nums: [Int]) -> [Int] {
        return []
    }
    
    //
    //
    //
    
    func quickSort(_ nums: [Int]) -> [Int] {
        return []
    }
    
    //
    // Search by looking looking in the middle of a region and adjusting the region's ends appropriately.
    //
    
    func testBinarySearch() {
        
        func binarySearch(_ nums: [Int], _ target: Int) -> Int {
            
            var l = 0
            var r = nums.count - 1
            
            while l <= r {
                
                let indexGuess = l + (r - l) / 2
                
                let value = nums[indexGuess]
                
                if value == target {
                    return indexGuess
                }
                
                if value < target {
                    l = indexGuess + 1
                } else {
                    r = indexGuess - 1
                }
            }
            
            return l
        }
        
        let single = [0]
        let primes = [1, 3, 5, 7, 11, 13, 17, 19, 23]
        
        XCTAssert(binarySearch(single, 0) == 0)
        
        XCTAssert(binarySearch(primes, 1) == 0)
        XCTAssert(binarySearch(primes, 5) == 2)
        XCTAssert(binarySearch(primes, 11) == 4)
        XCTAssert(binarySearch(primes, 23) == 8)
        
        XCTAssert(binarySearch(primes, 0) == 0)
        XCTAssert(binarySearch(primes, 4) == 2)
        XCTAssert(binarySearch(primes, 6) == 3)
        XCTAssert(binarySearch(primes, 22) == 8)
        XCTAssert(binarySearch(primes, 24) == 9)
    }
    
    func testLinkedLists() {
        
        let list = ListNode(values: 1, 2, 3, 4, 5)
        print("List is \(list)")
        
        list.append(6)
        print("List is \(list)")
        
        let (newList, target) = list.remove(2)
        print("New List is \(newList as Optional)")
        print("Target is \(target as Optional)")
        
    }
}
