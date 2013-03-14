//
//  PMAppDelegate.h
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PMModeManager.h"
#import "PMUtils.h"

@interface PMAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
	IBOutlet NSMenuItem *enterExitProMode;
	
#pragma mark - Pref outlets
	IBOutlet NSButton *dismissCB;
	IBOutlet NSButton *soundCB;
	IBOutlet NSButton *loginCB;
	IBOutlet NSButton *enterPMCB;
	IBOutlet NSSlider *strictSlider;
	IBOutlet NSTextField *sliderNum;
	IBOutlet NSPopUpButton *profileSelector;
}

@property (weak) IBOutlet NSTableView *appTable;
@property (weak) IBOutlet NSButton *removeButton;

@property (assign) IBOutlet NSWindow *prefWindow;
@property (nonatomic, retain) NSUserDefaults *prefs;
@property (retain) NSString *selectedProfile;
@property (readonly, retain) IBOutlet PMProfileManager *profileManager;

@end
