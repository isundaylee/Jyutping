//
//  JPParser.m
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import "JPParser.h"

@implementation JPParser 

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
    
    [result setObject:candidates forKey:@"candidates"];
    
    return result;
}

@end
