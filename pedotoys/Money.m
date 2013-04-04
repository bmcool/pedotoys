//
//  Role.m
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/23.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "Money.h"

@implementation Money

static Money *sharedInstance;

+ (id)sharedInstance
{
    if (!sharedInstance) {
        @synchronized(self) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

#pragma mark -
#pragma mark - Public methods

-(void) save
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setInteger:self.money forKey:@"Money"];
    [defaults synchronize];
}

-(void) update
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.money = [defaults integerForKey:@"Money"];
}

- (void)incr:(NSInteger)money
{
    self.money += money;
    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventMoneyChanged object:nil];
}

@end
