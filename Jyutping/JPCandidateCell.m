//
//  JPCandidateCell.m
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import "JPCandidateCell.h"

@implementation JPCandidateCell

@synthesize controller;

- (void)setController:(JPViewController *)newController
{
    controller = newController;
    [self.label addTarget:self.controller action:@selector(candidateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.label = [[UIButton alloc] initWithFrame:self.bounds];
//        NSLog(@"%f", self.bounds.size.height);
        self.autoresizesSubviews = YES;
        self.label.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//        self.label.font = [UIFont boldSystemFontOfSize:21];
//        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.label.backgroundColor = [UIColor grayColor];
        
        [self addSubview:self.label];
        
        [self setText:@""];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setText:(NSString *)text
{
    [self.label setTitle:text forState:UIControlStateNormal];
}

@end
