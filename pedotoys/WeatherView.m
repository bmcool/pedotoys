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
    [self updateLabels];
    [self updateTime];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabels) name:EventWeatherChanged object:nil];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateLabels
{
    if ([openWeatherMap hasData]) {
        UIImage *iconImage;
        NSString *icon = openWeatherMap.station.weather.icon;
        if ([icon rangeOfString:@"03"].location != NSNotFound ||
            [icon rangeOfString:@"04"].location != NSNotFound) {
            iconImage = [UIImage imageNamed:@"0304"];
        
        } else if ([icon rangeOfString:@"09"].location != NSNotFound) {
            iconImage = [UIImage imageNamed:@"09"];
        
        } else if ([icon rangeOfString:@"11"].location != NSNotFound) {
            iconImage = [UIImage imageNamed:@"11"];
            
        } else if ([icon rangeOfString:@"13"].location != NSNotFound) {
            iconImage = [UIImage imageNamed:@"13"];
            
        } else if ([icon rangeOfString:@"50"].location != NSNotFound) {
            iconImage = [UIImage imageNamed:@"50"];
        
        } else {
            iconImage = [UIImage imageNamed:icon];
        }
        [self.weatherIconImageView setImage:iconImage];
        
        
        [self.weatherLabel setText:[NSString stringWithFormat:@"%@ (+%@%%)", openWeatherMap.station.weather.description, [icon substringToIndex:2]]];
        [self.tempCLabel setText:[NSString stringWithFormat:@"%.1fC", openWeatherMap.station.tempC]];
        [self.tempFLabel setText:[NSString stringWithFormat:@"%.1fF", openWeatherMap.station.tempF]];
        [self.cityLabel setText:openWeatherMap.station.city];
    } else {
        [self.weatherIconImageView setImage:openWeatherMap.station.weather.iconImage];
        
        [self.weatherLabel setText:@"Loading.."];
        [self.tempCLabel setText:@"Loading.."];
        [self.tempFLabel setText:@"Loading.."];
        [self.cityLabel setText:@"Loading.."];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
