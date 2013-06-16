//
//  JPCandidateCell.h
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPViewController;

@interface JPCandidateCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *label;
@property (nonatomic, strong) JPViewController *controller;

- (void) setText:(NSString *)text;

@end
