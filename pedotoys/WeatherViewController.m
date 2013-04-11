//
//  WeatherViewController.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/10.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "WeatherViewController.h"
#import "PedoData.h"

#import "UIView+Screenshot.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.shareButton.delegate = self;
    
    self.shareButton.shareMessage = [NSString stringWithFormat:@"Pedotoys shared :\nI got Coins : %d, Steps : %d", [[PedoData sharedInstance] money], [[PedoData sharedInstance] step]];
    
    self.shareButton.mailSubject = @"Pedotoys shared";
    self.shareButton.mailMessage = [NSString stringWithFormat:@"I got Coins : %d, Steps : %d.", [[PedoData sharedInstance] money], [[PedoData sharedInstance] step]];
}

-(void) shareButtonWillShare:(ShareButton *)shareButton
{
    shareButton.shareImage = self.view.screenshot;
    
    shareButton.mailImage = self.view.screenshot;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
