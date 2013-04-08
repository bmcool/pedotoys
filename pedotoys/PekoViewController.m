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

#define POKE_COST 50

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
    [self initQuestionButtons];
}

- (void) initQuestionButtons
{
    [self.view setButtonsWithBlock:^(UIButton *btn) {
        [btn setBackgroundImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    }];
    [self.view setButtonsEnable:YES];
}

- (IBAction)poke:(UIButton *)sender
{
    clickButton = sender;
    
    if ([[PedoData sharedInstance] money] < POKE_COST) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your coin is not enough" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You will spend %d coins", POKE_COST] message:@"Are you sure you want to poke?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"PokeWithAsking"]) {
            [alert show];
        } else {
            [self alertView:alert clickedButtonAtIndex:1];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[PedoData sharedInstance] incrMoney:-POKE_COST];
        [AudioToolkit playSound:@"coin_spend" ofType:@"mp3"];
        
        [clickButton setEnabled:NO];
        [clickButton setBackgroundImage:[UIImage imageNamed:@"question_done"] forState:UIControlStateNormal];
        
        Toy *toy = [[ToyCenter sharedInstance] randomGenerateToy];
        ToyView *toyView = [ToyView showToy:toy inView:self.view];
        toyView.delegate = self;
        
        closeTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(closeToyView:) userInfo:toyView repeats:NO];
    }
}

- (void)closeToyView:(NSTimer *)timer
{
    [timer.userInfo removeFromSuperview];
}

- (void) toyViewDidDisappear:(ToyView *)toyView
{
    [closeTimer invalidate];
    [self initQuestionButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
