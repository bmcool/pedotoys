//
//  PedoData.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "BaseModel.h"

#define EventChanceChanged @"EventChanceChanged"
#define EventMoneyChanged @"EventMoneyChanged"
#define EventStepChanged @"EventStepChanged"

@interface PedoData : BaseModel

@property (assign, nonatomic) NSInteger money;
@property (assign, nonatomic) NSInteger step;
@property (assign, nonatomic) NSInteger chance;

- (void)incrMoney:(NSInteger)money;
- (void)incrStep:(NSInteger)step;
- (void)incrChance:(NSInteger)chance;

@end
