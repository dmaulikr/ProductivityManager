//
//  PMModeManager.m
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import "PMModeManager.h"
#import "PMAppDelegate.h"

static PMModeManager *_sharedModeManager;

@interface PMModeManager()

@property (retain) NSTimer *timer;

@end

@implementation PMModeManager

@synthesize inProMode;
@synthesize timer;

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
    {
        timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(notify) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    else
    {
        [timer invalidate];
        timer = nil;
    }
}

- (void)notify
{
    NSUserNotification *notificaiton = [[NSUserNotification alloc] init];
    notificaiton.title = @"Are you being productive?";
    notificaiton.informativeText = @"You should consider getting back to work!";
    //notificaiton.actionButtonTitle = @"OK!";
    //notificaiton.otherButtonTitle = @"Later";
    notificaiton.subtitle = @"testing";
    //notificaiton.hasActionButton = YES;
    notificaiton.soundName = NSUserNotificationDefaultSoundName;    //use prefs
    
    if (![self isProductivityAppActive]) [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notificaiton];        
}


- (BOOL)isProductivityAppActive
{
    PMAppDelegate *delegate = [NSApplication sharedApplication].delegate;
    NSArray *proApps = [[PMProfileManager sharedProfileManager].profileData objectForKey:delegate.selectedProfile];
    for (NSString *str in proApps)
    {
        NSString *app = [PMUtils applicationNameForPath:str];
        if ([[[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSApplicationName"] isEqualToString:app])
            return YES;
    }
    return NO;
}


@end
