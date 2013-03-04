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
    
    //[statusItem setTitle:@"PM"];
    NSImage *temp = [[NSImage alloc] initWithContentsOfFile:@"/Users/orion/Development/Mac/ProductivityManager/ProductivityManager/pen-and-notepad-icon-vector-981374.png"];
    temp.scalesWhenResized = YES;
    temp.size = NSMakeSize(18, 18);
    [statusItem setImage:temp];
    
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


- (IBAction)updatePrefs:(id)sender
{	
	if ([sender isEqualTo:dismissCB])
		NSLog(@"dismiss");
	else if ([sender isEqualTo:soundCB])
		NSLog(@"sound");
	else if ([sender isEqualTo:loginCB])
	{
		NSButton *s = (NSButton *)sender;
		[enterPMCB setEnabled:s.state];
		if (s.state)
			enterPMCB.toolTip = @"Enter Productivity Mode automatically upon logging in";
		else
		{
			enterPMCB.toolTip = @"";
			enterPMCB.state = 0;
		}
	}
	else if ([sender isEqualTo:enterPMCB])
	{
		NSLog(@"enter");
	}
	
	
}

- (IBAction)addProApp:(NSButton *)sender
{
	NSArray *temp;
	NSString *name = @"";
	NSOpenPanel *openDlg = [NSOpenPanel openPanel];
	openDlg.canChooseDirectories = NO;
	openDlg.canChooseFiles = YES;
	openDlg.canCreateDirectories = NO;
	openDlg.allowsMultipleSelection = YES;
	openDlg.allowedFileTypes = [NSArray arrayWithObjects:@"app", @"APP", nil];
	openDlg.directoryURL = [NSURL URLWithString:@"file://localhost/Applications/"];
	if ([openDlg runModal])
	{
		for (NSURL *url in [openDlg URLs])
		{
			name = url.relativeString;
			name = [[name componentsSeparatedByString:@".app"] objectAtIndex:0];
			temp = [name componentsSeparatedByString:@"/"];
			name = [temp objectAtIndex:temp.count - 1];
			NSLog(@"app name: %@", name);
			
			/* if (app name ! in prefs.appList && name != ProductivityManager)
			 NSMutableArray *wee = [prefs.appList mutableCopy];
			 [wee addObject:name];
			 prefs.appList = [wee copy];
			 */
		}
	}
}


- (IBAction)delProApp:(NSButton *)sender
{
	
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

@end
