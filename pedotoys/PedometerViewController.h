//
//  SportViewController.h
//  lifebaby
//
//  Created by Lin Chi-Cheng on 13/3/24.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "ShakeViewController.h"

@interface PedometerViewController : ShakeViewController<ShakeDelegate, UIAlertViewDelegate> {
    NSInteger baseChance;
}

@property (weak, nonatomic) IBOutlet UILabel *shakeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanceLabel;

@end
