//
//  MainViewController.m
//  SBSAnimojiRecording
//
//  Created by Simon Støvring on 16/12/2018.
//  Copyright © 2018 SimonBS. All rights reserved.
//

#import "MainViewController.h"
#import "CameraViewController.h"
#import "RecordButtonViewController.h"
@import ReplayKit;

@interface MainViewController () <RPPreviewViewControllerDelegate>
@property (nonatomic, strong) CameraViewController *cameraViewController;
@property (nonatomic, strong) RecordButtonViewController *recordButtonViewController;
@property (nonatomic, strong) UIWindow *recordWindow;
@end

@implementation MainViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCamera];
    [self setupRecordWindow];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutRecordWindow];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self layoutRecordWindow];
}

- (void)setupCamera {
    self.cameraViewController = [[CameraViewController alloc] init];
    self.cameraViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.cameraViewController];
    [self.view addSubview:self.cameraViewController.view];
    [self.cameraViewController didMoveToParentViewController:self];
    [[self.cameraViewController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.cameraViewController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.cameraViewController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[self.cameraViewController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}

- (void)setupRecordWindow {
    self.recordButtonViewController = [[RecordButtonViewController alloc] init];
    self.recordWindow = [[UIWindow alloc] init];
    self.recordWindow.windowLevel = UIWindowLevelAlert;
    self.recordWindow.backgroundColor = [UIColor clearColor];
    self.recordWindow.rootViewController = self.recordButtonViewController;
    [self.recordWindow setHidden:NO];
    [self.recordButtonViewController.recordButton addTarget:self action:@selector(toggleRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.recordButtonViewController.recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [self layoutRecordWindow];
}

- (void)layoutRecordWindow {
    CGSize windowSize = CGSizeMake(72, 72);
    CGFloat xPos = (self.view.bounds.size.width - windowSize.width) / 2;
    CGFloat yPos = (self.view.bounds.size.height - self.view.safeAreaInsets.bottom - windowSize.height - 40);
    self.recordWindow.frame = CGRectMake(xPos, yPos, windowSize.width, windowSize.height);
}

- (void)toggleRecording {
    if ([RPScreenRecorder sharedRecorder].isRecording) {
        [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3 animations:^{
                    self.recordWindow.alpha = 0;
                }];
                previewViewController.previewControllerDelegate = self;
                [self.recordButtonViewController.recordButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
                [self presentViewController:previewViewController animated:YES completion:nil];
            });
        }];
    } else {
        [[RPScreenRecorder sharedRecorder] setMicrophoneEnabled:YES];
        [[RPScreenRecorder sharedRecorder] startRecordingWithHandler:^(NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    [self.recordButtonViewController.recordButton setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                }
            });
        }];
    }
}

- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    [previewController dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.recordWindow.alpha = 1;
        }];
    }];
}

@end
