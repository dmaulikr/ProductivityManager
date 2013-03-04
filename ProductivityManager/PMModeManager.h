//
//  PMModeManager.h
//  ProductivityManager
//
//  Created by Orion on 3/3/13.
//  Copyright (c) 2013 Andoutay Programs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMModeManager : NSObject

@property BOOL inProMode;

+ (PMModeManager *)sharedModeManager;

@end
