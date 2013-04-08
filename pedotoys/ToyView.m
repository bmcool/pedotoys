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

- (void) removeFromSuperview
{
    [super removeFromSuperview];
    [self.delegate toyViewDidDisappear:self];
}

- (void) updateLabelsWithToy:(Toy *)toy
{
    [self.titleLabel setText:toy.title];
    [self.descriptionLabel setText:toy.description];
    [self.stockLabel setText:[NSString stringWithFormat:@"%d", toy.stock]];
    [self.imageView setImage:toy.iconImage];
}

+ (ToyView *) showToy:(Toy *)toy inView:(UIView *)view
{
    ToyView *toyView = [[[NSBundle mainBundle] loadNibNamed:@"ToyView" owner:self options:nil] objectAtIndex:0];
    [toyView setAlpha:0.0];
    [toyView setFrame:view.frame];
    [toyView updateLabelsWithToy:toy];
    [view addSubview:toyView];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [toyView setAlpha:1.0];
    [UIView commitAnimations];
    
    return toyView;
}

@end
