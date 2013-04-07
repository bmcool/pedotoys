//
//  PekoViewController.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "PekoViewController.h"

#import "UIView+Addition.h"

#import "AudioToolkit.h"
#import "PedoData.h"

#import "ToyView.h"
#import "ToyCenter.h"

@interface PekoViewController ()

@end

@implementation PekoViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view setButtonsWithBlock:^(UIButton *btn) {
        [btn setBackgroundImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    }];
    [self.view setButtonsEnable:YES];
}

- (IBAction)poke:(UIButton *)sender
{
    clickButton = sender;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You will spend 100 coins" message:@"Are you sure you want to poke?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        if ([[PedoData sharedInstance] money] < 100) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your coin is not enough" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        } else {
            [[PedoData sharedInstance] incrMoney:-100];
            [AudioToolkit playSound:@"coin_spend" ofType:@"mp3"];
            
            [clickButton setEnabled:NO];
            [clickButton setBackgroundImage:[UIImage imageNamed:@"question_done"] forState:UIControlStateNormal];
            
            Toy *toy = [[ToyCenter sharedInstance] randomGenerateToy];
            
            [ToyView showToy:toy inView:self.view];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
