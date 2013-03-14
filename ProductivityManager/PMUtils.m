//
//  PMUtils.m
//  ProductivityManager
//
//  Created by Orion Stanger on 3/4/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import "PMUtils.h"
#import "PMAppDelegate.h"

@implementation PMUtils

+ (NSString *)applicationNameForPath:(NSString *)path
{
	NSString *ans;
	NSArray *temp;
	
	ans = [[path componentsSeparatedByString:@".app"] objectAtIndex:0];
	temp = [ans componentsSeparatedByString:@"/"];
	ans = [temp objectAtIndex:temp.count - 1];
	ans = [ans stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	return ans;
}

+ (NSDictionary *)defaultPrefs
{
	return [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:YES], @"dismiss", [NSNumber numberWithBool:YES], @"sound", [NSNumber numberWithBool:NO], @"openAtLogin", @"NO", @"PModeAtLaunch", [NSNumber numberWithInt:3], @"strictness", @"Default", @"profile", [NSArray arrayWithObject:@"Default"], @"profiles", nil];
}

+ (NSArray *)profiles
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"profiles"];
}

+ (NSArray *)applicationsForProfile:(NSString *)profile
{
	return [[PMProfileManager sharedProfileManager].profileData objectForKey:profile];
}

+ (void)addApplications:(NSArray *)apps toProfile:(NSString *)profile
{
	for (NSURL *url in apps)
		if ([url.relativeString rangeOfString:@"ProductivityManager"].location == NSNotFound)
			[self addApplication:url.relativeString toProfile:profile];
}

+ (void)addApplication:(NSString *)app toProfile:(NSString *)profile
{
	PMProfileManager *profileManager = [PMProfileManager sharedProfileManager];
	NSMutableDictionary *profileData = [profileManager.profileData mutableCopy];
	NSMutableArray *apps = [[profileData objectForKey:profile] mutableCopy];
	if (!apps) apps = [[NSMutableArray alloc] init];
	[apps addObject:app];
	[apps sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	[profileData setObject:[apps copy] forKey:profile];
	profileManager.profileData = [profileData copy];
}

+ (void)removeApplications:(NSArray *)apps fromProfile:(NSString *)profile
{
    for (NSString *string in apps)
        [self removeApplication:string fromProfile:profile];
}

+ (void)removeApplication:(NSString *)app fromProfile:(NSString *)profile
{
	PMProfileManager *profileManager = [PMProfileManager sharedProfileManager];
    NSMutableDictionary *profileData = [profileManager.profileData mutableCopy];
    NSMutableArray *apps = [[profileData objectForKey:profile] mutableCopy];
	NSMutableArray *toDel = [[NSMutableArray alloc] init];
    for (NSString *str in apps)
        if ([str rangeOfString:app].location != NSNotFound)
			[toDel addObject:str];
	
	[apps removeObjectsInArray:[toDel copy]];
    
    [profileData setObject:[apps copy] forKey:profile];
    profileManager.profileData = [profileData copy];
    
    PMAppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    [delegate.appTable reloadData];
}

+ (NSMenuItem *)selectedItemForString:(NSString *)str andMenu:(NSMenu *)menu
{
	for (NSMenuItem *item in menu.itemArray)
		if ([item.title isEqualToString:str])
			return item;
	return nil;
}

#pragma mark - Login Item methods

+ (void)addAppAsLoginItem
{
	NSString * appPath = [[NSBundle mainBundle] bundlePath];
	
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:appPath]);
	
	// Create a reference to the shared file list.
	// We are adding it to the current user only.
	// If we want to add it all users, use
	// kLSSharedFileListGlobalLoginItems instead of
	//kLSSharedFileListSessionLoginItems
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
															kLSSharedFileListSessionLoginItems, NULL);
	if (loginItems) {
		//Insert an item to the list.
		LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems,
																	 kLSSharedFileListItemLast, NULL, NULL,
																	 url, NULL, NULL);
		if (item){
			CFRelease(item);
		}
	}
	
	CFRelease(loginItems);
}

+ (void)deleteAppFromLoginItem
{
	NSString * appPath = [[NSBundle mainBundle] bundlePath];
	
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:appPath]);
	
	// Create a reference to the shared file list.
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
															kLSSharedFileListSessionLoginItems, NULL);
	
	if (loginItems) {
		UInt32 seedValue;
		//Retrieve the list of Login Items and cast them to
		// a NSArray so that it will be easier to iterate.
		NSArray  *loginItemsArray = (NSArray *)CFBridgingRelease(LSSharedFileListCopySnapshot(loginItems, &seedValue));
		int i;
		for(i = 0 ; i< [loginItemsArray count]; i++){
			LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)CFBridgingRetain([loginItemsArray
																		objectAtIndex:i]);
			//Resolve the item with URL
			if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr) {
				NSString * urlPath = [(NSURL*)CFBridgingRelease(url) path];
				if ([urlPath compare:appPath] == NSOrderedSame){
					LSSharedFileListItemRemove(loginItems,itemRef);
				}
			}
		}
		//[loginItemsArray release];
	}
}

@end
