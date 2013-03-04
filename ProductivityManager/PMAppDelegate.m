//
//  PMAppDelegate.m
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import "PMAppDelegate.h"

@implementation PMAppDelegate

@synthesize prefWindow;


- (void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    
    [statusItem setTitle:@"PM"];
    //[statusItem setImage:<#(NSImage *)#>];
    
    [statusItem setHighlightMode:YES];
}

- (IBAction)toggleProMode:(NSMenuItem *)sender
{
    if ([sender.title isEqualToString:@"Enter Productivity Mode"])
        sender.title = @"Leave Productivity Mode";
    else if ([sender.title isEqualToString:@"Leave Productivity Mode"])
        sender.title = @"Enter Productivity Mode";
    
    [[PMModeManager sharedModeManager] toggleProMode];
}

- (IBAction)showAbout:(NSMenuItem *)sender
{
    [[NSApplication sharedApplication] orderFrontStandardAboutPanel:self];
}

- (IBAction)showPrefs:(NSMenuItem *)sender
{
    [prefWindow makeKeyAndOrderFront:self];
}


- (IBAction)quit:(NSMenuItem *)sender
{
    [NSApp terminate:self];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

@end
