//
//  WeatherView.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/4.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

@end

@implementation _WeatherView

-(void) awakeFromNib
{
    openWeatherMap = [OpenWeatherMap sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.weatherIconImageView setImage:openWeatherMap.station.weather.iconImage];
    
    [self.weatherLabel setText:openWeatherMap.station.weather.description];
    [self.tempCLabel setText:[NSString stringWithFormat:@"%.1fC", openWeatherMap.station.tempC]];
    [self.tempFLabel setText:[NSString stringWithFormat:@"%.1fF", openWeatherMap.station.tempF]];
    [self.cityLabel setText:openWeatherMap.station.city];
    
    [self updateTime];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
}

- (void) updateTime
{
    [self.timeLabel setText:[self get24HourFormatTime]];
    [self.dateLabel setText:[self getFormatDate]];
}

- (NSString *)getFormatDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d yyyy"];
    
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    return timeString;
}

- (NSString *)get24HourFormatTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    return timeString;
}

@end
