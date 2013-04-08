//
//  SportViewController.m
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/24.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "PedometerViewController.h"
#import "PedoData.h"

#import "AudioToolkit.h"
#import "OpenWeatherMap.h"

@interface PedometerViewController ()

@end

@implementation PedometerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self.shakeCountLabel setText:[NSString stringWithFormat:@"%d", self.shakeCount]];
    
    OpenWeatherMap *openWeatherMap = [OpenWeatherMap sharedInstance];
    
    NSInteger weatherChance = 0;
    
    NSString *icon = openWeatherMap.station.weather.icon;
    if (icon != nil) {
        weatherChance = [[icon substringToIndex:2] intValue];
    }
    
    baseChance = [[PedoData sharedInstance] chance] + weatherChance;
    [self.chanceLabel setText:[NSString stringWithFormat:@"%d", baseChance]];
    
    
    NSLog(@"");
    
    idleCheckTimer = [NSTimer scheduledTimerWithTimeInterval:[[NSUserDefaults standardUserDefaults] integerForKey:@"IdleTime"] target:self selector:@selector(stopPedometer) userInfo:nil repeats:NO];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [idleCheckTimer invalidate];
    idleCheckTimer = nil;
}

-(void) incrShakeCount
{
    [super incrShakeCount];
    
    [idleCheckTimer invalidate];
    idleCheckTimer = [NSTimer scheduledTimerWithTimeInterval:[[NSUserDefaults standardUserDefaults] integerForKey:@"IdleTime"] target:self selector:@selector(stopPedometer) userInfo:nil repeats:NO];
    
    // 1 ~ 100
    NSInteger randomNum = ((float)rand() / RAND_MAX) * 100 + 1;
    
    NSInteger chance = baseChance + self.shakeCount / 100;
    if (chance > 100) {
        chance = 100;
    }
    
    if (randomNum <= chance) {
        [[PedoData sharedInstance] incrMoney:1];
        [AudioToolkit playSound:@"coin_get" ofType:@"mp3"];
    }
    [[PedoData sharedInstance] incrStep:1];
    
    [self.chanceLabel setText:[NSString stringWithFormat:@"%d", chance]];
    [self.shakeCountLabel setText:[NSString stringWithFormat:@"%d", self.shakeCount]];
}

-(IBAction)stop:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to quit?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) stopPedometer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Debug methods

- (IBAction)getMoney:(id)sender
{
    [[PedoData sharedInstance] incrMoney:100];
    [AudioToolkit playSound:@"coin_get" ofType:@"mp3"];
}

@end
