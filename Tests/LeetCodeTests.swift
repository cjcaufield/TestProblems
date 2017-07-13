//
//  LeetCodeTests.swift
//  Tests
//
//  Created by Colin Caufield on 2017-05-16.
//  Copyright © 2017 Secret Geometry, Inc. All rights reserved.
//

import XCTest

class LeetCodeTests: XCTestCase {
    
    // MARK: - 1. Two Sum ✓
    
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
    
    // MARK: - 2. Add Two Numbers ✓
    
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
    
    // MARK: - 3. Longest Substring Without Repeating Characters ✓
    
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
    
    // MARK: - 5. Longest Palindromic Substring ✓
    
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
            
            return sign * NSDecimalNumber(decimal: solution).intValue
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
    
    // MARK: - 11. Container With Most Water ✓
    
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
        
        let _  = sortedArrayToBST([3, 5, 8])
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
    
    // MARK: - 111. Minimum Depth of Binary Tree
    
    func testProblem111() {
        
        func minDepth(_ root: TreeNode?) -> Int {
            
            if root == nil {
                return 0
            }
            
            let leftDepth = minDepth(root!.left)
            let rightDepth = minDepth(root!.right)
            
            if leftDepth == 0 || rightDepth == 0 {
                return 1 + max(leftDepth, rightDepth)
            }
            
            return 1 + min(leftDepth, rightDepth)
        }
    }
    
    // MARK: - 112. Path Sum
    
    func testProblem112() {
        
        func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
            
            guard let root = root else {
                return false
            }
            
            if root.val == sum && root.left == nil && root.right == nil {
                return true
            }
            
            let remaining = sum - root.val
            
            for node in [root.left, root.right] {
                if hasPathSum(node, remaining) {
                    return true
                }
            }
            
            return false
        }
    }
    
    // MARK: - 113. Path Sum II
    
    func testProblem113() {
        
        func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
            
            guard let root = root else {
                return []
            }
            
            if root.left == nil && root.right == nil {
                
                if root.val == sum {
                    return [[root.val]]
                }
                
                return []
            }
            
            let remaining = sum - root.val
            
            var solutions = [[Int]]()
            
            for node in [root.left, root.right] {
                
                var paths = pathSum(node, remaining)
                
                if !paths.isEmpty {
                    
                    for i in 0 ..< paths.count {
                        paths[i].insert(root.val, at: 0)
                    }
                    
                    solutions += paths
                }
            }
            
            // Test
            
            //for s in solutions {
            //    assert(s.reduce(0, +) == sum)
            //}
            
            return solutions
        }
        
        print(pathSum(TreeNode(values:1,2), 0))
        print(pathSum(TreeNode(values:1,2,2), 3))
        print(pathSum(TreeNode(values:1,2,2,3,3,3,3), 6))
        print(pathSum(TreeNode(values:5,4,8,11,nil,13,4,7,2,nil,nil,5,1), 22))
    }
    
    // MARK: - 118. Pascal's Triangle
    
    func testProblem118() {
        
        func generate(_ numRows: Int) -> [[Int]] {
            
            if numRows == 0 {
                return []
            }
            
            var solution = [[1]]
            
            for n in 1 ..< numRows {
                
                solution.append([])
                
                for k in 0 ..< n + 1 {
                    
                    var aboveLeft = 0
                    var aboveRight = 0
                    
                    if k > 0 {
                        aboveLeft = solution[n - 1][k - 1]
                    }
                    
                    if k < n {
                        aboveRight = solution[n - 1][k]
                    }
                    
                    solution[n].append(aboveLeft + aboveRight)
                }
            }
            
            return solution
        }
        
        print(generate(0))
    }
    
    // MARK: - 119. Pascal's Triangle II
    
    func testProblem119() {
        
        func getRow(_ rowIndex: Int) -> [Int] {
            
            var previous = [1]
            var solution = [Int]()
            
            if rowIndex == 0 {
                return previous
            }
            
            for n in 1 ... rowIndex {
                
                for k in 0 ... n {
                    
                    var aboveLeft = 0
                    var aboveRight = 0
                    
                    if k > 0 {
                        aboveLeft = previous[k - 1]
                    }
                    
                    if k < n {
                        aboveRight = previous[k]
                    }
                    
                    solution.append(aboveLeft + aboveRight)
                }
                
                if n == rowIndex {
                    return solution
                }
                
                previous = solution
                solution = []
            }
            
            return previous
        }
        
        print(getRow(5))
    }
    
    // MARK: - 121. Best Time to Buy and Sell Stock
    
    func testProblem121() {
        
        func maxProfit(_ prices: [Int]) -> Int {
            
            if prices.isEmpty {
                return 0
            }
            
            var minPrice = prices[0]
            var maxProfit = 0
            
            for price in prices {
                
                let profit = price - minPrice
                
                maxProfit = max(profit, maxProfit)
                
                minPrice = min(price, minPrice)
            }
            
            return maxProfit
        }
    }
    
    // MARK: - 122. Best Time to Buy and Sell Stock II
    
    func testProblem122() {
        
        func maxProfit(_ prices: [Int]) -> Int {
            
            if prices.isEmpty {
                return 0
            }
            
            var profit = 0
            
            var prev = prices[0]
            
            for price in prices {
                
                let diff = price - prev
                
                if diff > 0 {
                    profit += diff
                }
                
                prev = price
            }
            
            return profit
        }
    }
    
    // MARK: - 125. Valid Palindrome
    
    func testProblem125() {
        
        func isPalindrome(_ s: String) -> Bool {
            
            let a = Array(s.characters)
            
            func charAt(_ i: Int) -> Character {
                return a[a.index(a.startIndex, offsetBy: i)]
            }
            
            func isAlphaNum(_ c: Character) -> Bool {
                return String(c).rangeOfCharacter(from: CharacterSet.alphanumerics) != nil
            }
            
            let len = s.characters.count
            
            if len <= 1 {
                return true
            }
            
            var i1 = 0
            var i2 = len - 1
            
            while i1 < i2 {
                
                var c1 = charAt(i1)
                
                while !isAlphaNum(c1) {
                    i1 += 1
                    if i1 >= i2 { return true }
                    c1 = charAt(i1)
                }
                
                var c2 = charAt(i2)
                
                while !isAlphaNum(c2) {
                    i2 -= 1
                    if i1 >= i2 { return true }
                    c2 = charAt(i2)
                }
                
                if String(c1).uppercased() != String(c2).uppercased() {
                    return false
                }
                
                i1 += 1
                i2 -= 1
            }
            
            return true
        }
        
        XCTAssert(isPalindrome("a.") == true)
    }
    
    // MARK: - 136. Single Number
    
    func testProblem136() {
        
        func singleNumber(_ nums: [Int]) -> Int {
            
            var s: Set<Int> = []
            
            for n in nums {
                
                if s.contains(n) {
                    s.remove(n)
                } else {
                    s.insert(n)
                }
            }
            
            return s.first!
        }
    }
    
    // MARK: 167. Two Sum II - Input array is sorted
    
    func testProblem167() {
        
        func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
            
            var s = [Int: Int]()
            
            for (i2, n) in numbers.enumerated() {
                
                let other = target - n
                
                if let i1 = s[other] {
                    return [i1 + 1, i2 + 1]
                }
                
                s[n] = i2
            }
            
            return []
        }
    }
    
    // MARK: - 168. Excel Sheet Column Title
    
    func testProblem168() {
        
        func convertToTitle(_ n: Int) -> String {
            
            func IntToAlpha(_ i: Int) -> Character {
                
                assert(i >= 0)
                assert(i <= 25)
                
                let offset = Int(("A" as UnicodeScalar).value) + i
                return Character(UnicodeScalar(offset)!)
            }
            
            var str = ""
            
            var remaining = n
            
            while remaining > 0 {
                
                let d = (remaining - 1) % 26
                
                let c = IntToAlpha(d)
                
                str = String(c) + str
                
                remaining = (remaining - 1) / 26
            }
            
            return str
        }
        
        for i in 0 ..< 1000 {
            print("\(i) - \(convertToTitle(i))")
        }
    }
    
    // MARK: - 169. Majority Element
    
    func testProblem169() {
        
        func majorityElement(_ nums: [Int]) -> Int {
            
            var table = [Int: Int]()
            var maxCount = 0
            var maxElement = 0
            
            for n in nums {
                
                if table[n] == nil {
                    table[n] = 1
                } else {
                    table[n]! += 1
                }
                
                let count = table[n]!
                
                if count > maxCount {
                    maxCount = count
                    maxElement = n
                }
            }
            
            return maxElement
        }
    }
    
    // MARK: - 171. Excel Sheet Column Number
    
    func testProblem171() {
        
        func titleToNumber(_ s: String) -> Int {
            
            func charToInt(_ c: Character) -> Int {
                
                let a = Int(UnicodeScalar("A").value)
                return Int(UnicodeScalar(String(c))!.value) - a + 1
            }
            
            let a = Array(s.characters)
            
            var value = 0
            
            for c in a {
                
                value *= 26
                value += charToInt(c)
            }
            
            return value
        }
    }
    
    // MARK: - 172. Factorial Trailing Zeroes
    
    func testProblem172() {
        
        func trailingZeroes(_ n: Int) -> Int {
            
            var count5 = 0
            
            var x = 5
            
            while x <= n {
                
                count5 += n / x
                
                x *= 5
            }
            
            return count5
        }
        
        XCTAssert(trailingZeroes(4) == 0)
        XCTAssert(trailingZeroes(5) == 1)
        XCTAssert(trailingZeroes(9) == 1)
        XCTAssert(trailingZeroes(10) == 2)
        XCTAssert(trailingZeroes(1808548329) == 452137076)
    }
    
    // MARK: - 189. Rotate Array
    
    func testProblem189() {
        
        func rotate(_ nums: inout [Int], _ k: Int) {
            
            let len = nums.count
            
            let r = k % len
            
            if r == 0 {
                return
            }
            
            var i = 0
            var start = 0
            var count = 0
            
            var temp = nums[0]
            
            while count < len {
                
                let ii = (i + k) % len
                
                let newTemp = nums[ii]
                
                nums[ii] = temp
                
                temp = newTemp
                
                count += 1
                
                if ii == start {
                    start += 1
                    i = start
                    temp = nums[i]
                } else {
                    i = ii
                }
            }
        }
        
        var a = [1, 2]
        rotate(&a, 1)
        XCTAssert(a == [2, 1])
    }
    
    // MARK: - 198. House Robber
    
    func testProblem198() {
        
        func rob(_ nums: [Int]) -> Int {
            
            var robbedPrevious = 0
            var didntRobPrevious = 0
            
            for money in nums {
                
                // Option A: Don't Rob
                
                let a = max(robbedPrevious, didntRobPrevious)
                
                // Option B: Rob
                
                let b = money + didntRobPrevious
                
                // Update for the next iteration.
                
                robbedPrevious = b
                didntRobPrevious = a
            }
            
            return max(robbedPrevious, didntRobPrevious)
        }
        
        func slowRob(_ nums: [Int]) -> Int {
            
            var cache = [Int: Int]()
            
            func profit(from begin: Int) -> Int {
                
                // Bottom case: past the last house.
                
                if begin >= nums.count {
                    return 0
                }
                
                // Bottom case: last house.
                
                if begin == nums.count - 1 {
                    return nums[begin]
                }
                
                // Return a cached value if possible.
                
                if let cached = cache[begin] {
                    return cached
                }
                
                // Option A: Don't rob the current house.  Step forward 1.
                
                let profit1 = profit(from: begin + 1)
                
                // Option B: Rob the current house.  Step forward 2.
                
                let money = nums[begin]
                
                let profit2 = money + profit(from: begin + 2)
                
                // Calculate, cache, and return the best of the two options.
                
                let best = max(profit1, profit2)
                
                cache[begin] = best
                
                return best
            }
            
            return profit(from: 0)
        }
        
        self.measure {
            XCTAssert(rob([183,219,57,193,94,233,202,154,65,240,97,234,100,249,186,66,90,238,168,128,177,235,50,81,185,165,217,207,88,80,112,78,135,62,228,247,211]) == 3365)
        }
    }
    
    // MARK: - 202. Happy Number
    
    func testProblem202() {
        
        let MAX_ATTEMPTS = 1000
        
        func isHappy(_ n: Int) -> Bool {
            
            var value = n
            
            var attempts = 0
            
            while true {
                
                var newValue = 0
                
                while value > 0 {
                    
                    let digit = value % 10
                    
                    newValue += digit * digit
                    
                    value /= 10
                }
                
                value = newValue
                
                if newValue == 1 {
                    return true
                }
                
                attempts += 1
                
                if attempts >= MAX_ATTEMPTS {
                    return false
                }
            }
        }
    }
    
    // MARK: - 203. Remove Linked List Elements
    
    func testProblem203() {
        
        func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
            
            if head == nil {
                return nil
            }
            
            var prev: ListNode?
            var node = head
            var newHead = head
            
            while node != nil {
                
                let next = node!.next
                
                if node!.val == val {
                    
                    if prev == nil {
                        newHead = next
                    } else {
                        prev!.next = next
                    }
                    
                } else {
                    
                    prev = node
                }
                
                node = next
            }
            
            return newHead
        }
    }
    
    // MARK: - 204. Count Primes
    
    func testProblem204() {
        
        func countPrimes(_ n: Int) -> Int {
            
            var primes = [2]
            
            if n <= 2 {
                return 0
            }
            
            var i = 3
            
            while i < n {
                
                var composite = false
                
                for p in primes {
                    
                    if i % p == 0 {
                        composite = true
                        break
                    }
                    
                    if p * p > i {
                        break
                    }
                }
                
                if !composite {
                    primes.append(i)
                }
                
                i += 2
            }
            
            return primes.count
        }
        
        self.measure {
            XCTAssert(countPrimes(499979) == 41537)
        }
    }
    
    // MARK: - 205. Isomorphic Strings
    
    func testProblem205() {
        
        func isIsomorphic(_ s: String, _ t: String) -> Bool {
            
            let a1 = Array(s.characters)
            let a2 = Array(t.characters)
            
            if a1.count != a2.count {
                return false
            }
            
            var map = [Character: Character]()
            var rmap = [Character: Character]()
            
            for i in 0 ..< a1.count {
                
                let c1 = a1[i]
                let c2 = a2[i]
                
                if let match = map[c1] {
                    if c2 != match {
                        return false
                    }
                } else {
                    if rmap[c2] != nil {
                        return false
                    }
                }
                
                map[c1] = c2
                rmap[c2] = c1
            }
            
            return true
        }
        
        XCTAssert(isIsomorphic("ab", "aa") == false)
    }
    
    // MARK: - 206. Reverse Linked List
    
    func testProblem206() {
        
        func reverseList(_ head: ListNode?) -> ListNode? {
            
            if head == nil {
                return nil
            }
            
            var prev: ListNode?
            var node = head
            
            while node != nil {
                
                let next = node!.next
                
                node!.next = prev
                
                prev = node
                node = next
            }
            
            return prev
        }
    }
    
    // MARK: - 217. Contains Duplicate
    
    func testProblem217() {
        
        func containsDuplicate(_ nums: [Int]) -> Bool {
            
            var s = Set<Int>()
            
            for n in nums {
                
                if s.contains(n) {
                    return true
                }
                
                s.insert(n)
            }
            
            return false
        }
    }
    
    // MARK: - 219. Contains Duplicate II
    
    func testProblem219() {
        
        func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
            
            var indexMap = [Int: Int]()
            
            for (index, num) in nums.enumerated() {
                
                if let otherIndex = indexMap[num] {
                    if index - otherIndex <= k {
                        return true
                    }
                }
                
                indexMap[num] = index
            }
            
            return false
        }
    }
    
    // MARK: - 226. Invert Binary Tree
    
    func testProblem226() {
        
        func invertTree(_ root: TreeNode?) -> TreeNode? {
            
            guard let root = root else {
                return nil
            }
            
            _ = invertTree(root.left)
            _ = invertTree(root.right)
            
            swap(&root.left, &root.right)
            
            return root
        }
    }
    
    // MARK: - 231. Power of Two
    
    func testProblem231() {
        
        func isPowerOfTwo(_ n: Int) -> Bool {
            
            if n <= 0 {
                return false
            }
            
            if n == 1 {
                return true
            }
            
            var x = n
            
            while x > 2 {
                
                if x % 2 != 0 {
                    return false
                }
                
                x /= 2
            }
            
            return true
        }
    }
    
    // MARK: - 234. Palindrome Linked List
    
    func testProblem234() {
        
        func isPalindrome(_ head: ListNode?) -> Bool {
            
            if head == nil {
                return true
            }
            
            var count = 0
            var node = head
            
            while node != nil {
                count += 1
                node = node?.next
            }
            
            if count == 1 {
                return true
            }
            
            var stack = [Int]()
            var index = 0
            node = head
            
            while node != nil {
                
                if index == count / 2 && count % 2 != 0 {
                    
                    // nothing for the middle node
                    
                } else if index < count / 2 {
                    
                    stack.append(node!.val)
                    
                } else if index >= count / 2 {
                    
                    let otherValue = stack.removeLast()
                    if node!.val != otherValue {
                        return false
                    }
                }
                
                node = node!.next
                index += 1
            }
            
            return true
        }
    }
    
    // MARK: - 242. Valid Anagram
    
    func testProblem242() {
        
        func isAnagram(_ s: String, _ t: String) -> Bool {
            
            let a = Array(s.characters)
            let b = Array(t.characters)
            
            if a.count != b.count {
                return false
            }
            
            var table = [Character: Int]()
            
            for c in a {
                
                if table[c] != nil {
                    table[c]! += 1
                } else {
                    table[c] = 1
                }
            }
            
            for c in b {
                
                if table[c] == nil {
                    return false
                }
                
                if table[c]! == 1 {
                    table[c] = nil
                } else {
                    table[c]! -= 1
                }
            }
            
            return table.isEmpty
        }
    }
    
    // MARK: - 257. Binary Tree Paths
    
    func testProblem257() {
        
        func binaryTreePaths(_ root: TreeNode?) -> [String] {
            
            guard let root = root else {
                return []
            }
            
            if root.left == nil && root.right == nil {
                return ["\(root.val)"]
            }
            
            let leftPaths = binaryTreePaths(root.left)
            let rightPaths = binaryTreePaths(root.right)
            
            var paths = leftPaths + rightPaths
            
            for i in 0 ..< paths.count {
                paths[i] = "\(root.val)->" + paths[i]
            }
            
            return paths
        }
    }
    
    // MARK: - 258. Add Digits
    
    func testProblem258() {
        
        func addDigits(_ num: Int) -> Int {
            
            var value = num
            
            while value > 9 {
                
                var temp = value
                var digits = [Int]()
                
                while temp > 0 {
                    let d = temp % 10
                    digits.append(d)
                    temp /= 10
                }
                
                value = digits.reduce(0, +)
            }
            
            return value
        }
    }
    
    // MARK: - 260. Single Number III
    
    func testProblem260() {
        
        func singleNumber(_ nums: [Int]) -> [Int] {
            
            var singles = Set<Int>()
            
            for n in nums {
                
                if singles.contains(n) {
                    singles.remove(n)
                } else {
                    singles.insert(n)
                }
            }
            
            assert(singles.count == 2)
            
            return Array(singles)
        }
    }
    
    // MARK: - 263. Ugly Number
    
    func testProblem263() {
        
        func isUgly(_ num: Int) -> Bool {
            
            if num == 0 {
                return false
            }
            
            if num == 1 {
                return true
            }
            
            var solution = num
            
            for factor in [2, 3, 5] {
                
                while solution > 1 {
                    
                    if solution % factor == 0 {
                        solution /= factor
                    } else {
                        break
                    }
                }
            }
            
            return solution == 1
        }
    }
    
    // MARK: - 268. Missing Number
    
    func testProblem268() {
        
        func missingNumber(_ nums: [Int]) -> Int {
            
            var s = Set<Int>()
            
            let len = nums.count
            
            if len % 2 == 0 {
                s.insert(len / 2)
            }
            
            for num in nums {
                
                let other = len - num
                
                if s.contains(other) {
                    s.remove(other)
                } else {
                    s.insert(num)
                }
            }
            
            assert(s.count == 1)
            
            return len - s.first!
        }
    }
    
    // MARK: - 290. Word Pattern
    
    func testProblem290() {
        
        func wordPattern(_ pattern: String, _ str: String) -> Bool {
            
            let words = str.components(separatedBy: " ")
            
            if pattern.characters.count != words.count {
                return false
            }
            
            var wordMap = [String: Character]()
            var charMap = [Character: String]()
            
            for (index, char) in pattern.characters.enumerated() {
                
                let word = words[index]
                
                if let lookupChar = wordMap[word] {
                    if lookupChar != char {
                        return false
                    }
                } else {
                    wordMap[word] = char
                }
                
                if let lookupWord = charMap[char] {
                    if lookupWord != word {
                        return false
                    }
                } else {
                    charMap[char] = word
                }
            }
            
            return true
        }
    }
    
    // MARK: - 292. Nim Game
    
    func testProblem292() {
        
        // Very Fast Method
        
        func canWinNim(_ n: Int) -> Bool {
            
            return n % 4 != 0
        }
        
        // Slow Method
        
        var cache = [Int: Bool]()
        
        func canWinNimSlow(_ n: Int) -> Bool {
            
            if let canWin = cache[n] {
                return canWin
            }
            
            if n <= 0 {
                return false
            }
            
            if n <= 3 {
                return true
            }
            
            let canWin1 = !canWinNim(n - 1)
            let canWin2 = !canWinNim(n - 2)
            let canWin3 = !canWinNim(n - 3)
            
            let canWin = canWin1 || canWin2 || canWin3
            
            cache[n] = canWin
            
            return canWin
        }
        
        XCTAssert(canWinNim(5) == true)
        XCTAssert(canWinNim(8) == false)
        XCTAssert(canWinNim(33) == true)
        XCTAssert(canWinNim(1348820612) == false)
    }
    
    // MARK: - 326. Power of Three
    
    func testProblem326() {
        
        func isPowerOfThree(_ n: Int) -> Bool {
            
            if n == 0 {
                return false
            }
            
            var value = n
            
            while value > 1 {
                
                if value % 3 != 0 {
                    return false
                }
                
                value /= 3
            }
            
            return value == 1
        }
        
        XCTAssert(isPowerOfThree(9) == true)
        XCTAssert(isPowerOfThree(27) == true)
        XCTAssert(isPowerOfThree(43046721) == true)
    }
    
    // MARK: - 338. Counting Bits
    
    func testProblem338() {
        
        func bitCount(_ n: Int) -> Int {
            
            var count = 0
            
            let totalBits = MemoryLayout<Int>.size * 8
            
            for i in 0 ..< totalBits {
                
                let bit = n & (0x1 << i)
                
                if bit != 0 {
                    count += 1
                }
            }
            
            return count
        }
        
        func countBits(_ num: Int) -> [Int] {
            
            var solution = [Int]()
            
            for value in 0 ... num {
                
                let count = bitCount(value)
                
                solution.append(count)
            }
            
            return solution
        }
    }
    
    // MARK: - 342. Power of Four
    
    func testProblem342() {
        
        func isPowerOfFour(_ num: Int) -> Bool {
            
            if num < 1 {
                return false
            }
            
            if num == 1 {
                return true
            }
            
            var value = num
            
            while value % 4 == 0 {
                value /= 4
            }
            
            return value == 1
        }
    }
    
    // MARK: - 344. Reverse String
    
    func testProblem344() {
        
        func reverseString(_ s: String) -> String {
            
            let array = Array(s.characters)
            let len = array.count
            
            if len <= 1 {
                return s
            }
            
            var reversed = ""
            
            for i in 0 ..< len {
                
                let c = array[len - 1 - i]
                
                reversed += String(c)
            }
            
            return reversed
        }
    }
    
    // MARK: - 345. Reverse Vowels of a String
    
    func testProblem345() {
        
        let vowels = Set(Array("aeiouAEIOU".characters))
        
        func reverseVowels(_ s: String) -> String {
            
            func isVowel(_ c: Character) -> Bool {
                return vowels.contains(c)
            }
            
            var solution = Array(s.characters)
            
            var left = 0
            var right = solution.count - 1
            
            outer: while left < right {
                
                while !isVowel(solution[left]) {
                    if left + 1 < right {
                        left += 1
                    } else {
                        break outer
                    }
                }
                
                while !isVowel(solution[right]) {
                    if left < right - 1 {
                        right -= 1
                    } else {
                        break outer
                    }
                }
                
                let temp = solution[left]
                solution[left] = solution[right]
                solution[right] = temp
                
                left += 1
                right -= 1
            }
            
            return String(solution)
        }
    }
    
    // MARK: - 349. Intersection of Two Arrays
    
    func testProblem349() {
        
        func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            
            let set1 = Set(nums1)
            let set2 = Set(nums2)
            
            let common = set1.intersection(set2)
            
            return Array(common)
        }
    }
    
    // MARK: - 350. Intersection of Two Arrays II
    
    func testProblem350() {
        
        func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            
            var counts1 = [Int: Int]()
            var counts2 = [Int: Int]()
            
            for n in nums1 {
                
                if counts1[n] == nil {
                    counts1[n] = 0
                }
                
                counts1[n]! += 1
            }
            
            for n in nums2 {
                
                if counts2[n] == nil {
                    counts2[n] = 0
                }
                
                counts2[n]! += 1
            }
            
            var solution = [Int]()
            
            for (k, count1) in counts1 {
                
                guard let count2 = counts2[k] else {
                    continue
                }
                
                
                let minCount = min(count1, count2)
                
                for _ in 0 ..< minCount {
                    solution.append(k)
                }
            }
            
            return solution
        }
    }
    
    // MARK: - 367. Valid Perfect Square
    
    func testProblem367() {
        
        func isPerfectSquare(_ num: Int) -> Bool {
            
            if num < 1 {
                return false
            }
            
            if num == 1 {
                return true
            }
            
            var lo = 2
            var hi = num / 2
            
            while lo <= hi {
                
                let guess = lo + (hi - lo) / 2
                
                let other = num / guess
                let rem = num % guess
                
                if other == guess && rem == 0 {
                    return true
                }
                
                if other < guess {
                    hi = guess - 1
                } else {
                    lo = guess + 1
                }
            }
            
            return false
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
    
    // MARK: - 387. First Unique Character in a String
    
    func testProblem387() {
        
        func firstUniqChar(_ s: String) -> Int {
            
            let cs = Array(s.characters)
            
            struct Info {
                var count = 0
                var first = -1
            }
            
            var info = [Character: Info]()
            
            for (i, c) in cs.enumerated() {
                
                if info[c] == nil {
                    info[c] = Info(count: 0, first: i)
                }
                
                info[c]!.count += 1
            }
            
            for c in cs {
                
                if info[c]!.count == 1 {
                    return info[c]!.first
                }
            }
            
            return -1
        }
    }
    
    // MARK: - 400. Nth Digit
    
    func testProblem400() {
        
        func findNthDigit(_ n: Int) -> Int {
            
            //  k       numbers         number_count    indices         index_count
            //
            //  0       ()              0               ()              0
            //  1       1 ... 9         9               1 ... 9         9
            //  2       10 ... 99       90              10 ... 189      180
            //  3       100 ... 999     900             190 ... 2889    2700
            //  4       1000 ... 9999   9000            2900 ... 38899  36000
            //
            //  k            = 1 ...
            //  numbers      = 10^(k-1) ... 10^k - 1
            //  number_count = 9 * 10^(k-1)
            //  indices      = index_total ... index_total + index_count
            //  index_count  = k * number_count
            
            var index = 1
            var width = 1
            var firstNumber = 1
            
            while true {
            
                let numberCount = 9 * firstNumber
                let indexCount = width * numberCount
                
                if index <= n && n < index + indexCount {
                    break
                }
                
                index += indexCount
                width += 1
                firstNumber *= 10
            }
            
            let indexOffset = n - index
            let digitOffset = indexOffset % width
            let numberOffset = indexOffset / width
            
            let number = firstNumber + numberOffset
            
            return digit(in: number, at: width - digitOffset - 1)
        }
        
        func intPow(_ n: Int, _ e: Int) -> Int {
            return Array(repeating: n, count: e).reduce(1, *)
        }
        
        func tenToThe(_ exp: Int) -> Int {
            return intPow(10, exp)
        }
        
        func digit(in number: Int, at index: Int) -> Int {
            return (number / tenToThe(index)) % 10
        }
        
        XCTAssert(findNthDigit(5) == 5)
        XCTAssert(findNthDigit(10) == 1)
        XCTAssert(findNthDigit(1000) == 3)
    }
    
    // MARK: - 401. Binary Watch
    
    func testProblem401() {
        
        func readBinaryWatch(_ num: Int) -> [String] {
            
            func choose(_ num: Int, _ total: Int) -> [[Bool]] {
                
                if total == 0 {
                    return [[]]
                }
                
                if num == 0 {
                    return [Array(repeating: false, count: total)]
                }
                
                if num == total {
                    return [Array(repeating: true, count: total)]
                }
                
                var subsolutions1 = choose(num, total - 1)
                for i in 0 ..< subsolutions1.count {
                    subsolutions1[i].append(false)
                }
                
                var subsolutions2 = choose(num - 1, total - 1)
                for i in 0 ..< subsolutions2.count {
                    subsolutions2[i].append(true)
                }
                
                return subsolutions1 + subsolutions2
            }
            
            func clockNumbers(_ states: [Bool]) -> (hour: Int, minute: Int) {
                
                var index = 0
                var hours = 0
                var minutes = 0
                
                while index < 4 {
                    hours *= 2
                    hours += states[index] ? 1 : 0
                    index += 1
                }
                
                while index < 10 {
                    minutes *= 2
                    minutes += states[index] ? 1 : 0
                    index += 1
                }
                
                return (hours, minutes)
            }
            
            let permutations = choose(num, 10)
            
            var solutions = [String]()
            
            for states in permutations {
                
                let (hours, minutes) = clockNumbers(states)
                
                if hours >= 12 || minutes >= 60 {
                    continue
                }
                
                let time = String(format: "%d:%02d", hours, minutes)
                
                solutions.append(time)
            }
            
            return solutions
        }
        
        print(readBinaryWatch(1))
    }
    
    // MARK: - 404. Sum of Left Leaves
    
    func testProblem404() {
        
        func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
            
            func helper(_ root: TreeNode?, isLeft: Bool) -> Int {
                
                guard let root = root else {
                    return 0
                }
                
                if isLeft && root.left == nil && root.right == nil {
                    return root.val
                }
                
                let a = helper(root.left, isLeft: true)
                let b = helper(root.right, isLeft: false)
                
                return a + b
            }
            
            return helper(root, isLeft: false)
        }
    }
    
    // MARK: - 405. Convert a Number to Hexadecimal
    
    func testProblem405() {
        
        func toHex(_ num: Int) -> String {
            
            func intToHexChar(_ i: Int) -> Character {
                
                assert(i < 16)
                
                if i < 10 {
                    return String(i).characters.first!
                }
                
                let offset = Int(("a" as UnicodeScalar).value) + (i - 10)
                return Character(UnicodeScalar(offset)!)
            }
            
            if num == 0 {
                return "0"
            }
            
            var temp = Int64(num)
            
            if num < 0 {
                temp += Int64(UInt32.max) + 1
            }
            
            var solution = ""
            
            while temp > 0 {
                
                let digit = Int(temp % 16)
                
                let c = intToHexChar(digit)
                
                solution = String(c) + solution
                
                temp /= 16
            }
            
            return solution
        }
        
        XCTAssert(toHex(-1) == "ffffffff")
        XCTAssert(toHex(-2) == "fffffffe")
    }
    
    // MARK: - 406. Queue Reconstruction by Height
    
    func testProblem406() {
        
        func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
            
            var solution = people.sorted {
                
                let h1 = $0[0]
                let h2 = $1[0]
                let t1 = $0[1]
                let t2 = $1[1]
                
                if h1 == h2 {
                    return t1 < t2
                } else {
                    return h1 > h2
                }
            }
            
            var i = 0
            
            while i < solution.count {
                
                let person = solution[i]
                let height = person[0]
                let taller = person[1]
                
                var currentTaller = 0
                
                var j = 0
                
                while j < i {
                    
                    if solution[j][0] >= height {
                        currentTaller += 1
                    }
                    
                    if currentTaller > taller {
                        break
                    }
                    
                    j += 1
                }
                
                if j != i {
                    
                    solution.remove(at: i)
                    solution.insert(person, at: j)
                }
                
                i += 1
            }
            
            return solution
        }
        
        let input = [[9,0],[7,0],[1,9],[3,0],[2,7],[5,3],[6,0],[3,4],[6,2],[5,2]]
        let expectedOutput = [[3,0],[6,0],[7,0],[5,2],[3,4],[5,3],[6,2],[2,7],[9,0],[1,9]]
        let output = reconstructQueue(input)
        
        XCTAssert(equal2DArrays(output, expectedOutput))
    }
    
    // MARK: - 409. Longest Palindrome
    
    func testProblem409() {
        
        func longestPalindrome(_ s: String) -> Int {
            
            var counts = [Character: Int]()
            
            for c in s.characters {
                
                if counts[c] == nil {
                    counts[c] = 0
                }
                
                counts[c]! += 1
            }
            
            var longest = 0
            var hasOdd = false
            
            for (_, count) in counts {
                
                if count % 2 == 1 {
                    hasOdd = true
                }
                
                let usableCount = count - (count % 2)
                longest += usableCount
            }
            
            if hasOdd {
                longest += 1
            }
            
            return longest
        }
    }
    
    // MARK: - 412. Fizz Buzz
    
    func testProblem412() {
        
        func fizzBuzz(_ n: Int) -> [String] {
            
            var solution = [String]()
            
            for i in 1 ... n {
                
                var word = ""
                
                if i % 3 == 0 {
                    word += "Fizz"
                }
                
                if i % 5 == 0 {
                    word += "Buzz"
                }
                
                if word == "" {
                    word = String(i)
                }
                
                solution.append(word)
            }
            
            return solution
        }
    }
    
    // MARK: - 413. Arithmetic Slices
    
    func testProblem413() {
        
        func numberOfArithmeticSlices(_ a: [Int]) -> Int {
            
            func sliceCount(for length: Int) -> Int {
                
                if length < 3 {
                    return 0
                }
                
                let x = length - 2
                
                return x * (x + 1) / 2
            }
            
            if a.count < 3 {
                return 0
            }
            
            var solution = 0
            
            var diff = a[1] - a[0]
            var prev = a[1]
            var length = 2
            
            for i in 2 ..< a.count {
                
                let n = a[i]
                let thisDiff = n - prev
                
                if thisDiff == diff {
                    
                    length += 1
                    
                } else {
                    
                    solution += sliceCount(for: length)
                    length = 2
                    diff = thisDiff
                }
                
                prev = n
            }
            
            solution += sliceCount(for: length)
            
            return solution
        }
    }
    
    // MARK: - 414. Third Maximum Number
    
    func testProblem414() {
        
        func thirdMax(_ nums: [Int]) -> Int {
            
            var max1: Int?
            var max2: Int?
            var max3: Int?
            
            for n in nums {
                
                if n == max1 || n == max2 || n == max3 {
                    continue
                }
                
                if max1 == nil || n > max1! {
                    max3 = max2
                    max2 = max1
                    max1 = n
                    
                } else if max2 == nil || n > max2! {
                    max3 = max2
                    max2 = n
                    
                } else if max3 == nil || n > max3! {
                    max3 = n
                }
            }
            
            return (max3 != nil) ? max3! : max1!
        }
    }
    
    // MARK: - 415. Add Strings
    
    func testProblem415() {
        
        func addStrings(_ num1: String, _ num2: String) -> String {
            
            func charToInt(_ c: Character) -> Int {
                let i = Int(String(c))!
                assert(i < 10)
                return i
            }
            
            func intToChar(_ i: Int) -> Character {
                assert(i < 10)
                let offset = Int(("0" as UnicodeScalar).value) + i
                return Character(UnicodeScalar(offset)!)
            }
            
            if num1 == "" && num2 == "" {
                return ""
            }
            
            if num1 == "" {
                return num2
            }
            
            if num2 == "" {
                return num1
            }
            
            let a1 = Array(num1.characters)
            let a2 = Array(num2.characters)
            
            var i1 = a1.count - 1
            var i2 = a2.count - 1
            
            var solution = ""
            var rem = 0
            
            while i1 >= 0 || i2 >= 0 || rem != 0 {
                
                let c1 = (i1 >= 0) ? a1[i1] : "0"
                let c2 = (i2 >= 0) ? a2[i2] : "0"
                
                let d1 = charToInt(c1)
                let d2 = charToInt(c2)
                
                let s = d1 + d2 + rem
                
                let d = s % 10
                let c = intToChar(d)
                
                solution = String(c) + solution
                
                rem = s / 10
                
                i1 -= 1
                i2 -= 1
            }
            
            return solution
        }
        
        XCTAssert(addStrings("0", "0") == "0")
    }
    
    // MARK: - 419. Battleships in a Board
    
    func testProblem419() {
        
        func countBattleships(_ board: [[Character]]) -> Int {
            
            let width = board[0].count
            let height = board.count
            
            var inShip = false
            var count = 0
            
            for row in 0 ..< height {
                
                for col in 0 ..< width {
                    
                    if board[row][col] == "X" {
                        
                        if inShip {
                            continue
                        }
                        
                        if row == 0 || board[row - 1][col] != "X" {
                            
                            count += 1
                        }
                        
                        inShip = true
                        
                    } else {
                        
                        inShip = false
                    }
                }
                
                inShip = false
            }
            
            return count
        }
    }
    
    // MARK: - 434. Number of Segments in a String
    
    func testProblem434() {
        
        let whitespaceSet = NSCharacterSet.whitespacesAndNewlines
        
        func isWhitespace(_ c: Character) -> Bool {
            return String(c).rangeOfCharacter(from: whitespaceSet) != nil
        }
        
        func countSegments(_ s: String) -> Int {
            
            let a = Array(s.characters)
            
            var inbetween = true
            var count = 0
            
            for c in a {
                
                if isWhitespace(c) {
                    
                    if !inbetween {
                        inbetween = true
                    }
                    
                } else {
                    
                    if inbetween {
                        inbetween = false
                        count += 1
                    }
                }
            }
            
            return count
        }
    }
    
    // MARK: - 437. Path Sum III
    
    func testProblem437() {
        
        func pathSum(_ root: TreeNode?, _ sum: Int) -> Int {
            
            func helper(_ root: TreeNode?, _ sum: Int, canBreak: Bool) -> Int {
                
                guard let root = root else {
                    return 0
                }
                
                let localSolutions = (sum == root.val) ? 1 : 0
                
                let remaining = sum - root.val
                
                let numLeftInclusive = helper(root.left, remaining, canBreak: false)
                let numRightInclusive = helper(root.right, remaining, canBreak: false)
                
                let numInclusive = numLeftInclusive + numRightInclusive
                
                var numExclusive = 0
                
                if canBreak {
                    
                    let numLeftExclusive = helper(root.left, sum, canBreak: true)
                    let numRightExclusive = helper(root.right, sum, canBreak: true)
                    
                    numExclusive = numLeftExclusive + numRightExclusive
                }
                
                return localSolutions + numInclusive + numExclusive
            }
            
            return helper(root, sum, canBreak: true)
        }
        
        XCTAssert(pathSum(TreeNode(values: 10,5,-3,3,2,nil,11,3,-2,nil,1), 8) == 3)
        XCTAssert(pathSum(TreeNode(values: 1,nil,2,nil,3,nil,4,nil,5), 3) == 2)
        XCTAssert(pathSum(TreeNode(values: 1,-2,-3,1,3,-2,nil,-1), 1) == 3)
    }
    
    // MARK: - 438. Find All Anagrams in a String
    
    func testProblem438() {
        
        func findAnagrams(_ s: String, _ p: String) -> [Int] {
            
            if s == "" || p == "" {
                return []
            }
            
            let sa = Array(s.characters)
            let pa = Array(p.characters)
            
            let s_len = s.characters.count
            let p_len = p.characters.count
            
            if s_len < p_len {
                return []
            }
            
            var s_counts = [Character: Int]()
            var p_counts = [Character: Int]()
            
            for c in pa {
                
                if p_counts[c] == nil {
                    p_counts[c] = 0
                }
                
                p_counts[c]! += 1
            }
            
            for j in 0 ..< p_len {
                
                let c = sa[j]
                
                if s_counts[c] == nil {
                    s_counts[c] = 0
                }
                
                s_counts[c]! += 1
            }
            
            var solutions = [Int]()
            var i = 0
            
            while true {
                
                // If the counts are the same we have a solution.
                
                if s_counts == p_counts {
                    solutions.append(i)
                }
                
                // Update for the next iteration.
                
                i += 1
                
                if i > s_len - p_len {
                    break
                }
                
                let old_c = sa[i - 1]
                let new_c = sa[i + p_len - 1]
                
                if old_c != new_c {
                    
                    // Remove old char from counts.
                    
                    s_counts[old_c]! -= 1
                    
                    if s_counts[old_c]! == 0 {
                        s_counts[old_c] = nil
                    }
                    
                    // Add new char to counts.
                    
                    if s_counts[new_c] == nil {
                        s_counts[new_c] = 0
                    }
                    
                    s_counts[new_c]! += 1
                }
            }
            
            return solutions
        }
        
        XCTAssert(findAnagrams("cbaebabacd", "abc") == [0, 6])
        XCTAssert(findAnagrams("abab", "ab") == [0, 1, 2])
    }
    
    // MARK: - 441. Arranging Coins
    
    func testProblem441() {
        
        func arrangeCoins(_ n: Int) -> Int {
            
            if n == 0 {
                return 0
            }
            
            var i = 1
            var remaining = n
            
            while true {
                
                if remaining >= i {
                    remaining -= i
                } else {
                    return i - 1
                }
                
                i += 1
            }
        }
    }
    
    // MARK: - 442. Find All Duplicates in an Array
    
    func testProblem442() {
        
        func findDuplicates(_ nums: [Int]) -> [Int] {
            
            var solution = [Int]()
            var seen = Set<Int>()
            
            for n in nums {
                
                if seen.contains(n) {
                    solution.append(n)
                } else {
                    seen.insert(n)
                }
            }
            
            return solution
        }
    }
    
    // MARK: - 447. Number of Boomerangs
    
    func testProblem447() {
        
        func distanceSqrd(_ p1: [Int], _ p2: [Int]) -> Int {
            
            let dx = p2[0] - p1[0]
            let dy = p2[1] - p1[1]
            
            return dx * dx + dy * dy
        }
        
        func choose2(_ n: Int) -> Int {
            
            if n < 2 {
                return 0
            }
            
            return n * (n - 1)
        }
        
        func numberOfBoomerangs(_ points: [[Int]]) -> Int {
            
            var boomerangCount = 0
            
            for p1 in points {
                
                var distanceCounts = [Int: Int]()
                
                for p2 in points {
                    
                    if p2 == p1 {
                        continue
                    }
                    
                    let d = distanceSqrd(p1, p2)
                    
                    if distanceCounts[d] == nil {
                        distanceCounts[d] = 0
                    }
                    
                    distanceCounts[d]! += 1
                }
                
                for (_, count) in distanceCounts {
                    
                    boomerangCount += choose2(count)
                }
            }
            
            return boomerangCount
        }
        
        XCTAssert(numberOfBoomerangs([[0,0],[1,0],[2,0]]) == 2)
        XCTAssert(numberOfBoomerangs([[0,0],[1,0],[-1,0],[0,1],[0,-1]]) == 20)
        
        /*
        self.measure {
            numberOfBoomerangs([[3327,-549],[9196,-8118],[7610,-9506],[5098,8392],[8582,7953],[1053,5802],[3847,2652],[7654,8355],[1614,-9409],[9986,5538],[4660,2944],[4528,-9512],[7483,-1455],[3422,-3966],[2037,-4456],[5107,-4635],[4996,655],[7247,2606],[1149,8697],[7350,6083],[3002,8403],[8238,6850],[1055,5892],[5205,9021],[2835,5191],[911,-2505],[4488,-4561],[7983,-1677],[336,-2243],[4358,-1274],[3302,9465],[4091,-5350],[120,7690],[3608,7622],[6388,-9042],[57,-610],[9361,8295],[6240,-3232],[540,7797],[2141,-6625],[9341,3053],[7223,3829],[4844,1558],[2152,-8467],[9316,6510],[259,-1030],[2327,-5650],[9972,8800],[2040,-6420],[2774,4780],[4538,-7169],[4171,-6101],[7479,-3237],[7019,-1981],[4561,-4488],[7746,254],[4917,4969],[4083,-238],[6528,-7413],[1295,-7804],[5450,-8446],[1166,-5871],[2256,-8862],[2929,-5704],[4718,2055],[5429,-4392],[4887,9600],[9507,-1282],[2715,2878],[6737,-6372],[8390,-9165],[3882,3308],[5805,4317],[9422,8685],[3257,-2931],[881,-1293],[8623,-1601],[2836,879],[5889,2118],[1527,607],[4173,-3044],[6215,5412],[2908,-7926],[4130,-8024],[1304,7219],[1956,-3954],[8055,5839],[5706,212],[6508,5128],[8897,9765],[2197,-3870],[8472,-2828],[4529,7661],[4403,-9582],[6131,-7717],[7377,-3344],[5591,9944],[2069,-5148],[8370,-7449],[6828,-3974],[6123,-1216],[2072,530],[975,-2221],[7094,-2516],[9259,-4009],[7249,7809],[8473,2074],[4981,-6998],[9735,5737],[9772,5866],[8020,-6499],[8874,-6389],[3445,-9057],[4815,8167],[9847,1643],[4193,2322],[6780,2617],[9204,4107],[396,6298],[1591,6008],[2289,-4807],[3817,762],[7267,5150],[116,-6646],[887,-3760],[5572,-4741],[9741,4446],[5223,-462],[1742,38],[7705,1589],[1682,-1750],[263,4814],[867,9467],[8921,7616],[5765,-3135],[3624,4406],[2058,-2559],[1520,-675],[2591,-2012],[2679,-169],[4228,-1749],[5090,-6031],[2697,-9687],[9859,791],[352,3916],[8732,-1614],[2166,8995],[3200,9385],[4814,-1527],[7001,579],[5338,-3023],[1337,-2604],[4418,-7143],[3073,3362],[845,-7896],[3193,-8575],[6707,4635],[1746,-595],[4949,1605],[6548,-8347],[1873,5281],[39,-5961],[4276,-409],[9777,-909],[8064,3130],[6022,-245],[108,7360],[7151,4526],[6569,-3423],[4240,-2585],[8681,-2567],[5192,5389],[2069,-3061],[1146,3370],[4896,7694],[5023,6770],[2975,-8586],[7161,-6396],[1005,6938],[2695,-4579],[69,-4931],[5176,177],[2429,-1320],[1055,8999],[5257,-4704],[2766,-6062],[9081,-2042],[5679,-2498],[1249,6825],[7224,-3854],[872,2247],[2916,-6153],[3661,-9923],[7451,-8982],[7016,6498],[6440,-6563],[1568,-8384],[9966,-9651],[296,1021],[9348,-8095],[2669,8466],[2196,-8249],[2777,7875],[5605,4026],[1053,-7170],[172,-8075],[1429,-6912],[5772,-8557],[9518,-424],[2461,2886],[2426,-1099],[6323,-6006],[6870,-3711],[696,3518],[3662,6396],[5424,-3668],[4863,7620],[4435,7640],[1847,-3608],[8018,-7100],[9222,-5457],[4825,7004],[3983,-3050],[8447,-6499],[2878,-9092],[6387,5304],[6162,-938],[5651,3032],[5351,6347],[2902,-4634],[2743,8326],[8050,-6042],[2298,-1163],[7950,-9502],[5229,-4031],[3398,-9196],[512,-5424],[7808,847],[7878,6255],[4349,7108],[7163,736],[8764,9677],[6151,-5585],[2709,-2146],[7114,5612],[3220,-3790],[290,-8730],[168,8941],[107,-5529],[9439,-8311],[440,9189],[2493,7304],[117,6653],[8151,-5653],[2908,8852],[1455,-3577],[5941,-3428],[6101,-7908],[7339,5162],[9946,-5546],[7126,9519],[7016,3769],[789,7184],[2710,-2751],[1655,-1499],[5290,-1553],[4042,-2217],[2103,-9488],[788,-3393],[1211,3696],[1811,9019],[6471,-2248],[5591,8924],[6196,2930],[4087,6143],[3736,7565],[5662,-9248],[1334,2803],[4289,-9604],[6404,2296],[8897,-8306],[7096,-708],[5829,9199],[6156,-3383],[2158,-2633],[6665,-9678],[6386,3137],[8074,1977],[2061,4271],[4908,-7500],[6766,4996],[66,8780],[5749,1400],[7935,38],[1797,-5660],[2334,7046],[2386,9430],[2690,-1784],[4982,-1154],[1185,3492],[6214,-2149],[3814,8952],[7340,8241],[930,-4247],[8864,2190],[8254,5630],[7186,-5328],[762,9287],[6072,8697],[9325,-5779],[9389,1660],[7620,-8224],[7442,-9690],[9992,-7576],[5509,7529],[2269,8075],[5380,-3917],[7027,-7280],[4324,-5691],[8474,3188],[6499,3080],[5170,-9962],[7752,5932],[9325,176],[982,-1349],[4398,371],[6663,-1630],[2147,-9543],[5032,8491],[9234,541],[6021,1503],[8616,7753],[3938,-8004],[6826,8263],[6305,-8348],[7803,9157],[4732,-674],[9195,-1164],[5258,8520],[9012,2592],[3523,-238],[2964,6538],[8132,1463],[3348,-6835],[6307,2582],[58,-7672],[437,5027],[6433,4375],[7023,3259],[8990,-6672],[4911,3146],[2485,-4005],[2472,8032],[4831,-5918],[2905,196],[6675,6428],[9958,9639],[9319,4443],[7454,-7333],[3960,3761],[1601,-9630],[2441,2038],[5397,-1125],[6413,2420],[8486,1756],[2101,3398],[4902,938],[5745,-2626],[5323,-3071],[1456,8228],[7125,-1869],[1008,3435],[4122,6679],[4230,1577],[9346,8190],[1690,947],[4913,4132],[9337,310],[3007,-4249],[9083,-8507],[7507,-2464],[1243,-7591],[4826,-3011],[6135,-9851],[3918,7591],[8377,-2605],[5723,-4262],[830,-3803],[2417,-8587],[7774,8116],[5955,9465],[5415,868],[9949,-5247],[1179,2956],[6856,6614],[801,-9285],[4150,8397],[9476,8976],[1738,-4389],[9126,2008],[3202,3855],[9403,-4723],[9593,6585],[1475,-7989],[7998,-4399],[127,306],[1418,-4458],[1174,1367],[6647,-7647],[4323,3503],[8967,1477],[4218,9469],[6226,3694],[8446,-2036],[9305,3924],[9972,8860],[7779,5727],[4137,-6275],[8664,1964],[5736,-6985],[7566,-7785],[3321,8984],[4109,4495],[352,757],[3201,1027],[4260,-1480],[8856,4831],[7990,-4918],[8525,-7212],[3046,-5817],[6712,-630],[3043,-5509],[1449,-6468],[8216,-3534],[5497,304],[9481,3063],[8871,9154],[8399,2981],[1,8751],[90,-6798],[6131,-9298],[8075,-5013],[5533,6065],[70,-9589],[5205,9468],[946,1917],[5191,-6011],[2760,-7008],[3873,7329],[9458,9370],[7633,5291],[8785,2857],[797,3537],[2190,-9201],[2288,-7720],[353,4771],[9334,-1572],[9759,1220],[845,-3819],[7983,6050],[2001,-1071],[4319,-2808],[9270,7080],[6537,3143],[4409,2347],[8866,8394],[7639,4003],[7603,4788],[7540,-207],[5587,6181],[8425,5941],[952,-5888],[721,-2937],[5332,-8433],[3244,-6685],[3969,5246],[2244,8289],[8790,-8486],[1721,-4673],[1009,-3870],[7675,9875],[876,-8334],[231,-1520],[6454,7771],[4625,2042],[304,9403],[4335,-8743],[3515,-4944],[4672,8847],[2975,7917],[8514,6945],[3163,758],[1586,1953],[8624,-6693],[7281,9633],[5789,1308],[5861,-6983],[2974,-3908],[7849,-572],[215,-7525]])
        }
        */
    }
    
    // MARK: - 448. Find All Numbers Disappeared in an Array
    
    func testProblem448() {
        
        func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
            
            if nums.isEmpty {
                return []
            }
            
            var indices = [Int](1 ... nums.count)
            
            for n in nums {
                indices[n - 1] = 0
            }
            
            return indices.filter { $0 != 0 }
        }
    }
    
    // MARK: - 451. Sort Characters By Frequency
    
    func testProblem451() {
        
        func frequencySort(_ s: String) -> String {
            
            var counts = [Character: Int]()
            
            for c in s.characters {
                
                if counts[c] == nil {
                    counts[c] = 0
                }
                
                counts[c]! += 1
            }
            
            var table = [Int: [Character]]()
            
            for (c, count) in counts {
                
                if table[count] == nil {
                    table[count] = []
                }
                
                table[count]!.append(c)
            }
            
            let sortedCounts = Array(table.keys).sorted(by: >)
            
            var solution = ""
            
            for thisCount in sortedCounts {
                
                for c in table[thisCount]! {
                    
                    for i in 0 ..< thisCount {
                        solution += String(c)
                    }
                }
            }
            
            return solution
        }
    }
    
    // MARK: - 453. Minimum Moves to Equal Array Elements
    
    func testProblem453() {
        
        func minMoves(_ nums: [Int]) -> Int {
            
            var smallest = Int.max
            
            for n in nums {
                if n < smallest {
                    smallest = n
                }
            }
            
            var total = 0
            
            for n in nums {
                total += (n - smallest)
            }
            
            return total
        }
        
        func slowMinMoves(_ nums: [Int]) -> Int {
            
            var ns = nums
            
            var largest = Int.min
            var largestIndex = -1
            var secondLargest = Int.min
            var firstPass = true
            var moveCount = 0
            
            while true {
            
                var newLargest = Int.min
                var newLargestIndex = -1
                var newSecondLargest = Int.min
                var allEqual = true
                
                let distance = max(1, largest - secondLargest)
            
                for i in 0 ..< ns.count {
                
                    if !firstPass {
                        if i != largestIndex {
                            ns[i] += distance
                        }
                    }
                    
                    if ns[i] >= newLargest {
                        
                        newSecondLargest = newLargest
                        newLargest = ns[i]
                        newLargestIndex = i
                        
                    } else if ns[i] > newSecondLargest {
                        
                        newSecondLargest = ns[i]
                    }
                    
                    if ns[i] != ns[0] {
                        allEqual = false
                    }
                }
                
                if !firstPass {
                    moveCount += distance
                }
                    
                firstPass = false
                
                if allEqual {
                    break
                }
                
                largest = newLargest
                largestIndex = newLargestIndex
                secondLargest = newSecondLargest
            }
            
            return moveCount
        }
        
        
    }
    
    // MARK: - 455. Assign Cookies
    
    func testProblem455() {
        
        func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
            
            let kidCount = g.count
            let cookieCount = s.count
            
            let greeds = g.sorted()
            let sizes = s.sorted()
            
            var gi = 0
            var si = 0
            
            var count = 0
            
            while gi < kidCount && si < cookieCount {
                
                if greeds[gi] <= sizes[si] {
                    
                    gi += 1
                    si += 1
                    count += 1
                    
                } else {
                    
                    si += 1
                }
            }
            
            return count
        }
    }
    
    // MARK: - 459. Repeated Substring Pattern
    
    func testProblem459() {
        
        func repeatedSubstringPattern(_ s: String) -> Bool {
            
            let a = Array(s.characters)
            let len = a.count
            
            var i = 1
            
            while i < len {
                
                // Find the next char the matches the first in the string.
                
                while i < len && a[0] != a[i] {
                    i += 1
                }
                
                if i == len {
                    return false
                }
                
                if len % i != 0 {
                    i += 1
                    continue
                }
                
                // Once found, check all subsequent chars in the two sequences.
                
                let repeats = len / i
                
                var match = true
                
                comparison:
                    for r in 1 ..< repeats {
                        
                        for j in 0 ..< i {
                            
                            if a[j] != a[r * i + j] {
                                
                                match = false
                                break comparison
                            }
                        }
                }
                
                if match {
                    return true
                }
                
                i += 1
            }
            
            return false
        }
        
        XCTAssert(repeatedSubstringPattern("abab") == true)
    }
    
    // MARK: - 461. Hamming Distance
    
    func testProblem461() {
        
        func hammingDistance(_ x: Int, _ y: Int) -> Int {
            
            var count = 0
            
            for i in 0 ..< 32 {
                
                let mask = (0x1 << i)
                
                let bx = x & mask > 0
                let by = y & mask > 0
                
                if bx != by {
                    count += 1
                }
            }
            
            return count
        }
    }
    
    // MARK: - 462. Minimum Moves to Equal Array Elements II
    
    func testProblem462() {
        
        func minMoves2(_ nums: [Int]) -> Int {
            
            func calcMedian(_ nums: [Int]) -> Int {
                let sorted = nums.sorted()
                return sorted[nums.count / 2]
            }
            
            let median = calcMedian(nums)
            
            var moveCount = 0
            
            for n in nums {
                
                let distance = abs(median - n)
                
                moveCount += distance
            }
            
            return moveCount
        }
    }
    
    // MARK: - 463. Island Perimeter
    
    struct Point: Hashable {
        
        var x: Int
        var y: Int
        
        init(_ xx: Int, _ yy: Int) {
            x = xx
            y = yy
        }
        
        var hashValue: Int {
            return x.hashValue ^ y.hashValue &* 16777619
        }
        
        static func ==(lhs: Point, rhs: Point) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
    
    func testProblem463() {
        
        func islandPerimeter(_ grid: [[Int]]) -> Int {
            
            let width = grid.count
            let height = grid[0].count
            
            var perimeter = 0
            
            for x in 0 ..< width {
                
                for y in 0 ..< height {
                    
                    if grid[x][y] == 1 {
                        
                        perimeter += 4
                        
                        if x < width - 1 && grid[x + 1][y] == 1 {
                            perimeter -= 2
                        }
                        
                        if y < height - 1 && grid[x][y + 1] == 1 {
                            perimeter -= 2
                        }
                    }
                }
            }
            
            return perimeter
        }
        
        func slowIslandPerimeter(_ grid: [[Int]]) -> Int {
            
            // Check for valid sizes.
            
            let width = grid.count
            if width == 0 {
                return 0
            }
            
            let height = grid[0].count
            if height == 0 {
                return 0
            }
            
            // Helpers.
            
            func isLand(_ p: Point) -> Bool {
                
                let validX = 0 <= p.x && p.x < width
                let validY = 0 <= p.y && p.y < height
                
                return validX && validY && grid[p.x][p.y] == 1
            }
            
            func neighbors(_ p: Point) -> [Point] {
                
                let lp = Point(p.x - 1, p.y)
                let rp = Point(p.x + 1, p.y)
                let tp = Point(p.x, p.y - 1)
                let bp = Point(p.x, p.y + 1)
                
                return [lp, rp, tp, bp].filter { isLand($0) }
            }
            
            var visited = Array(repeating: Array(repeating: false, count: height), count: width)
            
            func hasBeenVisited(_ p: Point) -> Bool {
                return visited[p.x][p.y]
            }
            
            func setVisited(_ p: Point) {
                visited[p.x][p.y] = true
            }
            
            // Find starting point.
            
            var startingPoint: Point?
            
            outer:
            for x in 0 ..< width {
                for y in 0 ..< height {
                    
                    let xx = (x + width / 2) % width
                    let yy = (y + height / 2) % height
                    
                    let point = Point(xx, yy)
                    
                    if isLand(point) {
                        
                        startingPoint = point
                        break outer
                    }
                }
            }
            
            guard let point = startingPoint else {
                return 0
            }
            
            // Expand points and calculate perimeter.
            
            var outerPoints = [point]
            setVisited(point)
            
            var perimeter = 4
            
            while true {
                
                var changes = 0
                var newOuterPoints = [Point]()
                
                for p in outerPoints {
                    
                    let newNeighbors = neighbors(p).filter {
                        !hasBeenVisited($0)
                    }
                    
                    for n in newNeighbors {
                        
                        let nn = neighbors(n).filter {
                            hasBeenVisited($0)
                        }
                        
                        perimeter -= nn.count
                        perimeter += 4 - nn.count
                        
                        newOuterPoints.append(n)
                        setVisited(n)
                        
                        changes += 1
                    }
                }
                
                outerPoints = newOuterPoints
                
                if changes == 0 {
                    break
                }
            }
            
            return perimeter
        }
        
        XCTAssert(islandPerimeter([[1],[0]]) == 4)
        XCTAssert(islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]) == 16)
        
        self.measure {
            //islandPerimeter(largeIsland)
            //islandPerimeter(largeIsland2)
            //islandPerimeter(hugeIsland)
            //islandPerimeter(giganticIsland)
        }
    }
    
    // MARK: - 475. Heaters
    
    func testProblem475() {
        
        func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
            
            let homes = houses.sorted()
            let heats = heaters.sorted()
            
            var l = 0
            var r = 0
            
            var maxDist = 0
            
            for home in homes {
                
                var leftDist = Int.max
                var rightDist = Int.max
                
                if l == -1 {
                    l = 0
                }
                
                while l < heats.count && heats[l] <= home {
                    l += 1
                }
                
                if l < heats.count && heats[l] == home {
                    r = l
                    continue
                }
                
                l -= 1
                
                r = max(0, l)
                
                if 0 <= l && l < heats.count {
                    leftDist = home - heats[l]
                }
                
                while r < heats.count && heats[r] < home {
                    r += 1
                }
                
                if r < heats.count {
                    rightDist = heats[r] - home
                }
                
                let closest = min(leftDist, rightDist)
                
                if closest > maxDist {
                    maxDist = closest
                } 
            }
            
            return maxDist
        }
        
        XCTAssert(findRadius([1, 2, 3], [2]) == 1)
    }
    
    // MARK: - 476. Number Complement
    
    func testProblem476() {
        
        func findComplement(_ num: Int) -> Int {
            
            func highestBit(_ number: Int) -> Int {
                
                var highest = -1
                
                for i in 0 ..< 32 {
                    if number & (0x1 << i) > 0 {
                        highest = i
                    }
                }
                
                return highest
            }
            
            func intPow(_ n: Int, _ exp: Int) -> Int {
                return Array(repeating: 2, count: exp).reduce(1, *)
            }
            
            func turnOffBits(_ number: Int, _ index: Int) -> Int {
                return number & (intPow(2, index + 1) - 1)
            }
            
            let highest = highestBit(num)
            
            let inverted = ~num
            
            let cleaned = turnOffBits(inverted, highest)
            
            return cleaned
        }
        
        XCTAssert(findComplement(5) == 2)
    }
    
    // MARK: - 485. Max Consecutive Ones
    
    func testProblem485() {
        
        func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
            
            var longest = 0
            var current = 0
            
            for n in nums {
                
                if n == 1 {
                    current += 1
                    longest = max(longest, current)
                } else {
                    current = 0
                }
            }
            
            return longest
        }
    }
    
    // MARK: - 495. Teemo Attacking
    
    func testProblem495() {
        
        func findPoisonedDuration(_ timeSeries: [Int], _ duration: Int) -> Int {
            
            var prevTime: Int?
            var totalDuration = 0
            
            for t in timeSeries {
                
                totalDuration += duration
                
                var overlap = 0
                
                if let pt = prevTime {
                    overlap = pt + duration - t
                }
                
                if overlap > 0 {
                    totalDuration -= overlap
                }
                
                prevTime = t
            }
            
            return totalDuration
        }
    }
    
    // MARK: - 496. Next Greater Element I
    
    func testProblem496() {
        
        func nextGreaterElement(_ findNums: [Int], _ nums: [Int]) -> [Int] {
            
            var unsolved = Set<Int>()
            var table = [Int: Int]()
            
            for n in nums {
                
                var solved = [Int]()
                
                for u in unsolved {
                    if u < n {
                        table[u] = n
                        solved.append(u)
                    }
                }
                
                for s in solved {
                    unsolved.remove(s)
                }
                
                unsolved.insert(n)
            }
            
            for n in unsolved {
                table[n] = -1
            }
            
            var solution = [Int]()
            
            for f in findNums {
                
                solution.append(table[f]!)
            }
            
            return solution
        }
    }
    
    // MARK: - 500. Keyboard Row
    
    func testProblem500() {
        
        let rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"].map { Array($0.characters) }
        
        func findWords(_ words: [String]) -> [String] {
            
            var solution = [String]()
            
            for word in words {
                
                let cs = Array(word.lowercased().characters)
                
                for row in rows {
                    
                    var match = true
                    
                    for c in cs {
                        if !row.contains(c) {
                            match = false
                            break
                        }
                    }
                    
                    if match {
                        solution += [word]
                    }
                }
            }
            
            return solution
        }
    }
    
    // MARK: - 501. Find Mode in Binary Search Tree
    
    func testProblem501() {
        
        var counts = [Int: Int]()
        
        var solutions = [Int]()
        
        var maxCount = 0
        
        func findMode(_ root: TreeNode?) -> [Int] {
            
            guard let root = root else {
                return []
            }
            
            if counts[root.val] == nil {
                counts[root.val] = 0
            }
            
            counts[root.val]! += 1
            
            let count = counts[root.val]!
            
            if count > maxCount {
                
                maxCount = count
                solutions = [root.val]
                
            } else if count == maxCount {
                
                solutions += [root.val]
            }
            
            _ = findMode(root.left)
            _ = findMode(root.right)
            
            return solutions
        }
    }
    
    // MARK: - 504. Base 7
    
    func testProblem504() {
        
        func convertToBase7(_ num: Int) -> String {
            
            if num == 0 {
                return "0"
            }
            
            let negative = num < 0
            
            var str = ""
            
            var value = abs(num)
            
            while value > 0 {
                
                let d = value % 7
                
                str = String(d) + str
                
                value /= 7
            }
            
            if negative {
                str = "-" + str
            }
            
            return str
        }
    }
    
    // MARK: - 506. Relative Ranks
    
    func testProblem506() {
        
        func findRelativeRanks(_ nums: [Int]) -> [String] {
            
            let sorted = nums.sorted(by: >)
            
            var ranks = [Int: Int]()
            
            for (i, n) in sorted.enumerated() {
                ranks[n] = i
            }
            
            var solution = [String]()
            
            for n in nums {
                
                let rank = ranks[n]!
                
                var s = ""
                
                switch rank {
                case 0:
                    s = "Gold Medal"
                case 1:
                    s = "Silver Medal"
                case 2:
                    s = "Bronze Medal"
                default:
                    s = String(rank + 1)
                }
                
                solution.append(s)
            }
            
            return solution
        }
    }
    
    // MARK: - 507. Perfect Number
    
    func testProblem507() {
        
        func checkPerfectNumber(_ num: Int) -> Bool {
            
            if num <= 0 {
                return false
            }
            
            if num == 1 {
                return false
            }
            
            let root = Int(sqrt(Double(num)))
            
            var sum = 1
            var i = 2
            
            while i <= root {
                
                if num % i == 0 {
                    
                    sum += i
                    
                    let other = (num / i)
                    
                    if i != other && other != num {
                        sum += other
                    }
                    
                    if sum > num {
                        return false
                    }
                }
                
                i += 1
            }
            
            return sum == num
        }
        
        XCTAssert(checkPerfectNumber(28) == true)
        
        self.measure {
            XCTAssert(checkPerfectNumber(30402457) == false)
        }
    }
    
    // MARK: - 508. Most Frequent Subtree Sum
    
    func testProblem508() {
        
        var sumCounts = [Int: Int]()
        
        var largestSumCount = 0
        var largestSumValues = Set<Int>()
        
        func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
            
            if root == nil {
                return []
            }
            
            func helper(_ root: TreeNode?) -> Int {
                
                guard let root = root else {
                    return 0
                }
                
                let sum = root.val + helper(root.left) + helper(root.right)
                
                if sumCounts[sum] == nil {
                    sumCounts[sum] = 0
                }
                
                sumCounts[sum]! += 1
                
                let newCount = sumCounts[sum]!
                
                if newCount > largestSumCount {
                    largestSumCount = newCount
                    largestSumValues = [sum]
                }
                else if newCount == largestSumCount {
                    largestSumValues.insert(sum)
                }
                
                return sum
            }
            
            helper(root)
            
            return Array(largestSumValues)
        }
    }
    
    // MARK: - 513. Find Bottom Left Tree Value
    
    func testProblem513() {
        
        var maxDepth = 0
        var value = 0
        
        func findBottomLeftValue(_ root: TreeNode?) -> Int {
            
            func helper(_ root: TreeNode?, depth: Int) {
                
                if root == nil {
                    return
                }
                
                if depth > maxDepth && root?.left == nil && root?.right == nil {
                    maxDepth = depth
                    value = root!.val
                    return
                }
                
                for node in [root?.left, root?.right] {
                    helper(node, depth: depth + 1)
                }
            }
            
            helper(root, depth: 1)
            
            return value
        }
    }
    
    // MARK: - 515. Find Largest Value in Each Tree Row
    
    func testProblem515() {
        
        func largestValues(_ root: TreeNode?) -> [Int] {
            
            var solution = [Int]()
            var nodes = [root]
            
            while !nodes.isEmpty {
                
                var largest: Int?
                
                for n in nodes {
                    
                    guard let node = n else {
                        continue
                    }
                    
                    if largest == nil || node.val > largest! {
                        largest = node.val
                    }
                }
                
                if let largest = largest {
                    solution.append(largest)
                }
                
                var newNodes = [TreeNode?]()
                for n in nodes {
                    if let left = n?.left {
                        newNodes.append(left)
                    }
                    if let right = n?.right {
                        newNodes.append(right)
                    }
                }
                
                nodes = newNodes
            }
            
            return solution
        }
    }
    
    // MARK: - 520. Detect Capital
    
    func testProblem520() {
        
        func detectCapitalUse(_ word: String) -> Bool {
            
            func isUpper(_ c: Character) -> Bool {
                let s = String(c)
                return s == s.uppercased()
            }
            
            let a = Array(word.characters)
            
            if a.count < 2 {
                return true
            }
            
            let upper0 = isUpper(a[0])
            let upper1 = isUpper(a[1])
            
            if !upper0 && upper1 {
                return false
            }
            
            let upper = upper0 && upper1
            
            for i in 1 ..< a.count {
                if isUpper(a[i]) != upper {
                    return false
                }
            }
            
            return true
        }
    }
    
    // MARK: - 521. Longest Uncommon Subsequence I
    
    func testProblem521() {
        
        func findLUSlength(_ a: String, _ b: String) -> Int {
            
            if a == b {
                return -1
            }
            
            let lenA = a.characters.count
            let lenB = b.characters.count
            
            return max(lenA, lenB)
        }
    }
    
    // MARK: - 526. Beautiful Arrangement
    
    func testProblem526() {
        
        func countArrangement(_ N: Int) -> Int {
            
            func helper(i: Int, used: Int) -> Int {
                
                if i > N {
                    return 1
                }
                
                var count = 0
                
                for j in 1 ... N {
                    
                    let bit = (0x1 << (j - 1))
                    
                    if used & bit == 0 {
                        
                        if j % i == 0 || i % j == 0 {
                            
                            let newUsed = used | bit
                            
                            count += helper(i: i + 1, used: newUsed)
                        }
                    }
                }
                
                return count
            }
            
            return helper(i: 1, used: 0x0)
        }
    }
    
    // MARK: - 530. Minimum Absolute Difference in BST
    
    func testProblem530() {
        
        var prev: Int?
        var minDiff = Int.max
        
        func getMinimumDifference(_ root: TreeNode?) -> Int {
            
            // Bottom
            
            guard let root = root else {
                return minDiff
            }
            
            // Left
            
            let _ = getMinimumDifference(root.left)
            
            // Root
            
            if let prev = prev {
                
                let diff = root.val - prev
                
                if diff < minDiff {
                    minDiff = diff
                }
            }
            
            prev = root.val
            
            // Right
            
            let _ = getMinimumDifference(root.right)
            
            // Return
            
            return minDiff
        }
    }
    
    // MARK: - 532. K-diff Pairs in an Array
    
    struct Pair: Hashable {
        
        var x: Int
        var y: Int
        
        init(_ a: Int, _ b: Int) {
            x = a
            y = b
        }
        
        public var hashValue: Int {
            return x.hashValue ^ y.hashValue
        }
        
        public static func == (l: Pair, r: Pair) -> Bool {
            return l.x == r.x && l.y == r.y
        }
    }
    
    func testProblem532() {
        
        func findPairs(_ nums: [Int], _ k: Int) -> Int {
            
            if k < 0 {
                return 0
            }
            
            var s = Set<Int>()
            
            var pairs = Set<Pair>()
            
            for n in nums {
                
                if s.contains(n) {
                    
                    if k == 0 {
                        pairs.insert(Pair(n, n))
                    }
                    
                    continue
                }
                
                let lo = n - k
                let hi = n + k
                
                if s.contains(lo) {
                    pairs.insert(Pair(lo, n))
                }
                
                if s.contains(hi) {
                    pairs.insert(Pair(n, hi))
                }
                
                s.insert(n)
            }
            
            return pairs.count
        }
    }
    
    // MARK: - 537. Complex Number Multiplication
    
    struct Complex: CustomStringConvertible {
        
        var real = 0
        var imaginary = 0
        
        init(real r: Int, imaginary i: Int) {
            
            real = r
            imaginary = i
        }
        
        init(_ s: String) {
            
            let strs = s.components(separatedBy: "+")
            
            let strR = strs[0]
            let strI = String(strs[1].characters.dropLast())
            
            real = Int(strR)!
            imaginary = Int(strI)!
        }
        
        var description: String {
            
            return String(real) + "+" + String(imaginary) + "i"
        }
        
        static func *(c1: Complex, c2: Complex) -> Complex {
            
            let r2 = c1.real * c2.real
            let i2 = c1.imaginary * c2.imaginary * -1
            
            let r = r2 + i2
            let i = c1.real * c2.imaginary + c1.imaginary * c2.real
            
            return Complex(real: r, imaginary: i)
        }
    }
    
    func testProblem537() {
        
        func complexNumberMultiply(_ a: String, _ b: String) -> String {
                
            let c1 = Complex(a)
            let c2 = Complex(b)
            
            let c = c1 * c2
            
            return c.description
        }
    }
    
    // MARK: - 540. Single Element in a Sorted Array
    
    func testProblem540() {
        
        func singleNonDuplicate(_ nums: [Int]) -> Int {
            
            var i = 0
            
            while i < nums.count {
                
                if i == nums.count - 1 {
                    return nums[i]
                }
                
                if nums[i] != nums[i + 1] {
                    return nums[i]
                }
                
                i += 2
            }
            
            return -1
        }
    }
    
    // MARK: - 541. Reverse String II
    
    func testProblem541() {
        
        func reverseStr(_ s: String, _ k: Int) -> String {
            
            if k < 2 {
                return s
            }
            
            var a = Array(s.characters)
            
            func reverse(_ first: Int, _ last: Int) {
                
                var f = first
                var l = last
                
                while f < l {
                    
                    let temp = a[f]
                    a[f] = a[l]
                    a[l] = temp
                    
                    f += 1
                    l -= 1
                }
            }
            
            var i = 0
            
            while i < a.count {
                
                var last = i + k - 1
                
                if last >= a.count {
                    last = a.count - 1
                }
                
                reverse(i, last)
                
                i += 2 * k
            }
            
            return String(a)
        }
    }
    
    // MARK: - 543. Diameter of Binary Tree
    
    func testProblem543() {
        
        func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
            
            func longestPath(_ root: TreeNode?) -> Int {
                
                guard let root = root else {
                    return 0
                }
                
                var leftLongest = 0
                var rightLongest = 0
                
                if let left = root.left {
                    leftLongest = 1 + longestPath(left)
                }
                
                if let right = root.right {
                    rightLongest = 1 + longestPath(right)
                }
                
                return max(leftLongest, rightLongest)
            }
            
            guard let root = root else {
                return 0
            }
            
            var diameter = 0
            
            if let left = root.left {
                diameter += 1 + longestPath(left)
            }
            
            if let right = root.right {
                diameter += 1 + longestPath(right)
            }
            
            let leftDiameter = diameterOfBinaryTree(root.left)
            let rightDiameter = diameterOfBinaryTree(root.right)
            
            let maxChildDiameter = max(leftDiameter, rightDiameter)
            
            let maxDiameter = max(diameter, maxChildDiameter)
            
            return maxDiameter
        }
    }
    
    // MARK: - 551. Student Attendance Record I
    
    func testProblem551() {
        
        func checkRecord(_ s: String) -> Bool {
            
            var absentCount = 0
            var continuousLateCount = 0
            
            for d in s.characters {
                
                if d == "A" {
                    absentCount += 1
                }
                
                if absentCount > 1 {
                    return false
                }
                
                if d == "L" {
                    continuousLateCount += 1
                } else {
                    continuousLateCount = 0
                }
                
                if continuousLateCount > 2 {
                    return false
                }
            }
            
            return true
        }
    }
    
    // MARK: - 553. Optimal Division
    
    func testProblem553() {
        
        func optimalDivision(_ nums: [Int]) -> String {
            
            // By definition, the answer is always in the form: a/(b/c/d/.../z)
            // Parenthesis are skipped for two or less numbers.
            
            var solution = ""
            
            let needsParethesis = nums.count > 2
            
            for i in 0 ..< nums.count {
                
                if i == 1 && needsParethesis {
                    solution += "("
                }
                
                solution += String(nums[i])
                
                if i < nums.count - 1 {
                    solution += "/"
                }
            }
            
            if needsParethesis {
                solution += ")"
            }
            
            return solution
        }
    }
    
    // MARK: - 557. Reverse Words in a String III
    
    func testProblem557() {
        
        func reverseWords(_ s: String) -> String {
            
            var a = Array(s.characters)
            
            func reverse(first: Int, last: Int) {
                
                var f = first
                var l = last
                
                while f < l {
                    
                    let temp = a[f]
                    a[f] = a[l]
                    a[l] = temp
                    
                    f += 1
                    l -= 1
                }
            }
            
            var i = 0
            
            while i < a.count {
                
                var j = i
                
                while j < a.count && a[j] != " " {
                    j += 1
                }
                
                j -= 1
                
                reverse(first: i, last: j)
                
                i = j + 2
            }
            
            return String(a)
        }
    }
    
    // MARK: - 561. Array Partition I
    
    func testProblem561() {
        
        func arrayPairSum(_ nums: [Int]) -> Int {
            
            let sorted = nums.sorted()
            
            var sum = 0
            
            var i = 0
            
            while i < sorted.count {
                
                sum += sorted[i]
                
                i += 2
            }
            
            return sum
        }
    }
    
    // MARK: - 563. Binary Tree Tilt
    
    func testProblem563() {
        
        func findTilt(_ root: TreeNode?) -> Int {
            
            func helper(_ root: TreeNode?) -> (treeTilt: Int, nodeTilt: Int, sum: Int) {
                
                var solution = (treeTilt: 0, nodeTilt: 0, sum: 0)
                
                guard let root = root else {
                    return solution
                }
                
                let leftSolution = helper(root.left)
                let rightSolution = helper(root.right)
                
                let sum = root.val + leftSolution.sum + rightSolution.sum
                
                let nodeTilt = abs(leftSolution.sum - rightSolution.sum)
                
                let treeTilt = nodeTilt + leftSolution.treeTilt + rightSolution.treeTilt
                
                solution.treeTilt = treeTilt
                solution.nodeTilt = nodeTilt
                solution.sum = sum
                
                return solution
            }
            
            let (treeTilt, _, _) = helper(root)
            
            return treeTilt
        }
        
        XCTAssert(findTilt(TreeNode(values: 1,2,3,4,nil,5)) == 11)
    }
    
    // MARK: - 566. Reshape the Matrix
    
    func testProblem566() {
        
        func matrixReshape(_ nums: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
            
            let rows = nums.count
            let cols = nums[0].count
            
            if (r * c) != (rows * cols) {
                return nums
            }
            
            let newRow = [Int](repeating: 0, count: c)
            var newMatrix = [[Int]](repeating: newRow, count: r)
            
            for i in 0 ..< r * c {
                
                let oldR = i / cols
                let oldC = i % cols
                
                let newR = i / c
                let newC = i % c
                
                newMatrix[newR][newC] = nums[oldR][oldC]
            }
            
            return newMatrix
        }
    }
    
    // MARK: - 572. Subtree of Another Tree
    
    func testProblem572() {
        
        func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
            
            func helper(_ s: TreeNode?, _ t: TreeNode?, started: Bool) -> Bool {
                
                guard let root = s, let match = t else {
                    return s == nil && t == nil
                }
                
                var rootMatches = false
                
                if root.val == match.val {
                    
                    rootMatches =
                        helper(root.left, match.left, started: true) &&
                        helper(root.right, match.right, started: true)
                }
                
                var childrenMatch = false
                
                if !started {
                    
                    childrenMatch =
                        helper(root.left, match, started: false) ||
                        helper(root.right, match, started: false)
                }
                
                return rootMatches || childrenMatch
            }
            
            return helper(s, t, started: false)
        }
    }
    
    // MARK: - 575. Distribute Candies
    
    func testProblem575() {
        
        func distributeCandies(_ candies: [Int]) -> Int {
            
            let candyTypeCount = Set(candies).count
            
            return min(candyTypeCount, candies.count / 2)
        }
        
        XCTAssert(distributeCandies([1,1,2,2,3,3]) == 3)
    }
    
    // MARK: - 581. Shortest Unsorted Continuous Subarray
    
    func testProblem581() {
        
        func findUnsortedSubarray(_ nums: [Int]) -> Int {
            
            let sorted = nums.sorted()
            var first: Int?
            var last: Int?
            
            for i in 0 ..< nums.count {
                
                if nums[i] != sorted[i] {
                    
                    if first == nil {
                        first = i
                    }
                    
                    last = i
                }
            }
            
            if first == nil {
                return 0
            }
            
            if first == last {
                return 0
            }
            
            return last! - first! + 1
        }
    }
    
    // MARK: - 594. Longest Harmonious Subsequence
    
    func testProblem594() {
        
        func findLHS(_ nums: [Int]) -> Int {
            
            func harmonious(_ a: Int, _ b: Int) -> Bool {
                return abs(a - b) == 1
            }
            
            if nums.count < 2 {
                return 0
            }
            
            var counts = [Int: Int]()
            
            for n in nums {
                counts[n] = (counts[n] ?? 0) + 1
            }
            
            var maxCount = 0
            
            var prevN: Int!
            var prevCount: Int!
            
            for n in nums.sorted() {
                
                let count = counts[n]!
                
                if prevN != nil && harmonious(prevN, n) {
                    
                    let totalCount = prevCount + count
                    maxCount = max(totalCount, maxCount)
                }
                
                prevN = n
                prevCount = count
            }
            
            return maxCount
        }
    }
    
    // MARK: - 598. Range Addition II
    
    func testProblem598() {
        
        func maxCount(_ m: Int, _ n: Int, _ ops: [[Int]]) -> Int {
            
            var x = m
            var y = n
            
            for op in ops {
                
                x = min(x, op[0])
                y = min(y, op[1])
            }
            
            return x * y
        }
    }
    
    // MARK: - 599. Minimum Index Sum of Two Lists
    
    func testProblem599() {
        
        func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
            
            let len1 = list1.count
            let len2 = list2.count
            
            let maxLen = max(len1, len2)
            
            var table = [String: Int]()
            
            var currentMin = Int.max
            var currentMinNames = [String]()
            
            for index in 0 ..< maxLen {
                
                var currentNames = [String]()
                
                if index < len1 {
                    currentNames.append(list1[index])
                }
                
                if index < len2 {
                    currentNames.append(list2[index])
                }
                
                for name in currentNames {
                    
                    if table[name] == nil {
                        
                        table[name] = index
                        
                    } else {
                        
                        let newValue = table[name]! + index
                        table[name] = newValue
                        
                        if newValue == currentMin {
                            
                            currentMinNames.append(name)
                            
                        } else if newValue < currentMin {
                            
                            currentMin = newValue
                            currentMinNames = [name]
                        }
                    }
                }
            }
            
            return currentMinNames
        }
    }
    
    // MARK: - 605. Can Place Flowers
    
    func testProblem605() {
        
        func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
            
            var spaceCount = 1
            var placedCount = 0
            
            func attemptPlacing() {
                
                if spaceCount > 2 {
                    placedCount += (spaceCount - 1) / 2
                }
                
                spaceCount = 0
            }
            
            for plot in flowerbed {
                
                if plot == 0 {
                    spaceCount += 1
                    continue
                }
                
                attemptPlacing()
                
                if placedCount >= n {
                    return true
                }
            }
            
            spaceCount += 1
            
            attemptPlacing()
            
            return placedCount >= n
        }
    }
    
    // MARK: - 606. Construct String from Binary Tree
    
    func testProblem606() {
        
        func tree2str(_ t: TreeNode?) -> String {
            
            guard let root = t else {
                return ""
            }
            
            var str = String(root.val)
            
            if root.left == nil && root.right == nil {
                return str
            }
            
            let leftStr = tree2str(root.left)
            str += "(" + leftStr + ")"
            
            if root.right != nil {
                
                let rightStr = tree2str(root.right)
                str += "(" + rightStr + ")"
            }
            
            return str
        }
    }
    
    // MARK: - 609. Find Duplicate File in System
    
    func testProblem609() {
        
        func findDuplicate(_ paths: [String]) -> [[String]] {
            
            let parensCharset = CharacterSet(charactersIn:"()")
            
            var table = [String: [String]]()
            
            for path in paths {
                
                let strings = path.components(separatedBy: " ")
                
                let dir = strings[0]
                
                for i in 1 ..< strings.count {
                    
                    let substrings = strings[i].components(separatedBy: parensCharset)
                    
                    let filename = substrings[0]
                    let contents = substrings[1]
                    
                    let fullpath = dir + "/" + filename
                    
                    if table[contents] == nil {
                        table[contents] = []
                    }
                    
                    table[contents]!.append(fullpath)
                }
            }
            
            var solution = [[String]]()
            
            for array in table.values {
                if array.count > 1 {
                    solution.append(array)
                }
            }
            
            return solution
        }
    }
    
    // MARK: - 617. Merge Two Binary Trees
    
    func testProblem617() {
        
        func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
            
            if t1 == nil && t2 == nil {
                return nil
            }
            
            if t1 == nil {
                return t2
            }
            
            if t2 == nil {
                return t1
            }
            
            let newValue = t1!.val + t2!.val
            
            let newNode = TreeNode(newValue)
            
            newNode.left = mergeTrees(t1!.left, t2!.left)
            newNode.right = mergeTrees(t1!.right, t2!.right)
            
            return newNode
        }
    }
}
