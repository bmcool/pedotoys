//
//  Role.h
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/23.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "BaseModel.h"

#define EventMoneyChanged @"EventMoneyChanged"

@interface Money : BaseModel

@property (assign, nonatomic) NSInteger money;

- (void)incr:(NSInteger)money;

@end
