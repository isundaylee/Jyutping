//
//  JPTokenizer.h
//  Jyutping
//
//  Created by Jiahao Li on 6/16/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPTokenizer : NSObject

- (void) loadTokens:(NSDictionary *)tokens;
- (NSArray *) tokenize:(NSString *)string; 

@end
