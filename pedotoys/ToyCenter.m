//
//  Toy.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/6.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "ToyCenter.h"

#import "NSObject+JSONKit.h"
#import "JSONKit.h"

#define TOYS_PATH(filename) [@"Toys" stringByAppendingPathComponent:filename]

@implementation ToyCenter

static ToyCenter *sharedInstance;

+ (id)sharedInstance
{
    if (!sharedInstance) {
        @synchronized(self) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self) {
        self.main = @"default";
    }
    return self;
}

- (void) setMain:(NSString *)main
{
    _main = main;
    [self update];
}

- (void) update
{
    self.config = [NSDictionary dataFromJSONFileNamed:TOYS_PATH(self.main)];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"toys"];
    if (![fileManager fileExistsAtPath:folderPath])  //Optionally check if folder already hasn't existed.
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    folderPath = [folderPath stringByAppendingPathComponent:self.main];
    if (![fileManager fileExistsAtPath:folderPath])  //Optionally check if folder already hasn't existed.
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    for (NSString *toyId in [self.config objectForKey:@"toys"]) {
//        NSDictionary *value = [[self.config objectForKey:@"toys"] objectForKey:toyId];
        NSString *toyPath = [[folderPath stringByAppendingPathComponent:toyId] stringByAppendingPathExtension:@"json"];
        if (![fileManager fileExistsAtPath:toyPath]) {
            [fileManager createFileAtPath:toyPath contents:[@"{}" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
    }
}

- (NSString *) getToySavePathWithId:(NSString *)toyId
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"toys"];
    folderPath = [folderPath stringByAppendingPathComponent:self.main];
    return [[folderPath stringByAppendingPathComponent:toyId] stringByAppendingPathExtension:@"json"];
}

- (NSDictionary *) getToySaveDataWithId:(NSString *)toyId
{
    NSString *json = [NSString stringWithContentsOfFile:[self getToySavePathWithId:toyId] encoding:NSUTF8StringEncoding error:nil];
    return [json objectFromJSONString];
}

- (void) writeToySaveDataWithId:(NSString *)toyId data:(NSDictionary *)data
{
    [[data JSONString] writeToFile:[self getToySavePathWithId:toyId] atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (Toy *) getToyWithId:(NSString *)toyId
{
    Toy *toy = [Toy new];
    
    NSDictionary *toyConfig = [[self.config objectForKey:@"toys"] objectForKey:toyId];
    
    toy.id = toyId;
    toy.title = [toyConfig objectForKey:@"title"];
    toy.description = [toyConfig objectForKey:@"description"];
    
    
    NSNumber *stockNumber = [[self getToySaveDataWithId:toyId] objectForKey:@"stock"];
    if (stockNumber == nil) {
        [self incrToyStockWithId:toyId stock:0];
        stockNumber = [NSNumber numberWithInt:0];
    }
    
    toy.stock = [stockNumber intValue];
    
    if (toy.stock > 0) {
        toy.iconImage = [UIImage imageNamed:[TOYS_PATH(self.main) stringByAppendingPathComponent:toyId]];
    } else {
        toy.iconImage = [UIImage imageNamed:@"unknown"];
    }
    
    return toy;
}

- (void) incrToyStockWithId:(NSString *)toyId stock:(NSInteger)stock
{
    NSMutableDictionary *toyData = [NSMutableDictionary dictionaryWithDictionary:[self getToySaveDataWithId:toyId]];
    
    NSNumber *stockNumber = [toyData objectForKey:@"stock"];
    if (stockNumber == nil) {
        stockNumber = [NSNumber numberWithInt:0];
    }
    
    [toyData setValue:[NSNumber numberWithInt:([stockNumber intValue] + stock)] forKey:@"stock"];
    [self writeToySaveDataWithId:toyId data:toyData];
}

- (Toy *) randomGenerateToy
{
    NSString *generateToyId;
    NSDictionary *toys = [self.config objectForKey:@"toys"];
    
    while (generateToyId == nil) {
        for (NSString *toyId in toys) {
            NSDictionary *toyConfig = [toys objectForKey:toyId];
            NSNumber *rarity = [toyConfig objectForKey:@"rarity"];
            
            // 0 ~ 99.99
            float randomNum = ((float)rand() / RAND_MAX) * 100;
            NSLog(@"toyId = %@, [rarity floatValue] = %f, randomNum = %f", toyId, [rarity floatValue], randomNum);
            if ([rarity floatValue] <= randomNum) {
                generateToyId = toyId;
            }
        }
    }
    [self incrToyStockWithId:generateToyId stock:1];
    
    return [self getToyWithId:generateToyId];
}

@end
