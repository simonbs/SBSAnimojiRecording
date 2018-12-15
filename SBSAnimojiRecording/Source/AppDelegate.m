//
//  AppDelegate.m
//  SBSAnimojiRecording
//
//  Created by Simon Støvring on 15/12/2018.
//  Copyright © 2018 SimonBS. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@import Darwin;

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MainViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
