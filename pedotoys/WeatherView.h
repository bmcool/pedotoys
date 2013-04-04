//
//  WeatherView.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/4.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OpenWeatherMap.h"

@interface WeatherView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempCLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempFLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@interface _WeatherView : WeatherView {
    OpenWeatherMap *openWeatherMap;
    NSTimer *timer;
}

@end
