//
//  SettingViewController.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/9.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *IdleTimeSegment;
@property (weak, nonatomic) IBOutlet UISwitch *pokeWithAskingSwitch;

@end
