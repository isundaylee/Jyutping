//
//  JPViewController.h
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPViewController : UIViewController <UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *tokenField;
@property (strong, nonatomic) IBOutlet UICollectionView *candidatesView;
@property (nonatomic, strong) UIView *inputAccessoryView;

@property (readonly, strong, nonatomic) NSArray *candidates;

@property (readonly) NSString *token;

@property (nonatomic, strong) UIButton *prevButton;
@property (nonatomic, strong) UIButton *nextButton;

- (void) candidateButtonPressed:(id)sender;
- (void) insertText:(NSString *)text;

@end
