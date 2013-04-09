//
//  ToysViewController.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/7.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "ToysViewController.h"

#import "ToyCenter.h"
#import "ToyView.h"

#import "UIView+Addition.h"

@interface ToysViewController ()

@end

@implementation ToysViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shareButton.delegate = self;
    
    self.shareButton.shareMessage = @"Pedotoys share";
    
    self.shareButton.feedMessage = @"Pedotoys share";
    
    self.shareButton.lineMessage = @"Pedotoys share";
    
    self.shareButton.mailSubject = @"Pedotoys share";
    self.shareButton.mailMessage = @"Pedotoys share";

	toyCenter = [ToyCenter sharedInstance];
    NSDictionary *toys = [toyCenter.config objectForKey:@"toys"];
    
    float bottomMargin = 20;
    float iconWidth = 80;
    float iconHeight = 80;
    float iconNumLabelHeight = 20;
    
    float itemHieght = iconHeight + iconNumLabelHeight + bottomMargin;
    
    float x;
    float y;
    for (int i = 1; i <= [toys count]; i++) {
        x = ((i - 1) % 4) * iconWidth;
        y = itemHieght * ((i - 1) / 4);
                
        UIButton *iconbtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, iconWidth, iconHeight)];
        Toy *toy = [toyCenter getToyWithId:[NSString stringWithFormat:@"%d", i]];
        
        iconbtn.tag = i;
        [iconbtn setBackgroundImage:toy.iconImage forState:UIControlStateNormal];
        if (toy.stock == 0) {
            [iconbtn setEnabled:NO];
        }
        
        [iconbtn addTarget:self action:@selector(showToy:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y + iconHeight, iconWidth, iconNumLabelHeight)];
        [iconLabel setTextColor:[UIColor whiteColor]];
        [iconLabel setBackgroundColor:[UIColor clearColor]];
        [iconLabel setTextAlignment:NSTextAlignmentCenter];
        [iconLabel setFont:[UIFont systemFontOfSize:12]];
        [iconLabel setText:[NSString stringWithFormat:@"NO. %d", i]];
        
        [self.scrollView addSubview:iconbtn];
        [self.scrollView addSubview:iconLabel];
    }
    
    [self.scrollView setContentSize:CGSizeMake(320, y + itemHieght)];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViews];
}

- (void) updateViews
{
    iconCount = 0;
    [self.scrollView setButtonsWithBlock:^(UIButton *btn) {
        Toy *toy = [toyCenter getToyWithId:[NSString stringWithFormat:@"%d", btn.tag]];
        if (toy.stock > 0) {
            [btn setEnabled:YES];
            iconCount++;
        }
        [btn setBackgroundImage:toy.iconImage forState:UIControlStateNormal];
    }];
    
    NSInteger completion = iconCount * 100 / [[toyCenter.config objectForKey:@"toys"] count];
    [self.completionLabel setText:[NSString stringWithFormat:@"%d %%", completion]];
}

- (void) showToy:(UIButton *)iconBtn
{
    Toy *toy = [toyCenter getToyWithId:[NSString stringWithFormat:@"%d", iconBtn.tag]];
    [ToyView showToy:toy inView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
