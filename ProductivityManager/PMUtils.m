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
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:@"ProductivityManager/profileData.plist"];
}

+ (NSMenuItem *)selectedItemForString:(NSString *)str andMenu:(NSMenu *)menu
{
	for (NSMenuItem *item in menu.itemArray)
		if ([item.title isEqualToString:str])
			return item;
	return nil;
}

@end
