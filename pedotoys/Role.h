//
//  Role.h
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/23.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "NSObject+PropertyListing.h"

#define EventRoleAttributeChanged @"EventRoleAttributeChanged"

@interface Money : NSObject

@property (assign, nonatomic) NSInteger shakeCount;
@property (assign, nonatomic) NSInteger distance;

+ (id)sharedInstance;

- (void)save;
- (void)update;

@end
