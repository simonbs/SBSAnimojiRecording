//
//  ViewController.m
//  SBSAnimojiRecording
//
//  Created by Simon Støvring on 15/12/2018.
//  Copyright © 2018 SimonBS. All rights reserved.
//

#import "CameraViewController.h"
#import "AVTPuppetView.h"
#import "AVTPuppet.h"
@import ARKit;
@import ReplayKit;

@interface CameraViewController () <ARSCNViewDelegate, ARSessionDelegate>
@property (nonatomic, strong) AVTPuppetView *puppetView;
@property (nonatomic, strong) ARSCNView *sceneView;
@property (nonatomic, strong) SCNNode *puppetNode;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupPuppetViewWithPuppetNamed:@"koala"];
    [self setupSceneView];
    [self setupPuppetNode];
}

- (void)setupPuppetViewWithPuppetNamed:(NSString*)puppetName  {
    AVTPuppet *puppet = [AVTPuppet puppetNamed:puppetName options:nil];
    self.puppetView = [[AVTPuppetView alloc] init];
    [self.puppetView setAvatarInstance:(AVTAvatarInstance*)puppet];
    [self.view addSubview:self.puppetView];
}

- (void)setupSceneView {
    self.sceneView = [[ARSCNView alloc] init];
    self.sceneView.session = [self.puppetView arSession];
    self.sceneView.translatesAutoresizingMaskIntoConstraints = NO;
    self.sceneView.delegate = self;
    [self.view addSubview:self.sceneView];
    [[self.sceneView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.sceneView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.sceneView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[self.sceneView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}

- (void)setupPuppetNode {
    CGFloat scale = 0.21;
    CGFloat verticalOffset = -0.09;
    SCNNode *innerNode = [self.puppetView.scene.rootNode clone];
    SCNNode *skeletonNode = [innerNode childNodeWithName:@"skeleton" recursively:YES];
    self.puppetNode = [[SCNNode alloc] init];
    [self.puppetNode addChildNode:innerNode];
    self.puppetNode.position = SCNVector3Make(0, verticalOffset, 0);
    self.puppetNode.scale = SCNVector3Make(scale, scale, scale);
    innerNode.scale = SCNVector3Make(scale, scale, scale);
    skeletonNode.scale = SCNVector3Make(scale, scale, scale);
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARFaceAnchor class]]) {
        if ([[node childNodes] count] == 0) {
            [node addChildNode:self.puppetNode];
        }
    }
}

@end

