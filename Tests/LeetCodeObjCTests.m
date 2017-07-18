//
//  LeetCodeObjCTests.m
//  Tests
//
//  Created by Colin Caufield on 2017-07-14.
//  Copyright © 2017 Secret Geometry, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LeetCodeObjCTests : XCTestCase
@end

@implementation LeetCodeObjCTests

// MARK: - 1. Two Sum ✓

- (void) testProblem1
{
    NSArray* nums = @[@2, @7, @11, @15];
    int target = 13;
    
    NSArray* indices = [self twoSumOf:nums target:target];
    
    NSLog(@"Two Sum of %@ for %d is %@", nums, target, indices);
}

- (NSArray*) twoSumOf:(NSArray*)nums target:(int)target
{
    NSMutableDictionary* indexForNum = [NSMutableDictionary dictionary];
    
    for (int index = 0; index < nums.count; index++) {
        
        int num = [nums[index] intValue];
        
        int otherNum = target - num;
        
        NSNumber* otherIndexObj = indexForNum[@(otherNum)];
        
        if (otherIndexObj != nil)
        {
            int otherIndex = otherIndexObj.intValue;
            return [NSArray arrayWithObjects: @(otherIndex), @(index), nil];
        }
        
        indexForNum[@(num)] = @(index);
    }
    
    return [NSArray mutableCopy];
}

// MARK: - 238. Product of Array Except Self

- (void) testProblem238
{
    NSArray* input = @[@0, @1];
    NSArray* output = [self productExceptSelf:input];
    NSLog(@"%@", output);
}

- (NSArray*) productExceptSelf:(NSArray*)nums
{
    int nonZeroProduct = 1;
    int zeroCount = 1;
    
    for (NSNumber* n in nums)
    {
        if (n != 0)
            nonZeroProduct *= n.intValue;
        else
            zeroCount += 1;
    }
    
    if (zeroCount >= 2)
    {
        NSMutableArray* array = [NSArray mutableCopy];
        for (int i = 0; i < nums.count; i++)
            [array addObject:@(0)];
            
        return array;
    }
    
    NSMutableArray* solution = [NSMutableArray array];
    
    for (NSNumber* num in nums)
    {
        int n = num.intValue;
        
        int value = nonZeroProduct;
        
        if (n != 0)
        {
            if (zeroCount == 1)
                value = 0;
            else
                value /= n;
        }
        
        [solution addObject:@(value)];
    }
    
    return solution;
}

@end
