//
//  ToysViewController.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/7.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ToyCenter.h"

@interface ToysViewController : UIViewController {
    ToyCenter *toyCenter;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end