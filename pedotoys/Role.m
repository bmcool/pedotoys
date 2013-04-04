//
//  Role.m
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/23.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "Money.h"

#import "RegularItem.h"


@implementation Money

static Money *sharedInstance;

static NSString *_roleId;

+ (id)sharedInstance
{
    if (!sharedInstance) {
        @synchronized(self) {
            _roleId = @"0";
            
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self update];
        
        if (self.lastDrinkDate == nil) {
            self.lastDrinkDate = [NSDate dateWithTimeIntervalSince1970:0];
        }
        
        if (self.lastFoodDate == nil) {
            self.lastFoodDate = [NSDate dateWithTimeIntervalSince1970:0];
        }
        
        [self save];
        
        [self regularExpend];
        [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(regularExpend) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark -
#pragma mark - Public methods

-(void) setRoleId:(NSString *)roleId
{
    [self save];
    _roleId = roleId;
    [self update];
}

-(void) save
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = [self properties_aps];
    [defaults setObject:data forKey:[NSString stringWithFormat:@"Role_%@", _roleId]];
    [defaults synchronize];
}

-(void) update
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *role = [defaults dictionaryForKey:[NSString stringWithFormat:@"Role_%@", _roleId]];
    
    [self setValuesForKeysWithDictionary:role];
}

- (NSTimeInterval) _getCoolDownTime:(CGFloat)cd andDate:(NSDate *)date
{
    NSDate *dueDate = [[NSDate alloc] initWithTimeInterval:cd sinceDate:date];
    NSTimeInterval timeInterval = [dueDate timeIntervalSinceDate:[NSDate date]];
    if (timeInterval <= 0) {
        timeInterval = 0;
    }
    return timeInterval;
}

- (NSTimeInterval) getDrinkCoolDownTime
{
    return [self _getCoolDownTime:DrinkCD andDate:self.lastDrinkDate];
}

- (NSTimeInterval) getFoodCoolDownTime
{
    return [self _getCoolDownTime:FoodCD andDate:self.lastFoodDate];
}

- (BOOL)isCanDrink
{
    return ([self _getCoolDownTime:DrinkCD andDate:self.lastDrinkDate] == 0);
}

- (BOOL)isCanFood
{
    return ([self _getCoolDownTime:FoodCD andDate:self.lastFoodDate] == 0);
}

- (void)growWithDrinkItem:(DrinkItem *)item
{
    if ([self isCanDrink]) {
        self.lastDrinkDate = [NSDate date];
        [self growWithItem:item];
    }
}

- (void)growWithFoodItem:(FoodItem *)item
{
    if ([self isCanFood]) {
        self.lastFoodDate = [NSDate date];
        [self growWithItem:item];
    }
}

- (void)growWithItem:(BaseItem *)item
{
    self.charm += item.charm;
    self.charm = MAX(0, MIN(999, self.charm));
    
    self.intelligence += item.intelligence;
    self.intelligence = MAX(0, MIN(999, self.intelligence));
    
    self.sensibility += item.sensibility;
    self.sensibility = MAX(0, MIN(999, self.sensibility));
    
    self.vitality += item.vitality;
    self.vitality = MAX(0, MIN(999, self.vitality));
    
    self.temperament += item.temperament;
    self.temperament = MAX(0, MIN(999, self.temperament));
    
    self.weight += item.weight;
    self.weight = MAX(10, MIN(999, self.weight));
    
    self.moisture += item.moisture;
    self.moisture = MAX(0, MIN(100, self.moisture));
    
    self.satiety += item.satiety;
    self.satiety = MAX(0, MIN(100, self.satiety));
    
    self.fatigue += item.fatigue;
    self.fatigue = MAX(0, MIN(100, self.fatigue));
    
    self.toxin += item.toxin;
    self.toxin = MAX(0, MIN(100, self.toxin));
    
    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventRoleAttributeChanged object:nil];
    [self.delegate role:self attributeChangeWithItem:item];
}

-(void) regularExpend
{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [now timeIntervalSinceDate:self.lastExpendDate];
    self.lastExpendDate = now;
    
    RegularItem *item = [[RegularItem alloc] initWithTimeInterval:timeInterval];
    
    [self growWithItem:item];
}


@end
