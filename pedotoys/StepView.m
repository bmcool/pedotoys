//
//  StepView.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/4.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "StepView.h"

#import "PedoData.h"

@implementation StepView

@end

@implementation _StepView


- (void) updateLabels
{
    [self.stepLabel setText:[NSString stringWithFormat:@"%d", [[PedoData sharedInstance] step]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateLabels];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabels) name:EventStepChanged object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
