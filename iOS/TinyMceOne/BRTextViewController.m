//
//  BRTextViewController.m
//  TinyMceOne
//
//  Created by Daniel Norton on 10/15/13.
//  Copyright (c) 2013 Daniel Norton. All rights reserved.
//

#import "BRTextViewController.h"

@interface BRTextViewController()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BRTextViewController


#pragma mark -
#pragma mark UIViewController
- (void)viewDidLoad {
	[super viewDidLoad];

	NSAssert(_textView, @"Where is the textView?");
	
	[_textView setText:_text];
}


#pragma mark -
#pragma mark BRTextViewController
- (void)setText:(NSString *)text {
	
	_text = text;
	[_textView setText:text];
}

@end
