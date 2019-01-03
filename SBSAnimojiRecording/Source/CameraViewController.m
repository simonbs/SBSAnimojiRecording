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
#import "UIDevice+ModelIdentifier.h"
@import ARKit;
@import ReplayKit;

@interface CameraViewController () <ARSCNViewDelegate, ARSessionDelegate>
@property (nonatomic, strong) AVTPuppetView *puppetView;
@property (nonatomic, strong) ARSCNView *sceneView;
@property (nonatomic, strong) SCNNode *puppetNode;
@property (nonatomic, strong) UIView *faceTrackingView;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupPuppetViewWithPuppetNamed:@"monkey"];
    [self setupSceneView];
    [self setupPuppetNode];
    [self setupFaceTrackingView];
}

- (void)setupPuppetViewWithPuppetNamed:(NSString*)puppetName {
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
    CGFloat scale;
    CGFloat verticalOffset;
    SCNNode *innerNode;
    NSString *modelIdentifier = [UIDevice sbs_modelIdentifier];
    if ([modelIdentifier isEqualToString:@"iPhone10,3"] || [modelIdentifier isEqualToString:@"iPhone10,6"]) {
        // iPhone X
        scale = 0.21;
        verticalOffset = -0.09;
        innerNode = [self.puppetView.scene.rootNode clone];
    } else {
        // Assume newer than iPhone X.
        scale = 0.225;
        verticalOffset = -0.121;
        innerNode = self.puppetView.scene.rootNode;
    }
    SCNNode *skeletonNode = [innerNode childNodeWithName:@"skeleton" recursively:YES];
    self.puppetNode = [[SCNNode alloc] init];
    [self.puppetNode addChildNode:innerNode];
    self.puppetNode.position = SCNVector3Make(0, verticalOffset, 0);
    self.puppetNode.scale = SCNVector3Make(scale, scale, scale);
    innerNode.scale = SCNVector3Make(scale, scale, scale);
    skeletonNode.scale = SCNVector3Make(scale, scale, scale);
}

- (void)setupFaceTrackingView {
    self.faceTrackingView = [[UIView alloc] init];
    self.faceTrackingView.layer.borderWidth = 4;
    self.faceTrackingView.layer.borderColor = [[UIColor greenColor] CGColor];
    [self.view addSubview:self.faceTrackingView];
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARFaceAnchor class]]) {
        if ([[node childNodes] count] == 0) {
            [node addChildNode:self.puppetNode];
        }
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARFaceAnchor class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            SCNVector3 projectedPosition = [self.sceneView projectPoint:node.position];
            CGSize viewSize = CGSizeMake(50, 50);
            self.faceTrackingView.frame = CGRectMake(projectedPosition.x - viewSize.width / 2,
                                                     projectedPosition.y - viewSize.height / 2,
                                                     viewSize.width,
                                                     viewSize.height);
        });
    }
}

@end

