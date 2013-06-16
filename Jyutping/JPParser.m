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
@property (strong, nonatomic) NSMutableDictionary *weights; 

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
    self.weights = [NSMutableDictionary dictionary]; 
    
    for (int i=0; i<[lines count]; i++) {
        NSArray *parts = [[lines objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([parts count] < 2)
            continue;
        if (![self.dict objectForKey:[parts objectAtIndex:1]])
            [self.dict setObject:[NSMutableArray array] forKey:[parts objectAtIndex:1]];
        [[self.dict objectForKey:[parts objectAtIndex:1]] addObject:[parts objectAtIndex:0]];
        if ([parts count] >= 3) {
            [self.dict setObject:[NSNumber numberWithInt:[[parts objectAtIndex:2] integerValue]] forKey:[parts objectAtIndex:0]];
            NSLog(@"%@ %@", [parts objectAtIndex:0], [parts objectAtIndex:2]);
        }
        else
            [self.dict setObject:[NSNumber numberWithInt:100] forKey:[parts objectAtIndex:0]];
    }
    
    NSLog(@"%@", [lines objectAtIndex:0]);
}

- (int) weightOfCandidate:(NSString *)candidate
{
    if ([self.weights objectForKey:candidate])
        return [[self.weights objectForKey:candidate] intValue];
    else
        return 0;
}

- (NSArray *)sortByWeight:(NSArray *)candidates
{
    return [candidates sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int w1 = [self weightOfCandidate:(NSString *)obj1];
        int w2 = [self weightOfCandidate:(NSString *)obj2];
        return [[NSNumber numberWithInt:w1] compare:[NSNumber numberWithInt:w2]];
    }];
}

- (NSDictionary *)parse:(NSString *)token
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    [result setObject:[self tokenize:token]forKey:@"tokens"];
    if ([self.dict objectForKey:token])
        [result setObject:[self sortByWeight: [self.dict objectForKey:token]] forKey:@"candidates"];
    else
        [result setObject:[NSMutableArray array] forKey:@"candidates"] ;
    
    return result;
}

- (NSArray *)tokenize:(NSString *)string
{
    return [NSArray arrayWithObject:string];
}

@end
