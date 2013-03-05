//
//  PMProfileManager.m
//  ProductivityManager
//
//  Created by Orion Stanger on 3/5/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import "PMProfileManager.h"

static PMProfileManager *_sharedProfileManager;

@implementation PMProfileManager

@synthesize profileData = _profileData;

- (void)setProfileData:(NSDictionary *)profileData
{
	_profileData = profileData;
	[_profileData writeToFile:@"ProductivityManager/profileData.plist" atomically:YES];
}

- (NSDictionary *)profileData
{
	if (!_profileData) _profileData = [[NSDictionary alloc] initWithContentsOfFile:@"ProductivityManager/profileData.plist"];
	return _profileData;
}

+ (PMProfileManager *)sharedProfileManager
{
	if (!_sharedProfileManager) _sharedProfileManager = [[self alloc] init];
	return _sharedProfileManager;
}

@end
