//
//  WeatherModel.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/4.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
- (void)dealloc
{
    self.citynm = nil;
    self.weaid = nil;
    self.weather = nil;
    self.weather_icon = nil;
    self.week = nil;
    self.wind = nil;
    self.winp = nil;
    self.days = nil;
    self.temperature = nil;
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

@end
