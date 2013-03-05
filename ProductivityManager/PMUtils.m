//
//  PMUtils.m
//  ProductivityManager
//
//  Created by Orion Stanger on 3/4/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import "PMUtils.h"

@implementation PMUtils

+ (NSString *)applicationNameForPath:(NSString *)path
{
	NSString *ans;
	NSArray *temp;
	
	ans = [[path componentsSeparatedByString:@".app"] objectAtIndex:0];
	temp = [ans componentsSeparatedByString:@"/"];
	ans = [temp objectAtIndex:temp.count - 1];
	
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
		if ([url.relativeString rangeOfString:@"ProductivityManager"].location != NSNotFound)
			[self addApplication:url.relativeString toProfile:profile];
}

+ (void)addApplication:(NSString *)app toProfile:(NSString *)profile
{
	PMProfileManager *profileManager = [PMProfileManager sharedProfileManager];
	NSMutableDictionary *profileData = [profileManager.profileData mutableCopy];
	NSMutableArray *apps = [profileData objectForKey:profile];
	[apps addObject:app];
	NSLog(@"apps: %@", apps);
	[profileData setObject:[apps copy] forKey:profile];
	NSLog(@"local data: %@", profileData);
	profileManager.profileData = [profileData copy];
}

+ (NSMenuItem *)selectedItemForString:(NSString *)str andMenu:(NSMenu *)menu
{
	for (NSMenuItem *item in menu.itemArray)
		if ([item.title isEqualToString:str])
			return item;
	return nil;
}

@end
