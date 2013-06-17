//
//  JPTokenizer.m
//  Jyutping
//
//  Created by Jiahao Li on 6/16/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import "JPTokenizer.h"

@interface JPTokenizer ()

@property (nonatomic, strong) NSMutableArray *tokens;

@end

@implementation JPTokenizer

@synthesize tokens; 

- (id)init
{
    self = [super init];
    
    if (self) {
        tokens = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadTokens:(NSArray *)newTokens
{
    [self.tokens addObjectsFromArray:newTokens];
}

- (NSArray *)tokenize:(NSString *)string
{
    if ([string rangeOfString:@"'"].location != NSNotFound) {
        int index = [string rangeOfString:@"'"].location; 
        NSMutableArray *p1 = [NSMutableArray arrayWithArray:[self tokenize:[string substringToIndex:index]]];
        NSMutableArray *p2 = [NSMutableArray arrayWithArray:[self tokenize:[string substringFromIndex:index + 1]]];
        if ([[p1 lastObject] isEqualToString:@""])
            [p1 removeLastObject];
        [p1 addObjectsFromArray:p2];
        return p1; 
    }
    
    if ([string length] == 0)
        return [NSArray arrayWithObject:@""];
    
    int bestScore = 100000000;
    NSArray *bestChoice;
    
    for (int i=1; i<=[string length]; i++) {
        NSString *current = [string substringToIndex:i];
        if ([self.tokens indexOfObject:current] != NSNotFound) {
            NSMutableArray *partial = [NSMutableArray arrayWithObject:current];
            [partial addObjectsFromArray:[self tokenize:[string substringFromIndex:i]]];
            int score = [[partial lastObject] length] * 100 - [[partial objectAtIndex:0] length];
            if (score < bestScore) {
                bestScore = score;
                bestChoice = partial;
            }
        }
    }
    
    if ([string length] * 100 < bestScore) {
        bestScore = [string length] * 100;
        bestChoice = [NSArray arrayWithObject:string];
    }
    
    return bestChoice;
}

@end
