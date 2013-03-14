//
//  PMProfileManager.h
//  ProductivityManager
//
//  Created by Orion Stanger on 3/5/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMProfileManager : NSObject <NSTableViewDataSource, NSTableViewDelegate>

+ (PMProfileManager *)sharedProfileManager;

@property (retain) NSDictionary *profileData;


@end
