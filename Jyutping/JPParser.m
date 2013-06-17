//
//  JPParser.m
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import "JPParser.h"
#import "JPTokenizer.h"

@interface JPParser ()

@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableDictionary *weights;

@property (strong, nonatomic) JPTokenizer *tokenizer;

@end

@implementation JPParser

@synthesize dict;
@synthesize weights;
@synthesize tokenizer; 

- (id)init
{
    self = [super init];
    
    if (self) {
        [self loadDictionary];
        self.tokenizer = [[JPTokenizer alloc] init];
        [self.tokenizer loadTokens:[self.dict allKeys]];
    }
    
    return self;
}

- (void) loadDictionary
{
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dict" ofType:@"dat"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    
    NSLog(@"%@", [[NSBundle mainBundle] pathForResource:@"dict" ofType:@"yaml"]); 
    
    self.dict = [NSMutableDictionary dictionary];
    self.weights = [NSMutableDictionary dictionary]; 
    
    for (int i=0; i<[lines count]; i++) {
        NSArray *parts = [[lines objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([parts count] < 2)
            continue;
//        NSLog(@"%@", [parts objectAtIndex:1]);
        if ([[parts objectAtIndex:1] isEqualToString:@""])
            NSLog(@"%@", [parts objectAtIndex:0]);
        if (![self.dict objectForKey:[parts objectAtIndex:1]])
            [self.dict setObject:[NSMutableArray array] forKey:[parts objectAtIndex:1]];
        [[self.dict objectForKey:[parts objectAtIndex:1]] addObject:[parts objectAtIndex:0]];
        if ([parts count] >= 3) {
            [self.weights setObject:[NSNumber numberWithInt:[[parts objectAtIndex:2] integerValue]] forKey:[parts objectAtIndex:0]];
//            NSLog(@"%@ %@", [parts objectAtIndex:0], [parts objectAtIndex:2]);
        }
        else
            [self.weights setObject:[NSNumber numberWithInt:100] forKey:[parts objectAtIndex:0]];
    }
    
//    NSLog(@"%@", [lines objectAtIndex:0]);
}

- (int) weightOfCandidate:(NSString *)candidate
{
    if ([candidate isEqualToString:@"鍉"])
        NSLog(@"%d", [[self.weights objectForKey:candidate] intValue]); 
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
        return [[NSNumber numberWithInt:w2] compare:[NSNumber numberWithInt:w1]];
    }];
}

- (NSDictionary *)parse:(NSString *)token
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    [result setObject:[self tokenize:token] forKey:@"tokens"];
    if ([self.dict objectForKey:token])
        [result setObject:[self sortByWeight: [self.dict objectForKey:token]] forKey:@"candidates"];
    else
        [result setObject:[NSMutableArray array] forKey:@"candidates"] ;
    
    return result;
}

- (NSArray *)tokenize:(NSString *)string {
    return [self.tokenizer tokenize:string];
}

@end
