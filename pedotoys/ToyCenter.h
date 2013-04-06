//
//  Toy.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/6.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Toy.h"

@interface ToyCenter : NSObject

@property (strong, nonatomic) NSString *main;
@property (strong, nonatomic) NSDictionary *config;

+ (id)sharedInstance;

- (Toy *) getToyWithId:(NSString *)toyId;
- (void) incrToyStockWithId:(NSString *)toyId stock:(NSInteger)stock;
- (Toy *) randomGenerateToy;

@end
