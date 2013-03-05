//
//  PMUtils.h
//  ProductivityManager
//
//  Created by Orion Stanger on 3/4/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMUtils : NSObject

+ (NSString *)applicationNameForPath:(NSString *)path;
+ (NSDictionary *)defaultPrefs;
+ (NSArray *)profiles;
+ (NSMenuItem *)selectedItemForString:(NSString *)str andMenu:(NSMenu *)menu;

@end
