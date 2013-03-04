//
//  PMAppDelegate.m
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import "PMAppDelegate.h"

@implementation PMAppDelegate

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
}

- (IBAction)showAbout:(NSMenuItem *)sender
{
    [[NSAlert alertWithMessageText:@"About" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Still working on an about window"] runModal];
}

- (IBAction)showPrefs:(NSMenuItem *)sender
{
    [[NSAlert alertWithMessageText:@"Preferences" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Isn't this an awesome preference window?"] runModal];
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
