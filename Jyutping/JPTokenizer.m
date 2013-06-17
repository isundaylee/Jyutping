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
    if ([string length] == 0)
        return [NSArray array];
    
    for (int i=1; i<=[string length]; i++) {
        NSString *current = [string substringToIndex:i];
        NSLog(@"%@", [self.tokens objectAtIndex:0]);
        if ([self.tokens indexOfObject:current] != NSNotFound) {
            NSMutableArray *partial = [NSMutableArray arrayWithObject:current];
            [partial addObjectsFromArray:[self tokenize:[string substringFromIndex:i]]];
            return partial;
        }
    }
    
    return [NSArray arrayWithObject:string];
}

@end
