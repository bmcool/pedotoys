//
//  UIViewController+WeatherView.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/4.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "UIViewController+WeatherView.h"

#import <objc/runtime.h>

#define kWeatherViewKey @"kWeatherViewKey"

@implementation UIViewController (WeatherView)

- (void)setWeatherView:(id)aObject
{
    objc_setAssociatedObject(self, kWeatherViewKey, aObject, OBJC_ASSOCIATION_ASSIGN);
}

- (id)weatherView
{
    return objc_getAssociatedObject(self, kWeatherViewKey);
}

@end
