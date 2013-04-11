//
//  WeatherViewController.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/10.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareButton.h"

@interface WeatherViewController : UIViewController<ShareButtonDelegate>

@property (strong, nonatomic) IBOutlet ShareButton *shareButton;

@end
