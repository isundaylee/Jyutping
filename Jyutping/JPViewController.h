//
//  JPViewController.h
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPViewController : UIViewController <UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *tokenField;
@property (weak, nonatomic) IBOutlet UICollectionView *candidatesView;
@property (nonatomic, strong) UIView *inputAccessoryView;

@property (readonly, strong, nonatomic) NSArray *candidates;

@property (readonly) NSString *token;

- (void) candidateButtonPressed:(id)sender;
- (void) insertText:(NSString *)text;

@end
