//
//  Step.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "Step.h"

@implementation Step

static Step *sharedInstance;

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
    [defaults setInteger:self.step forKey:@"Step"];
    [defaults synchronize];
}

-(void) update
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.step = [defaults integerForKey:@"Step"];
}

- (void)incr:(NSInteger)step
{
    self.step += step;
    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventStepChanged object:nil];
}

@end