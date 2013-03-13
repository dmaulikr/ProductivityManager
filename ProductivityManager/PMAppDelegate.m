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
@synthesize prefs = _prefs;
@synthesize selectedProfile = _selectedProfile;
@synthesize profileManager = _profileManager;

- (NSUserDefaults *)prefs
{
	if (!_prefs) _prefs = [NSUserDefaults standardUserDefaults];
	return _prefs;
}

- (void)setSelectedProfile:(NSString *)selectedProfile
{
	[profileSelector selectItem:[PMUtils selectedItemForString:selectedProfile andMenu:profileSelector.menu]];
}

- (NSString *)selectedProfile
{
	return profileSelector.selectedItem.title;
}

- (PMProfileManager *)profileManager
{
	return [PMProfileManager sharedProfileManager];
}

- (id)init
{
	self = [super init];
	if (self)
	{
		[self.prefs registerDefaults:[PMUtils defaultPrefs]];
	}
	return self;
}


- (void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    
    //[statusItem setTitle:@"PM"];
    NSImage *temp = [[NSImage alloc] initWithContentsOfFile:@"/Users/Orion/Development/Mac/ProductivityManager/ProductivityManager/pen-and-notepad-icon-vector-981374.png"];
    temp.scalesWhenResized = YES;
    temp.size = NSMakeSize(18, 18);
    [statusItem setImage:temp];
    
    [statusItem setHighlightMode:YES];
	
	[profileSelector removeAllItems];
	[profileSelector addItemsWithTitles:[PMUtils profiles]];
	[profileSelector addItemWithTitle:@"Add Profile…"];
	
	dismissCB.state = [[self.prefs objectForKey:@"dismiss"] boolValue];
	soundCB.state = [[self.prefs objectForKey:@"sound"] boolValue];
	loginCB.state = [[self.prefs objectForKey:@"openAtLogin"] boolValue];
	enterPMCB.state = [[self.prefs objectForKey:@"PModeAtLaunch"] boolValue];
	strictSlider.intValue = [[self.prefs objectForKey:@"strictness"] intValue];
	sliderNum.stringValue = [[self.prefs objectForKey:@"strictness"] stringValue];
	
	NSMenuItem *menuItem = [PMUtils selectedItemForString:[self.prefs objectForKey:@"profile"] andMenu:profileSelector.menu];
	if (menuItem)
		[profileSelector selectItem:menuItem];
	else
		[[NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"There was an error loading your profile"] runModal];
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
	[NSApp activateIgnoringOtherApps:YES];
    [[NSApplication sharedApplication] orderFrontStandardAboutPanel:self];
}

- (IBAction)showPrefs:(NSMenuItem *)sender
{
	[NSApp activateIgnoringOtherApps:YES];
    [prefWindow makeKeyAndOrderFront:self];
}


- (IBAction)quit:(NSMenuItem *)sender
{
    [NSApp terminate:self];
}


- (IBAction)updatePrefs:(id)sender
{	
	if ([sender isEqualTo:dismissCB])
		[self.prefs setBool:dismissCB.state forKey:@"dismiss"];
	else if ([sender isEqualTo:soundCB])
		[self.prefs setBool:soundCB.state forKey:@"sound"];
	else if ([sender isEqualTo:loginCB])
	{
		[self.prefs setBool:loginCB.state forKey:@"openAtLogin"];
		//TODO: update this in the system
	}
	else if ([sender isEqualTo:enterPMCB])
		[self.prefs setBool:enterPMCB.state forKey:@"PModeAtLaunch"];
	else if ([sender isEqualTo:strictSlider])
	{
		sliderNum.stringValue = strictSlider.stringValue;
		[self.prefs setInteger:strictSlider.integerValue forKey:@"strictness"];
	}
	else if ([sender isEqualTo:profileSelector])
	{
		if ([profileSelector.selectedItem.title isEqualToString:@"Add Profile…"])
		{
			NSLog(@"adding profile");
			//TODO: add code to add profile
			[profileSelector selectItemAtIndex:0];	//this will change to select the new item instead of defaulting to 0
		}
		else
		{
			[self.prefs setObject:profileSelector.selectedItem.title forKey:@"profile"];
			//TODO: update the rest of the display
		}
	}
}

- (IBAction)addProApp:(NSButton *)sender
{
	//NSString *path = @"";
	NSOpenPanel *openDlg = [NSOpenPanel openPanel];
	openDlg.canChooseDirectories = NO;
	openDlg.canChooseFiles = YES;
	openDlg.canCreateDirectories = NO;
	openDlg.allowsMultipleSelection = YES;
	openDlg.allowedFileTypes = [NSArray arrayWithObjects:@"app", @"APP", nil];
	openDlg.directoryURL = [NSURL URLWithString:@"file://localhost/Applications/"];
	if ([openDlg runModal])
	{
		[PMUtils addApplications:openDlg.URLs toProfile:profileSelector.selectedItem.title];
	}
	[appTable reloadData];
}


- (IBAction)delProApp:(NSButton *)sender
{
	NSString *app = [[appTable selectedCell] stringValue];
    [PMUtils removeApplication:app fromProfile:profileSelector.selectedItem.title];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
	
	if ([[self.prefs objectForKey:@"PModeAtLaunch"] boolValue])
	{
		enterExitProMode.title = @"Leave Productivity Mode";
		[[PMModeManager sharedModeManager] toggleProMode];
	}
}

@end
