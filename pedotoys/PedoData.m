//
//  PedoData.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "PedoData.h"

@implementation PedoData

static PedoData *sharedInstance;

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
    [defaults setInteger:self.step forKey:@"Step"];
    [defaults setInteger:self.chance forKey:@"Chance"];
    
    [defaults synchronize];
}

-(void) update
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.money = [defaults integerForKey:@"Money"];
    self.step = [defaults integerForKey:@"Step"];
    self.chance = [defaults integerForKey:@"Chance"];
}

- (void)incrMoney:(NSInteger)money
{
    self.money += money;
    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventMoneyChanged object:nil];
}

- (void)incrStep:(NSInteger)step
{
    self.step += step;
    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventStepChanged object:nil];
}

- (void)incrChance:(NSInteger)chance
{
    self.chance += chance;
    if (self.chance > 100) {
        self.chance = 100;
    }
    
    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventChanceChanged object:nil];
}

@end
