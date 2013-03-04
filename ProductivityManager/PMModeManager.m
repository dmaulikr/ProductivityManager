//
//  PMModeManager.m
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import "PMModeManager.h"

static PMModeManager *_sharedModeManager;

@interface PMModeManager()

@property (retain) NSTimer *timer;

@end

@implementation PMModeManager

@synthesize inProMode;

+ (PMModeManager *)sharedModeManager
{
    if (!_sharedModeManager) _sharedModeManager = [[self alloc] init];
    return _sharedModeManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        inProMode = NO;
    }
    return self;
}

- (void)toggleProMode
{
    inProMode = !inProMode;
    
    if (inProMode)
        //start timer
        NSLog(@"on");
    else
        //stop timer / set to nil
        NSLog(@"off");
}

@end
