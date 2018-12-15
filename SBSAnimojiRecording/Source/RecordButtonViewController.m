//
//  RecordButtonViewController.m
//  SBSAnimojiRecording
//
//  Created by Simon Støvring on 16/12/2018.
//  Copyright © 2018 SimonBS. All rights reserved.
//

#import "RecordButtonViewController.h"

@interface RecordButtonViewController ()
@property (nonatomic, strong) UIButton *recordButton;
@end

@implementation RecordButtonViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.recordButton];
    [[self.recordButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.recordButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.recordButton.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[self.recordButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}

@end
