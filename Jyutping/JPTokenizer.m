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

- (void)loadTokens:(NSArray *)tokens
{
    [self.tokens addObjectsFromArray:tokens];
}

- (NSArray *)tokenize:(NSString *)string
{
    return [NSArray arrayWithObject:string];
}

@end
