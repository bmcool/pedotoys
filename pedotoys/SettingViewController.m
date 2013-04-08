//
//  SettingViewController.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/9.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.tableView.frame];
    [bgView setImage:[UIImage imageNamed:@"subtle_white_feathers"]];
    
    [self.tableView setBackgroundView:bgView];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(10.0f/255.0f) green:(10.0f/255.0f) blue:(10.0f/255.0f) alpha:1.0f];
//    [self.tableView setBackgroundColor:[UIColor blackColor]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.pokeWithAskingSwitch setOn:[defaults boolForKey:@"PokeWithAsking"]];
    [self.IdleTimeSegment setSelectedSegmentIndex:[defaults integerForKey:@"IdleTimeType"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pokeWithAskingSwitch:(UISwitch *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.isOn forKey:@"PokeWithAsking"];
    [defaults synchronize];
}

- (IBAction)idleTimeSegment:(UISegmentedControl *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:sender.selectedSegmentIndex forKey:@"IdleTimeType"];
    if (sender.selectedSegmentIndex == 0) {
        [defaults setInteger:60 forKey:@"IdleTime"];
    } else if (sender.selectedSegmentIndex == 1) {
        [defaults setInteger:60*5 forKey:@"IdleTime"];
    } else if (sender.selectedSegmentIndex == 2) {
        [defaults setInteger:60*10 forKey:@"IdleTime"];
    }
    
    [defaults synchronize];
}

@end
