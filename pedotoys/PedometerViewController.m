//
//  SportViewController.m
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/24.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "PedometerViewController.h"

@interface PedometerViewController ()

@end

@implementation PedometerViewController

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
    
	[self.shakeCountLabel setText:[NSString stringWithFormat:@"%d", self.shakeCount]];
}

-(void) incrShakeCount
{
    [super incrShakeCount];
    
    [self.shakeCountLabel setText:[NSString stringWithFormat:@"%d", self.shakeCount]];
}

-(IBAction)stop:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
