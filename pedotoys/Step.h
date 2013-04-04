//
//  Step.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "BaseModel.h"

#define EventStepChanged @"EventStepChanged"

@interface Step : BaseModel

@property (assign, nonatomic) NSInteger step;

- (void)incr:(NSInteger)step;


@end
