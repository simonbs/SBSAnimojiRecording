//
//  UIDevice+ModelIdentifier.m
//  SBSAnimojiRecording
//
//  Created by Simon Støvring on 03/01/2019.
//  Copyright © 2019 SimonBS. All rights reserved.
//

#import "UIDevice+ModelIdentifier.h"
#include <sys/sysctl.h>

@implementation UIDevice (ModelIdentifier)
+ (NSString*)sbs_modelIdentifier {
    char* typeSpecifier = "hw.machine";
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    return results;
}
@end
