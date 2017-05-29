//
//  LeetCodeTests.swift
//  Tests
//
//  Created by Colin Caufield on 2017-05-16.
//  Copyright © 2017 Secret Geometry, Inc. All rights reserved.
//

import XCTest

class LeetCodeTests: XCTestCase {
    
    // MARK: - 1. Two Sum
    
    func testProblem1() {
        
        func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
            
            var indexForNum = [Int: Int]()
            
            for (index, num) in nums.enumerated() {
                
                let otherNum = target - num
                
                if let otherIndex = indexForNum[otherNum] {
                    return [otherIndex, index]
                }
                
                indexForNum[num] = index
            }
            
            return []
        }
        
        let nums = [2, 7, 11, 15]
        let target = 14
        
        let indices = twoSum(nums, target)
        
        print("Two Sum of \(nums) for \(target) is \(indices)")
    }
    
    // MARK: - 2. Add Two Numbers
    
    func testProblem2() {
        
        func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            
            var solution: ListNode?
            var lastNode: ListNode?
            
            var node1 = l1
            var node2 = l2
            
            var carry = 0
            
            while true {
                
                if node1 == nil && node2 == nil && carry == 0 {
                    break
                }
                
                let value1 = node1?.val ?? 0
                let value2 = node2?.val ?? 0
                
                let sum = value1 + value2 + carry
                let digit = sum % 10
                
                let newNode = ListNode(digit)
                
                if lastNode == nil {
                    solution = newNode
                } else {
                    lastNode!.next = newNode
                }
                
                lastNode = newNode
                
                carry = sum / 10
                
                node1 = node1?.next
                node2 = node2?.next
            }
            
            if solution != nil {
                return solution
            } else {
                return ListNode(0)
            }
        }
        
        let l1 = ListNode(values: 2, 4, 3)
        let l2 = ListNode(values: 5, 6, 4)
        
        let result = addTwoNumbers(l1, l2)!
        
        print("\(l1) + \(l2) = \(result)")
    }
    
    // MARK: - 3. Longest Substring Without Repeating Characters
    
    func testProblem3() {
        
        func lengthOfLongestSubstring(_ s: String) -> Int {
            
            let array = Array(s.characters)
            
            func charAt(_ i: Int) -> Character {
                return array[i]
            }
            
            var range = (0 ..< 0)
            var largestRange = range
            var characters = Set<Character>()
            
            while true {
                
                let newIndex = range.lowerBound + range.count
                
                if newIndex >= s.characters.count {
                    
                    if range.count >= largestRange.count {
                        largestRange = range
                    }
                    
                    break
                }
                
                let newChar = array[newIndex]
                
                if characters.contains(newChar) {
                    
                    if range.count >= largestRange.count {
                        largestRange = range
                    }
                    
                    let oldIndex = range.lowerBound
                    let oldChar = array[oldIndex]
                    
                    characters.remove(oldChar)
                    
                    range = (range.lowerBound + 1 ..< range.upperBound)
                    
                } else {
                    
                    characters.insert(newChar)
                    range = (range.lowerBound ..< range.upperBound + 1)
                }
            }
            
            return largestRange.count
        }
        
        func printTest(_ s: String) {
            
            let answer = lengthOfLongestSubstring(s)
            
            print("lengthOfLongestSubstring(\"\(s)\") = \(answer)")
        }
        
        printTest("abcabcbb")
        printTest("bbbbb")
        printTest("pwwkew")
    }
    
    // MARK: - 5. Longest Palindromic Substring
    
    func testProblem5() {
        
        func longestPalindrome(_ s: String) -> String {
            
            let chars = Array(s.characters)
            
            let len = chars.count
            
            func longestPalindrome(centeredAt center: Int, odd: Bool) -> Int {
                
                var count = 0
                var l = center - 1
                var r = center
                
                if odd {
                    count += 1
                    r += 1
                }
                
                while l >= 0 && r < len && chars[l] == chars[r] {
                    
                    count += 2
                    l -= 1
                    r += 1
                }
                
                return count
            }
            
            var longestCount = 0
            var longestCenter = 0
            var longestIsOdd = false
            
            for i in 0 ..< len {
                
                let count1 = longestPalindrome(centeredAt: i, odd: false)
                let count2 = longestPalindrome(centeredAt: i, odd: true)
                
                let count = max(count1, count2)
                
                if count > longestCount {
                    
                    longestCount = count
                    longestCenter = i
                    longestIsOdd = (count == count2)
                }
            }
            
            var first = 0
            var last = 0
            
            if longestIsOdd {
                first = longestCenter - longestCount / 2
                last = longestCenter + longestCount / 2
            } else {
                first = longestCenter - longestCount / 2
                last = longestCenter + longestCount / 2 - 1
            }
            
            return String(chars[first ..< last + 1])
        }
        
        print(longestPalindrome("my_racecar_"))
        print(longestPalindrome("cbabcad"))
        print(longestPalindrome("cbbbfbdbbbbb"))
    }
    
    // MARK: - 6. ZigZag Conversion
    
    func testProblem6() {
        
        func convert(_ s: String, _ numRows: Int) -> String {
            
            if numRows == 1 {
                return s
            }
            
            let a = Array(s.characters)
            let len = a.count
            
            func convertRow(_ r: Int) -> String {
                
                var solution = ""
                
                let startOffset = r
                
                let fullStride = 2 * (numRows - 1)
                
                if r == 0 || r == numRows - 1 {
                    
                    var i = startOffset
                    
                    while i < len {
                        solution += String(a[i])
                        i += fullStride
                    }
                    
                    return solution
                }
                
                let stride1 = 2 * (numRows - 1 - r)
                let stride2 = 2 * r
                
                var b = true
                
                var i = startOffset
                
                while i < len {
                    solution += String(a[i])
                    i += (b) ? stride1 : stride2
                    b = !b
                }
                
                return solution
            }
            
            var solution = ""
            
            for r in 0 ..< numRows {
                solution += convertRow(r)
            }
            
            return solution
        }
        
        print(convert("A", 1))
        print(convert("ABCD", 4))
        print(convert("PAYPALISHIRING", 3))
    }
    
    // MARK: - 7. Reverse Integer
    
    func testProblem7() {
        
        func reverse(_ x: Int) -> Int {
            
            let sign = (x >= 0) ? 1 : -1
            
            var r = abs(x)
            
            var solution: Int64 = 0
            
            while r > 0 {
                
                let digit = r % 10
                r = r / 10
                
                solution *= Int64(10)
                solution += Int64(digit)
                
                if solution > Int64(Int32.max) {
                    return 0
                }
            }
            
            return sign * Int(solution)
        }
        
        let x = 123
        let y = -123
        
        print("reverse(\(x)) = \(reverse(x))")
        print("reverse(\(y)) = \(reverse(y))")
    }
    
    // MARK: - 8. String to Integer
    
    func testProblem8() {
        
        func myAtoi(_ str: String) -> Int {
            
            let whitespaceSet = NSCharacterSet.whitespacesAndNewlines
            let decimalSet = NSCharacterSet.decimalDigits
            
            func isWhitespace(_ c: Character) -> Bool {
                return String(c).rangeOfCharacter(from: whitespaceSet) != nil
            }
            
            func isDigit(_ c: Character) -> Bool {
                return String(c).rangeOfCharacter(from: decimalSet) != nil
            }
            
            func charToInt(_ c: Character) -> Int? {
                return Int(String(c))
            }
            
            let a = Array(str.characters)
            let len = a.count
            
            var sign = 1
            var solution: Decimal = 0
            
            var i = 0
            
            // Remove leading whitespace
            
            while true {
                
                if i >= len {
                    return 0
                }
                
                if !isWhitespace(a[i]) {
                    break
                }
                
                i += 1
            }
            
            // Handle plus/minus sign
            
            if a[i] == "+" {
                i += 1
            } else if a[i] == "-" {
                sign = -1
                i += 1
            }
            
            if i >= len {
                return 0
            }
            
            // Handle digits
            
            while i < len {
                
                let c = a[i]
                
                if !isDigit(c) {
                    break
                }
                
                if let digit = charToInt(c) {
                    solution = solution * Decimal(10)
                    solution += Decimal(digit)
                } else {
                    return 0
                }
                
                if sign > 0 && solution > Decimal(Int.max) {
                    return Int.max
                } else if sign < 0 && -solution < Decimal(Int.min) {
                    return Int.min
                }
                
                i += 1
            }
            
            return sign * Int(NSDecimalNumber(decimal: solution))
        }
        
        print(myAtoi("1"))
        print(myAtoi("9fsdfsdf"))
        print(myAtoi("+10"))
        print(myAtoi("-99999999"))
        print(myAtoi("-9223372036854775809"))
        print(myAtoi(""))
        print(myAtoi("      999jfdksljfldskjf"))
    }
    
    // MARK: - 9. Palindrome Number
    
    func testProblem9() {
        
        func isPalindrome(_ x: Int) -> Bool {
            
            if x < 0 {
                return false
            }
            
            if x == 0 {
                return true
            }
            
            let len = Int(log10(Double(x))) + 1
            
            func digitAt(_ i: Int) -> Int {
                
                let p = Int(pow(10.0, Double(i)))
                let shifted = x / p
                return shifted % 10
            }
            
            for i in 0 ..< len / 2 {
                
                if digitAt(i) != digitAt(len - i - 1) {
                    return false
                }
            }
            
            return true
        }
        
        print(isPalindrome(0))
        print(isPalindrome(1))
        print(isPalindrome(121))
        print(isPalindrome(123))
        print(isPalindrome(123454321))
        print(isPalindrome(123454322))
    }
    
    // MARK: - 11. Container With Most Water
    
    func testProblem11() {
        
        func maxArea(_ height: [Int]) -> Int {
            
            let len = height.count
            
            var largest = 0
            
            var i = 0
            var j = len - 1
            
            while i < j {
                
                let y1 = height[i]
                let y2 = height[j]
                
                let usableHeight = min(y1, y2)
                let width = j - i
                let amount = usableHeight * width
                
                if amount > largest {
                    largest = amount
                }
                
                if y1 < y2 {
                    i += 1
                } else {
                    j -= 1
                }
            }
            
            return largest
        }
    }
    
    // MARK: - 12. Integer To Roman
    
    func testProblem12() {
        
        func intToRoman(_ num: Int) -> String {
            
            var remaining = num
            var solution = ""
            
            var table = [
                
                1000: "M",
                500: "D",
                100: "C",
                50: "L",
                10: "X",
                5: "V",
                1: "I"
            ]
            
            for n in [1000, 100, 10, 1] {
                
                let count = remaining / n
                
                let char = table[n]!
                
                if count == 4 || count == 9 {
                    solution += char
                }
                
                if 4 <= count && count <= 8 {
                    solution += table[5 * n]!
                }
                
                if count == 9 {
                    solution += table[10 * n]!
                }
                
                if 1 <= count && count <= 3 {
                    for _ in 0 ..< count { solution += char }
                }
                
                if 6 <= count && count <= 8 {
                    for _ in 0 ..< (count - 5) { solution += char }
                }
                
                remaining -= count * n
            }
            
            return solution
        }
        
        for i in 0 ..< 100 {
            print(intToRoman(i))
        }
    }
    
    // MARK: - 13. Roman To Integer
    
    func testProblem13() {
        
        func romanToInt(_ s: String) -> Int {
            
            var solution = 0
            var prevValue = 0
            
            var valueForChar: [Character: Int] = [
                
                "I": 1,
                "V": 5,
                "X": 10,
                "L": 50,
                "C": 100,
                "D": 500,
                "M": 1000
            ]
            
            for c in s.characters {
                
                guard let value = valueForChar[c] else {
                    print("Invalid character: \(c).")
                    return 0
                }
                
                solution += value
                
                if value > prevValue {
                    solution -= 2 * prevValue
                }
                
                prevValue = value
            }
            
            return solution
        }
        
        print(romanToInt("I"))
        print(romanToInt("II"))
        print(romanToInt("III"))
        print(romanToInt("IV"))
        print(romanToInt("V"))
        print(romanToInt("VI"))
        print(romanToInt("VII"))
        print(romanToInt("VIII"))
        print(romanToInt("IX"))
        print(romanToInt("X"))
        print(romanToInt("XC"))
    }
    
    // MARK: - 14. Longest Common Prefix
    
    func testProblem14() {
        
        func longestCommonPrefix(_ strs: [String]) -> String {
            
            if strs.count == 0 {
                return ""
            }
            
            if strs.count == 1 {
                return strs[0]
            }
            
            func index(_ s: String, _ i: Int) -> String.CharacterView.Index {
                return s.index(s.startIndex, offsetBy: i)
            }
            
            func charAt(_ s: String, _ i: Int) -> Character {
                return s[index(s, i)]
            }
            
            var i = 0
            
            outer: while true {
                
                var match: Character?
                
                for str in strs {
                    
                    if i >= str.characters.count {
                        break outer
                    }
                    
                    let c = charAt(str, i)
                    
                    if match == nil {
                        match = c
                    } else {
                        if c != match {
                            break outer
                        }
                    }
                    
                }
                
                i += 1
            }
            
            let end = index(strs[0], i)
            return strs[0].substring(to: end)
        }
        
        let a = "Col"
        let b = "Colin"
        let c = "Colin John"
        let d = "Colin John Caufield"
        
        let strs = [a, b, c, d]
        
        print(longestCommonPrefix(strs))
    }
    
    // MARK: - 17. Letter Combinations of a Phone Number
    
    func testProblem17() {
        
        var characters = [
            "2": ["a", "b", "c"],
            "3": ["d", "e", "f"],
            "4": ["g", "h", "i"],
            "5": ["j", "k", "l"],
            "6": ["m", "n", "o"],
            "7": ["p", "q", "r", "s"],
            "8": ["t", "u", "v"],
            "9": ["w", "x", "y", "z"],
        ]
        
        func letterCombinations(_ digits: String) -> [String] {
            
            if digits.isEmpty {
                return []
            }
            
            let digit = String(digits.characters.first!)
            var subdigits = digits
            subdigits.remove(at: digits.startIndex)
            
            var solutions = [String]()
            let subsolutions = letterCombinations(subdigits)
            
            if let chars = characters[digit] {
                for c in chars {
                    if subsolutions.isEmpty {
                        solutions.append(c)
                    } else {
                        for subsolution in subsolutions {
                            solutions.append(c + subsolution)
                        }
                    }
                }
            } else {
                return subsolutions
            }
            
            return solutions
        }
        
        print(letterCombinations("318"))
    }
    
    // MARK: - 19. Remove Nth Node From End of List
    
    func testProblem19() {
        
        func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
            
            var count = 0
            var node = head
            var target: ListNode?
            var targetPrev: ListNode?
            var newHead = head
            
            while node != nil {
                
                count += 1
                
                node = node!.next
                
                if count == n {
                    target = head
                } else {
                    targetPrev = target
                    target = target?.next
                }
            }
            
            if target === head {
                newHead = target?.next
            }
            
            targetPrev?.next = target?.next
            target?.next = nil
            
            return newHead
        }
        
        let before = ListNode(values: 1, 2, 3, 4, 5)
        print(before)
        
        let after = removeNthFromEnd(before, 5)!
        print(after)
    }
    
    // MARK: - 20. Valid Parethesis
    
    func testProblem20() {
        
        let openBraces: [Character] = ["(", "[", "{"]
        let closeBraces: [Character] = [")", "]", "}"]
        
        func isValid(_ s: String) -> Bool {
            
            let stack = Stack()
            
            for c in s.characters {
                
                if openBraces.contains(c) {
                    
                    stack.push(c)
                    
                } else if closeBraces.contains(c) {
                    
                    guard let top = stack.top else {
                        return false
                    }
                    
                    let openIndex = openBraces.index(of: top)
                    let closeIndex = closeBraces.index(of: c)
                    
                    if openIndex != closeIndex {
                        return false
                    }
                    
                    stack.pop()
                }
            }
            
            return stack.isEmpty
        }
        
        print(isValid("()"))
        print(isValid("()[]{}"))
        print(isValid("(]"))
        print(isValid("([)]"))
    }
    
    // MARK: - 21. Merge Two Sorted Lists
    
    func testProblem21() {
        
        func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            
            var solution: ListNode?
            var last: ListNode?
            
            var l = l1
            var r = l2
            
            while true {
                
                var next: ListNode?
                
                if l == nil && r == nil {
                    return solution
                }
                
                var useLeft = true
                
                if l != nil && r != nil {
                    useLeft = l!.val < r!.val
                }
                
                if l == nil {
                    useLeft = false
                }
                
                if useLeft {
                    next = l
                    l = l?.next
                } else {
                    next = r
                    r = r?.next
                }
                
                if solution == nil {
                    solution = next
                } else {
                    last!.next = next
                }
                
                last = next
            }
        }
        
        let l = ListNode(values: 1, 3, 5, 7, 9)
        let r = ListNode(values: 2, 4, 6, 8, 10)
        
        print(l)
        print(r)
        
        
        print(mergeTwoLists(l, r)!)
    }
    
    // MARK: - 22. Generate Parenthesis
    
    func testProblem22() {
        
        func generateParenthesis(_ n: Int) -> [String] {
            
            func generate(openCount: Int, openLevel: Int, charCount: Int) -> [String] {
                
                if charCount == 0 {
                    return [""]
                }
                
                let canOpen = openCount < n
                let canClose = openLevel > 0
                
                var solutions = [String]()
                
                if canOpen {
                    let subsolutions = generate(openCount: openCount + 1, openLevel: openLevel + 1, charCount: charCount - 1)
                    for s in subsolutions {
                        solutions.append("(" + s)
                    }
                }
                
                if canClose {
                    let subsolutions = generate(openCount: openCount, openLevel: openLevel - 1, charCount: charCount - 1)
                    for s in subsolutions {
                        solutions.append(")" + s)
                    }
                }
                
                return solutions
            }
            
            return generate(openCount: 0, openLevel: 0, charCount: 2 * n)
        }
        
        print(generateParenthesis(4))
    }
    
    // MARK: - 24. Swap Nodes in Pairs

    func testProblem24() {
    
        func swapPairs(_ head: ListNode?) -> ListNode? {
            
            guard let n1 = head else {
                return nil
            }
            
            guard let n2 = head?.next else {
                return head
            }
            
            let n3 = n2.next
            n2.next = n1
            n1.next = swapPairs(n3)
            
            return n2
        }
        
        print(swapPairs(ListNode(values: 1, 2, 3, 4))!)
    }
    
    // MARK: - 26. Remove Duplicates from Sorted Array
    
    func testProblem26() {
        
        func removeDuplicates(_ nums: inout [Int]) -> Int {
            
            if nums.isEmpty {
                return 0
            }
            
            var count = 1
            var prev = nums[0]
            
            for i in 1 ..< nums.count {
                
                let val = nums[i]
                
                if val == prev {
                    continue
                }
                
                nums[count] = val
                count += 1
                prev = val
            }
            
            return count
        }
        
        var nums = [1, 1, 2, 2, 2, 3, 4, 5, 5, 6, 7, 7, 7, 7, 8, 9]
        
        let count = removeDuplicates(&nums)
        let subarray = nums[0 ..< count]
        
        print(subarray)
    }
    
    // MARK: - 27. Remove Element
    
    func testProblem27() {
        
        var count = 0
        
        func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
            
            for i in 0 ..< nums.count {
                
                let num = nums[i]
                
                if num == val {
                    continue
                }
                
                if i != count {
                    nums[count] = num
                }
                
                count += 1
            }
            
            return count
        }
    }
    
    // MARK: - 28. Implement strStr()
    
    func testProblem28() {
        
        func strStr(_ haystack: String, _ needle: String) -> Int {
            
            var hs = Array(haystack.characters)
            var ns = Array(needle.characters)
            
            if ns.isEmpty {
                return 0
            }
            
            if hs.isEmpty {
                return -1
            }
            
            var h = 0
            var n = 0
            
            while true {
                
                if h >= hs.count {
                    return -1
                }
                
                if hs[h] != ns[n] {
                    
                    h -= (n - 1)
                    n = 0
                    continue
                }
                
                n += 1
                
                if n == ns.count {
                    return h - n + 1
                }
                
                h += 1
            }
        }
        
        print(strStr("abcdefg", "def"))
        print(strStr("mississippi", "issip"))
        print(strStr("mississippi", "a"))
    }
    
    // MARK: - 29. Divide Two Integers
    
    func testProblem29() {
        
        func divide(_ dividend: Int, _ divisor: Int) -> Int {
            
            if dividend == 0 {
                return 0
            }
            
            if divisor == 0 {
                return Int(Int32.max)
            }
            
            if divisor == 1 {
                return dividend
            }
            
            let sign: Int64 = ((dividend >= 0) == (divisor >= 0)) ? 1 : -1
            
            let top = abs(Int64(dividend))
            let bottom = abs(Int64(divisor))
            
            if top < bottom {
                return 0
            }
            
            var bottomMultiples: [Int64: Int64] = [
                1: bottom
            ]
            
            var count: Int64 = 1
            var total: Int64 = bottom
            
            while top - total >= total {
                
                count = count + count
                total = total + total
                
                bottomMultiples[count] = total
            }
            
            assert(total <= top)
            
            for i in Array(bottomMultiples.keys).sorted(by: >) {
                
                let multiple = bottomMultiples[i]!
                
                while top - total >= multiple {
                    
                    count += i
                    total += multiple
                }
                
                assert(total <= top)
            }
            
            let solution = sign * count
            
            if solution < Int64(Int32.min) {
                return Int(Int32.min)
            }
            
            if solution > Int64(Int32.max) {
                return Int(Int32.max)
            }
            
            return Int(solution)
        }
        
        /*
        XCTAssert(0 / 1 == divide(0, 1))
        XCTAssert(0 / -1 == divide(0, -1))
        XCTAssert(1 / 1 == divide(1, 1))
        XCTAssert(1 / -1 == divide(1, -1))
        XCTAssert(-1 / -1 == divide(-1, -1))
        XCTAssert(-1 / 1 == divide(-1, 1))
        XCTAssert(1 / 2 == divide(1, 2))
        
        print(-2147483648 / -1)
        print(divide(-2147483648, -1))
        
        print(2147483647 / 2)
        print(divide(2147483647, 2))
        */
        
        print(-2147483648 / 2)
        print(divide(-2147483648, 2))
    }
    
    // MARK: - 35. Search Insert Position
    
    func testProblem35() {
        
        func searchInsert(_ nums: [Int], _ target: Int) -> Int {
            
            let len = nums.count
            
            var index = 0
            var left = 0
            var right = len - 1
            
            while left <= right {
                
                index = left + (right - left) / 2
                
                let val = nums[index]
                
                if val == target {
                    return index
                }
                
                if val < target {
                    left = index + 1
                } else {
                    right = index - 1
                }
            }
            
            return left
        }
        
        print(searchInsert([1], 2))
        print(searchInsert([1, 2, 4, 5], 3))
    }
    
    // MARK: - 38. Count and Say
    
    func testProblem38() {
        
        func countAndSay(_ n: Int) -> String {
            
            if n <= 1 {
                return "1"
            }
            
            let s = countAndSay(n - 1)
            assert(!s.isEmpty)
            
            var previous = s.characters.first!
            var count = 0
            
            var solution = ""
            
            func addPhrase() {
                solution += String(count) + String(previous)
            }
            
            for c in s.characters {
                
                if c != previous {
                    
                    addPhrase()
                    
                    previous = c
                    count = 1
                    
                } else {
                    
                    count += 1
                }
            }
            
            addPhrase()
            
            return solution
        }
        
        for i in 0 ..< 10 {
            print("countAndSay(\(i)) = \(countAndSay(i))")
        }
    }
    
    // MARK: - 42. Trapping Rain Water
    
    func testProblem42() {
        
        class Pool: NSCopying {
            
            var startIndex = 0
            var startBottom = 0
            var startTop = 0
            var underwaterPeak = 0
            var width = 0
            var volume = 0
            
            func copy(with zone: NSZone? = nil) -> Any {
                let newPool = Pool()
                newPool.startIndex = startIndex
                newPool.startBottom = startBottom
                newPool.startTop = startTop
                newPool.underwaterPeak = 0
                newPool.width = width
                newPool.volume = volume
                return newPool
            }
        }
        
        func trap(_ heights: [Int]) -> Int {
            
            var prevHeight = 0
            var potentialPools = [Int: Pool]()
            var actualPools = [Int: Pool]()
            
            for i in 0 ..< heights.count {
                
                let height = heights[i]
                
                // If this height is lower than the last, add a new potential pool.
                
                if height < prevHeight {
                    
                    let pool = Pool()
                    pool.startIndex = i
                    pool.startBottom = height
                    pool.startTop = prevHeight
                    potentialPools[i] = pool
                }
                    
                // Otherwise, if this height is higher than the last, turn potential pools into an actual pool.
                
                else if height > prevHeight {
                    
                    // Find the outermost potential pool.
                    
                    var outerPool: Pool?
                    
                    for pool in potentialPools.values {
                        
                        if pool.startBottom < height {
                            
                            // If the pool cannot continue, remove it from the potential array.
                            
                            if pool.startTop <= height {
                                potentialPools.removeValue(forKey: pool.startIndex)
                            
                            }
                            
                            // Select the highest, unbroken pool, if one exists.
                            
                            let unbroken = pool.underwaterPeak < height
                            
                            if unbroken {
                                if outerPool == nil || pool.startTop > outerPool!.startTop {
                                    outerPool = pool
                                }
                            }
                        }
                    }
                    
                    if let outerPool = outerPool {
                        
                        let newPool = outerPool.copy() as! Pool
                        
                        // Remove previous pools that are inside this new pool.
                        
                        for j in Array(actualPools.keys).sorted(by: <) {
                            if j > newPool.startIndex {
                                actualPools.removeValue(forKey: j)
                            }
                        }
                        
                        // Adjust the new pool's height and volume based on the right wall height.
                        
                        let heightDiff = newPool.startTop - height
                        
                        if heightDiff > 0 {
                            
                            newPool.startTop = height
                            newPool.volume -= heightDiff * newPool.width
                        }
                        
                        actualPools[i - newPool.width] = newPool
                    }
                }
                
                // Update the width, volume, and underwaterPeak of all potential pools.
                
                for pool in potentialPools.values {
                    
                    pool.width += 1
                    pool.volume += (pool.startTop - height)
                    
                    if pool.underwaterPeak < height {
                        pool.underwaterPeak = height
                    }
                }
                
                prevHeight = height
            }
            
            // Sum all the pool volumes.
            
            let solution = actualPools.reduce(0) { $0 + $1.value.volume }
            
            return solution
        }
        
        XCTAssert(trap([2, 0, 2]) == 2)
        XCTAssert(trap([4, 2, 3]) == 1)
        XCTAssert(trap([4, 2, 0, 3, 2, 5]) == 9)
        XCTAssert(trap([2, 6, 3, 8, 2, 7, 2, 5, 0]) == 11)
    }
    
    // MARK: - 46. Permutations
    
    func testProblem46() {
    
        func permute(_ nums: [Int]) -> [[Int]] {
            
            var solutions = [[Int]]()
            
            for i in 0 ..< nums.count {
                
                let num = nums[i]
                var subnums = nums
                subnums.remove(at: i)
                
                if subnums.isEmpty {
                    
                    return [[num]]
                    
                } else {
                    
                    var subsolutions = permute(subnums)
                    for i in 0 ..< subsolutions.count {
                        subsolutions[i].insert(num, at: 0)
                    }
                    
                    solutions += subsolutions
                }
            }
            
            return solutions
        }
        
        print(permute([1, 2, 3]))
    }
    
    // MARK: - 53. Maximum Subarray
    
    func testProblem53() {
        
        func maxSubArray(_ nums: [Int]) -> Int {
            
            if nums.count == 1 {
                return nums[0]
            }
            
            var total = 0
            var minSum = 0
            var minIndex = -1
            
            var largest = Int.min
            var l = 0
            var r = 0
            
            var sums = [Int](repeating: 0, count: nums.count)
            
            for i in 0 ..< nums.count {
                
                let num = nums[i]
                
                total += num
                
                sums[i] = total
                
                let diff = total - minSum
                
                if diff > largest {
                    largest = diff
                    l = minIndex
                    r = i
                }
                
                if total < minSum {
                    minSum = total
                    minIndex = i
                }
            }
            
            let firstSum = (l >= 0) ? sums[l] : 0
            let lastSum = sums[r]
            
            return lastSum - firstSum
        }
        
        XCTAssert(maxSubArray([1]) == 1)
        XCTAssert(maxSubArray([-1]) == -1)
        XCTAssert(maxSubArray([1, 2, 3, 4, 5]) == 15)
        XCTAssert(maxSubArray([-2, -1]) == -1)
        XCTAssert(maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6)
    }
    
    // MARK: - 58. Length of Last Word
    
    func testProblem58() {
        
        func lengthOfLastWord(_ s: String) -> Int {
            
            func isWhitespace(_ c: Character) -> Bool {
                let charset = CharacterSet.whitespacesAndNewlines
                return String(c).rangeOfCharacter(from: charset) != nil
            }
            
            let a = Array(s.characters)
            
            var hasWord = false
            var count = 0
            
            var i = a.count - 1
            
            while i >= 0 {
                
                let c = a[i]
                
                if !isWhitespace(c) {
                    
                    hasWord = true
                    count += 1
                    
                } else {
                    
                    if hasWord {
                        return count
                    }
                }
                
                i -= 1
            }
            
            return count
        }
        
        XCTAssert(lengthOfLastWord("") == 0)
        XCTAssert(lengthOfLastWord(" ") == 0)
    }
    
    // Mark: - 66. Plus One
    
    func testProblem66() {
        
        func plusOne(_ digits: [Int]) -> [Int] {
            
            var solution = digits
            
            var i = solution.count - 1
            
            while i >= 0 {
                
                if solution[i] < 9 {
                    solution[i] += 1
                    return solution
                }
                
                solution[i] = 0
                i -= 1
            }
            
            solution = [1] + solution
            return solution
        }
    }
    
    // MARK: - 67. Add Binary
    
    func testProblem67() {
        
        func addBinary(_ a: String, _ b: String) -> String {
            
            var x = Array(a.characters)
            var y = Array(b.characters)
            
            func bit(_ s: [Character], _ i: Int) -> Int {
                return (s[s.count - 1 - i] == "0") ? 0 : 1
            }
            
            var i = 0
            var carry = 0
            var solution = ""
            
            while true {
                
                if i >= x.count && i >= y.count {
                    break
                }
                
                var xd = 0
                var yd = 0
                
                if i < x.count {
                    xd = bit(x, i)
                }
                
                if i < y.count {
                    yd = bit(y, i)
                }
                
                let sum = xd + yd + carry
                
                switch sum {
                case 0:
                    solution = "0" + solution
                case 1:
                    solution = "1" + solution
                    carry = 0
                case 2:
                    solution = "0" + solution
                    carry = 1
                case 3:
                    solution = "1" + solution
                    carry = 1
                default:
                    break
                }
                
                i += 1
            }
            
            if carry > 0 {
                solution = "1" + solution
            }
            
            return solution
        }
    }
    
    // MARK: - 69. Sqrt(x)
    
    func testProblem69() {
        
        func slowMySqrt(_ x: Int) -> Int {
            
            if x == 0 {
                return 0
            }
            
            if x == 1 {
                return 1
            }
            
            for i in 1 ... x {
                
                let product = i * i
                
                if product == x {
                    return i
                }
                
                if product > x {
                    return i - 1
                }
            }
            
            return 0
        }
        
        func mySqrt(_ x: Int) -> Int {
            
            if x == 0 {
                return 0
            }
            
            if x == 1 {
                return 1
            }
            
            var i = x / 2 // A first guess
            
            var lo = 0
            var hi = x
            
            while true {
                
                let product = i * i
                
                if product == x {
                    return i
                }
                
                if product > x {
                    hi = i
                } else {
                    lo = i
                }
                
                let next = lo + (hi - lo) / 2
                
                if i == next {
                    return i
                }
                
                i = next
            }
        }
    }
    
    // MARK: - 70. Climbing Stairs
    
    func testProblem70() {
        
        var table = [0: 1, 1: 1]
        
        func climbStairs(_ n: Int) -> Int {
            
            if let solution = table[n] {
                return solution
            }
            
            let solutionCount1 = climbStairs(n - 1)
            let solutionCount2 = climbStairs(n - 2)
            
            let solution = solutionCount1 + solutionCount2
            
            table[n] = solution
            
            return solution
        }
        
        print(climbStairs(44))
    }
    
    // MARK: - 83. Remove Duplicates from Sorted List
    
    func testProblem83() {
        
        func deleteDuplicates(_ head: ListNode?) -> ListNode? {
            
            var node = head
            var prev: ListNode?
            var lead: ListNode?
            
            while node != nil {
                
                if lead != nil {
                    
                    if node!.val != lead!.val {
                        
                        lead!.next = node
                        lead = nil
                    }
                    
                } else if node!.val == prev?.val {
                    
                    lead = prev
                }
                
                prev = node
                node = node!.next
            }
            
            if lead != nil {
                lead!.next = nil
            }
            
            return head
        }
    }
    
    // MARK: - 88. Merge Sorted Array
    
    func testProblem88() {
        
        func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
            
            var count = m
            
            var i = 0
            var j = 0
            
            while j < n {
                
                // If the first array has been exhausted, append all the remaining values from the second array.
                
                if i >= count {
                    while j < n {
                        nums1[i] = nums2[j]
                        i += 1
                        j += 1
                        count += 1
                    }
                    return
                }
                
                // Compare the values.
                
                let val1 = nums1[i]
                let val2 = nums2[j]
                
                if val1 <= val2 {
                    
                    i += 1
                    
                } else {
                    
                    // Shift up
                    
                    for n in (i ..< count).reversed() {
                        nums1[n + 1] = nums1[n]
                    }
                    
                    // Write
                    
                    nums1[i] = val2
                    count += 1
                    i += 1
                    j += 1
                }
            }
        }
        
        var a = [0]
        merge(&a, 0, [1], 1)
        XCTAssert(a == [1])
        
        var b = [2, 0]
        merge(&b, 1, [1], 1)
        XCTAssert(b == [1, 2])
        
        var c = [1, 2, 3, 0, 0, 0]
        merge(&c, 3, [2, 5, 6], 3)
        XCTAssert(c == [1, 2, 2, 3, 5, 6])
        
        var d = [4, 5, 6, 0, 0, 0]
        merge(&d, 3, [1, 2, 3], 3)
        XCTAssert(d == [1, 2, 3, 4, 5, 6])
    }
    
    // MARK: - 101. Symmetric Tree
    
    func testProblem101() {
        
        func isSymmetric(_ root: TreeNode?) -> Bool {
            return isSymmetricIterative(root)
        }
        
        func isSymmetricRecursive(_ root: TreeNode?) -> Bool {
            
            func recurse(_ l: TreeNode?, _ r: TreeNode?) -> Bool {
                
                if l == nil && r == nil {
                    return true
                }
                
                if l?.val != r?.val {
                    return false
                }
                
                let outer = recurse(l?.left, r?.right)
                let inner = recurse(l?.right, r?.left)
                
                return outer && inner
            }
            
            return recurse(root?.left, root?.right)
        }
        
        func isSymmetricIterative(_ root: TreeNode?) -> Bool {
            
            var nodes = [root]
            
            while !nodes.isEmpty {
                
                for i in 0 ..< nodes.count / 2 {
                    
                    let j = nodes.count - i - 1
                    
                    if nodes[i]?.val != nodes[j]?.val {
                        return false
                    }
                }
                
                var newNodes = [TreeNode?]()
                var hasObjects = false
                
                for n in nodes {
                    
                    if n?.left != nil || n?.right != nil {
                        hasObjects = true
                    }
                    
                    newNodes += [n?.left, n?.right]
                }
                
                if !hasObjects {
                    break
                }
                
                nodes = newNodes
            }
            
            return true
        }
        
        XCTAssert(isSymmetric(TreeNode(values: 1,2,2,nil,3,nil,3)) == false)
        XCTAssert(isSymmetric(TreeNode(values: 1,2,2,3,4,4,3)) == true)
        
        self.measure {
            XCTAssert(isSymmetric(TreeNode(values: 6,82,82,nil,53,53,nil,-58,nil,nil,-58,nil,-85,-85,nil,-9,nil,nil,-9,nil,48,48,nil,33,nil,nil,33,81,nil,nil,81,5,nil,nil,5,61,nil,nil,61,nil,9,9,nil,91,nil,nil,91,72,7,7,72,89,nil,94,nil,nil,94,nil,89,-27,nil,-30,36,36,-30,nil,-27,50,36,nil,-80,34,nil,nil,34,-80,nil,36,50,18,nil,nil,91,77,nil,nil,95,95,nil,nil,77,91,nil,nil,18,-19,65,nil,94,nil,-53,nil,-29,-29,nil,-53,nil,94,nil,65,-19,-62,-15,-35,nil,nil,-19,43,nil,-21,nil,nil,-21,nil,43,-19,nil,nil,-35,-15,-62,86,nil,nil,-70,nil,19,nil,55,-79,nil,nil,-96,-96,nil,nil,-79,55,nil,19,nil,-70,nil,nil,86,49,nil,25,nil,-19,nil,nil,8,30,nil,82,-47,-47,82,nil,30,8,nil,nil,-19,nil,25,nil,49)) == false)
        }
    }
    
    // MARK: - 104. Maximum Depth of Binary Tree
    
    func testProblem104() {
        
        func maxDepth(_ root: TreeNode?) -> Int {
            
            if root == nil {
                return 0
            }
            
            return 1 + max(maxDepth(root!.left), maxDepth(root!.right))
        }
    }
    
    // MARK: - 107. Binary Tree Level Order Traversal II
    
    func testProblem107() {
        
        func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
            
            var solution = [[Int]]()
            
            if root == nil {
                return solution
            }
            
            var nodes = [root]
            
            while !nodes.isEmpty {
                
                var values = [Int]()
                
                for n in nodes {
                    values += [n!.val]
                }
                
                solution.insert(values, at: 0)
                
                var newNodes = [TreeNode]()
                
                for n in nodes {
                    
                    if let l = n?.left {
                        newNodes += [l]
                    }
                    
                    if let r = n?.right {
                        newNodes += [r]
                    }
                }
                
                nodes = newNodes
            }
            
            return solution
        }
    }
    
    // MARK: - 108. Convert Sorted Array to Binary Search Tree
    
    func testProblem108() {
        
        func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
            
            func helper(_ n: inout TreeNode?, _ begin: Int, _ end: Int) {
                
                if begin >= end {
                    return
                }
                
                let midIndex = begin + (end - begin) / 2
                let val = nums[midIndex]
                
                assert(n == nil)
                n = TreeNode(val)
                
                helper(&n!.left, begin, midIndex)
                helper(&n!.right, midIndex + 1, end)
            }
            
            if nums.isEmpty {
                return nil
            }
            
            var head: TreeNode?
            
            helper(&head, 0, nums.count)
            
            return head
        }
        
        sortedArrayToBST([3, 5, 8])
    }
    
    // MARK: - 110. Balanced Binary Tree
    
    func testProblem110() {
        
        func isBalanced(_ root: TreeNode?) -> Bool {
            
            if root == nil {
                return true
            }
            
            func balancedHeights(_ node: TreeNode?, _ leftHeight: inout Int, _ rightHeight: inout Int) -> Bool {
                
                if node == nil {
                    leftHeight = 0
                    rightHeight = 0
                    return true
                }
                
                var llh = 0
                var lrh = 0
                var rlh = 0
                var rrh = 0
                
                let leftBalanced = balancedHeights(node!.left, &llh, &lrh)
                let rightBalanced = balancedHeights(node!.right, &rlh, &rrh)
                
                leftHeight = 1 + max(llh, lrh)
                rightHeight = 1 + max(rlh, rrh)
                
                let balanced = abs(leftHeight - rightHeight) <= 1
                
                return balanced && leftBalanced && rightBalanced
            }
            
            var lh = 0
            var rh = 0
            return balancedHeights(root, &lh, &rh)
        }
    }
    
    // MARK: - 371. Sum of Two Integers
    
    func testProblem371() {
        
        func getSum(_ a: Int, _ b: Int) -> Int {
            
            if a == 0 { return b }
            if b == 0 { return a }
            
            let and = a & b
            let xor = a ^ b
            let car = and << 1
            
            return getSum(car, xor)
        }
    }
    
    // MARK:
}
