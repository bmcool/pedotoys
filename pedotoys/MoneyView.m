//
//  PedoMoneyView.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/4.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "MoneyView.h"

#import "Money.h"

@implementation MoneyView

@end

@implementation _MoneyView

- (void) updateLabels
{
    [self.moneyLabel setText:[NSString stringWithFormat:@"%d", [[Money sharedInstance] money]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateLabels];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabels) name:EventMoneyChanged object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
