/* Generated by RuntimeBrowser
   Image: /System/Library/PrivateFrameworks/AvatarKit.framework/AvatarKit
 */

@import Foundation;
@import ARKit;
#import "AVTAvatarView.h"

@interface AVTPuppetView: AVTAvatarView
@property (getter=isPreviewing, nonatomic, readonly) bool previewing;
@property (getter=isRecording, nonatomic, readonly) bool recording;
- (void)startPreviewing;
- (void)startRecording;
- (void)stopPreviewing;
- (void)stopRecording;
- (ARSession*)arSession;
@end
