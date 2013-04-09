//
//  ToysViewController.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/7.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ToyCenter.h"
#import "ShareButton.h"

@interface ToysViewController : UIViewController {
    ToyCenter *toyCenter;
    
    NSInteger iconCount;
}

@property (weak, nonatomic) IBOutlet UILabel *completionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet ShareButton *shareButton;

@end
