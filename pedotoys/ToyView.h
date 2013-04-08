//
//  ToyView.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toy.h"

@class ToyView;

@protocol ToyViewDelegate <NSObject>

- (void) toyViewDidDisappear:(ToyView *)toyView;

@end

@interface ToyView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) id <ToyViewDelegate> delegate;

- (void) updateLabelsWithToy:(Toy *)toy;

+ (ToyView *) showToy:(Toy *)toy inView:(UIView *)view;

@end
