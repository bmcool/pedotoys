//
//  BaseModel.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)init
{
    self = [super init];
    if (self) {
        [self update];
    }
    return self;
}

+ (id) sharedInstance
{
    NSLog(@"Not Implemented %s", __PRETTY_FUNCTION__);
    return nil;
}

- (void)save
{
    NSLog(@"Not Implemented %s", __PRETTY_FUNCTION__);
}

- (void)update
{
    NSLog(@"Not Implemented %s", __PRETTY_FUNCTION__);
}

@end
