//
//  PekoViewController.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToyView.h"

@interface PekoViewController : UIViewController<UIAlertViewDelegate, ToyViewDelegate> {
    UIButton *clickButton;
    
    NSTimer *closeTimer;
}


@end
