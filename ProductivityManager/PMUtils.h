//
//  PMUtils.h
//  ProductivityManager
//
//  Created by Orion Stanger on 3/4/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMProfileManager.h"

@interface PMUtils : NSObject

+ (NSString *)applicationNameForPath:(NSString *)path;
+ (NSDictionary *)defaultPrefs;
+ (NSArray *)profiles;
+ (NSArray *)applicationsForProfile:(NSString *)profile;
+ (NSMenuItem *)selectedItemForString:(NSString *)str andMenu:(NSMenu *)menu;
+ (void)addApplication:(NSString *)app toProfile:(NSString *)profile;
+ (void)addApplications:(NSArray *)apps toProfile:(NSString *)profile;
+ (void)removeApplications:(NSArray *)app fromProfile:(NSString *)profile;
+ (void)removeApplication:(NSString *)app fromProfile:(NSString *)profile;
+ (void)addAppAsLoginItem;
+ (void)deleteAppFromLoginItem;

@end
