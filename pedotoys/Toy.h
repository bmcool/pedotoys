//
//  Toy.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/6.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Toy : NSObject

@property (assign, nonatomic) NSString *id;

@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *description;

@property (assign, nonatomic) NSInteger stock;
@property (weak, nonatomic) UIImage *iconImage;

@end
