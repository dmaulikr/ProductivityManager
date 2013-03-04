//
//  PMAppDelegate.h
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PMModeManager.h"

@interface PMAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
}

@property (unsafe_unretained) IBOutlet NSWindow *prefWindow;

@end
