//
//  ToyView.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "ToyView.h"

@implementation ToyView

- (IBAction)close:(id)sender
{
    [self removeFromSuperview];
}

- (void) updateLabelsWithToy:(Toy *)toy
{
    [self.titleLabel setText:toy.title];
    [self.descriptionLabel setText:toy.description];
    [self.stockLabel setText:[NSString stringWithFormat:@"%d", toy.stock]];
    [self.imageView setImage:toy.iconImage];
}

@end
