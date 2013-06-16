//
//  JPParser.m
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import "JPParser.h"

@interface JPParser ()

@property (strong, nonatomic) NSMutableDictionary *dict; 

@end

@implementation JPParser

@synthesize dict;

- (id)init
{
    self = [super init];
    
    if (self) {
        [self loadDictionary];
    }
    
    return self;
}

- (void) loadDictionary
{
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dict" ofType:@"yaml"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    
    self.dict = [NSMutableDictionary dictionary];
    
    for (int i=0; i<[lines count]; i++) {
        NSArray *parts = [[lines objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([parts count] < 2)
            continue;
        if (![self.dict objectForKey:[parts objectAtIndex:1]])
            [self.dict setObject:[NSMutableArray array] forKey:[parts objectAtIndex:1]];
        [[self.dict objectForKey:[parts objectAtIndex:1]] addObject:[parts objectAtIndex:0]];
    }
    
    NSLog(@"%@", [lines objectAtIndex:0]);
}

- (NSDictionary *)parse:(NSString *)token
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableArray *candidates = [NSMutableArray array];
    
    for (int i=0; i<token.length; i++) {
        NSString *str = @"時日無多";
        if (i == 0)
            str = @"點解";
        else if (i == 1)
            str = @"什麼";
        else if (i == 2)
            str = @"陳奕迅";
        else if (i <= 4)
            str = @"親";
        [candidates addObject:str];
    }
    
    [result setObject:[self tokenize:token]forKey:@"tokens"];
    if ([self.dict objectForKey:token])
        [result setObject:[self.dict objectForKey:token] forKey:@"candidates"];
    else
        [result setObject:[NSMutableArray array] forKey:@"candidates"] ;
    
    return result;
}

- (NSArray *)tokenize:(NSString *)string
{
    return [NSArray arrayWithObject:string];
}

@end
