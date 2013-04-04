//
//  BaseModel.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "NSObject+PropertyListing.h"

@interface BaseModel : NSObject

+ (id)sharedInstance;

- (void)save;
- (void)update;

@end
