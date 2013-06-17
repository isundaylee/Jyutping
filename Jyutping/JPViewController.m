//
//  JPViewController.m
//  Jyutping
//
//  Created by Jiahao Li on 6/15/13.
//  Copyright (c) 2013 Jiahao Li. All rights reserved.
//

#import "JPViewController.h"
#import "JPCandidateCell.h" 
#import "JPParser.h"

@interface JPViewController ()

@property (nonatomic, strong) JPParser *parser; 

@end

@implementation JPViewController

@synthesize textView;
@synthesize tokenField;
@synthesize token;
@synthesize candidatesView;
@synthesize candidates;
@synthesize inputAccessoryView;
@synthesize parser; 

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setCandidates:(NSArray *)newCandidates
{
    candidates = newCandidates; 
}

- (void)setToken:(NSString *)newToken
{
    token = newToken;
    [self refreshCandidates];
    self.tokenField.text = [[self.parser tokenize:self.token] componentsJoinedByString:@"'"];
}

- (void)setTokenField:(UITextField *)newTokenField
{
    tokenField = newTokenField; 
    self.tokenField.text = [[self.parser tokenize:self.token] componentsJoinedByString:@"'"];
}

- (void)setCandidatesView:(UICollectionView *)newCandidatesView
{
    candidatesView = newCandidatesView;
    self.candidatesView.delegate = self;
    self.candidatesView.dataSource = self; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.textView setDelegate:self];
    self.parser = [[JPParser alloc] init];
    self.token = @"si";
    self.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 70.0)];
    self.inputAccessoryView.backgroundColor = [UIColor grayColor];
    self.tokenField = [[UILabel alloc] initWithFrame:CGRectMake(10, 0.0, 300, 40.0)];
    self.tokenField.font = [UIFont boldSystemFontOfSize:15];
    self.tokenField.textColor = [UIColor whiteColor]; 
    self.tokenField.adjustsFontSizeToFitWidth = YES;
    self.tokenField.backgroundColor = [UIColor grayColor]; 
    self.candidatesView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 30.0, 320.0, 40.0) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.candidatesView registerClass:[JPCandidateCell class] forCellWithReuseIdentifier:@"cell"];
    self.candidatesView.backgroundColor = [UIColor grayColor];
    [self.inputAccessoryView addSubview:self.candidatesView];
    [self.inputAccessoryView addSubview:self.tokenField];
    self.textView.inputAccessoryView = self.inputAccessoryView;
    [self.textView becomeFirstResponder]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""]) {
        // Deleting
        if (self.token.length == 0) {
            return YES;
        } else {
            self.token = [self.token substringToIndex:self.token.length - 1];
            return NO;
        }
    } else {
        if (text.length == 1 && ([text isEqualToString:@"'"] || isalpha([text characterAtIndex:0]))) {
            self.token = [[self.token stringByAppendingString:text] lowercaseString];
            return NO;
        } else {
            return YES;
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.candidates count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JPCandidateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.controller = self;
    
    [cell setText:[self.candidates objectAtIndex:indexPath.row]];
    
    return cell; 
}

- (void)candidateButtonPressed:(id)sender
{
    UIButton *button = sender;
    NSString *candidate = [button titleForState:UIControlStateNormal];
    NSString *token = self.token;
    NSArray *tokens = [self.parser tokenize:token];
    int length = 0;
    
    for (int i=0; i<[candidate length]; i++)
        length += [[tokens objectAtIndex:i] length];
    
    for (int i=0; i<length; i++) {
        while (!isalpha([token characterAtIndex:0]))
            token = [token substringFromIndex:1];
        token = [token substringFromIndex:1];
    }
    
    while (([token length] > 0) && !isalpha([token characterAtIndex:0]))
        token = [token substringFromIndex:1];
    
    self.token = token;
    
    [self insertText:candidate];
}

- (void)insertText:(NSString *)text
{
    if (!self.textView.isFirstResponder) {
        [self.textView becomeFirstResponder];
    }
    
    [self.textView insertText:text];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([[self.candidates objectAtIndex:indexPath.row] sizeWithFont:[UIFont boldSystemFontOfSize:15]].width, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void) refreshCandidates
{
    self.candidates = [[self.parser parse:self.token] objectForKey:@"candidates"];
    
    [self.candidatesView reloadData]; 
}

@end
