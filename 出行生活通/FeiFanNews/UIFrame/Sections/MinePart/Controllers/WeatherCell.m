//
//  WeatherCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/4.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WeatherCell.h"
#import "WeatherModel.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
@implementation WeatherCell

- (UILabel *)citynm{
    if (_citynm == nil) {
        self.citynm = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth / 4, 40)];
        self.citynm.textAlignment = NSTextAlignmentCenter;
//        self.citynm.backgroundColor = [UIColor orangeColor];
        self.citynm.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];
    }
    return [[_citynm retain]autorelease];
}
- (UILabel *)days{
    if (_days == nil) {
        self.days = [[UILabel alloc] initWithFrame:CGRectMake(self.citynm.frame.origin.x + 5 + self.citynm.frame.size.width, 5, kScreenWidth / 2 - 20 , 40)];
        self.days.textAlignment = NSTextAlignmentCenter;
        self.days.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
//        self.days.backgroundColor = [UIColor orangeColor];
//        [self.days release];
    }
    return  [[_days retain]autorelease];
}

- (UILabel *)week{
    if (_week == nil) {
        self.week = [[UILabel alloc] initWithFrame:CGRectMake(self.days.frame.origin.x + 5 + self.days.frame.size.width, 5, kScreenWidth / 4 , 40)];
        self.week.textAlignment = NSTextAlignmentCenter;
        self.week.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
//        self.week.backgroundColor = [UIColor orangeColor];
//        [self.week release];
    }
    return [[_week retain]autorelease];
}

- (UILabel *)lable1{
    if (_lable1 == nil) {
        self.lable1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, kScreenWidth / 4, 40)];
        self.lable1.textAlignment = NSTextAlignmentCenter;
        self.lable1.text = @"天气";
        self.lable1.font = [UIFont fontWithName:@"Georgia-Bold" size:20];
//        self.lable1.backgroundColor = [UIColor cyanColor];
//        [self.lable1 release];
    }
    return [[_lable1 retain]autorelease];
}

- (UILabel *)weather{
    if (_weather == nil) {
        self.weather = [[UILabel alloc] initWithFrame:CGRectMake(self.lable1.frame.size.width + 10, 50, kScreenWidth / 4 * 3 - 15, 40)];
        self.weather.textAlignment = NSTextAlignmentCenter;
        self.weather.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
//        self.weather.backgroundColor = [UIColor cyanColor];
//        [self.weather release];
    }
    return [[_weather retain]autorelease];
}
- (UILabel *)lable2{
    if (_lable2 == nil) {
        self.lable2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 95, kScreenWidth / 4, 40)];
        self.lable2.textAlignment = NSTextAlignmentCenter;
        self.lable2.text = @"温度";
        self.lable2.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];
//        self.lable2.backgroundColor = [UIColor greenColor];
//        [self.lable2 release];
    }
    return [[_lable2 retain]autorelease];
}

- (UILabel *)lable3{
    if (_lable3 == nil) {
        self.lable3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, kScreenWidth / 4, 40)];
        self.lable3.textAlignment = NSTextAlignmentCenter;
        self.lable3.text = @"风速";
        self.lable3.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];
//        self.lable3.backgroundColor = [UIColor brownColor];
//        [self.lable3 release];
    }
    return [[_lable3 retain]autorelease];
}

- (UILabel *)temperature{
    if (_temperature == nil) {
        self.temperature = [[UILabel alloc] initWithFrame:CGRectMake(self.lable2.frame.origin.x + self.lable1.frame.size.width + 5, 95, kScreenWidth / 4 * 3 - 15, 40)];
        self.temperature.textAlignment = NSTextAlignmentCenter;
        self.temperature.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
//        self.temperature.backgroundColor = [UIColor greenColor];
//        [self.temperature release];
    }
    return [[_temperature retain]autorelease];
}

- (UILabel *)wind{
    if (_wind == nil) {
        self.wind = [[UILabel alloc] initWithFrame:CGRectMake(self.citynm.frame.origin.x + 5 + self.citynm.frame.size.width, 140, kScreenWidth / 2 - 20, 40)];
        self.wind.textAlignment = NSTextAlignmentCenter;
        self.wind.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
//        self.wind.backgroundColor = [UIColor brownColor];
//        [self.wind release];
    }
    return [[_wind retain]autorelease];
}
- (UILabel *)winp{
    if (_winp == nil) {
        self.winp = [[UILabel alloc] initWithFrame:CGRectMake(self.days.frame.origin.x + 5 + self.days.frame.size.width, 140, kScreenWidth / 4, 40)];
        self.winp.textAlignment = NSTextAlignmentCenter;
        self.winp.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
//        self.winp.backgroundColor = [UIColor brownColor];
//        [self.winp release];
    }
    return [[_winp retain]autorelease];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
  
    [self.contentView addSubview:self.citynm];
    [self.contentView addSubview:self.days];
    [self.contentView addSubview:self.week];
    [self.contentView addSubview:self.lable1];
    [self.contentView addSubview:self.weather];
    [self.contentView addSubview:self.lable2];
    [self.contentView addSubview:self.lable3];
    [self.contentView addSubview:self.temperature];
    [self.contentView addSubview:self.wind];
    [self.contentView addSubview:self.winp];
    }
    return self;
}
- (void)assginValueByMovie:(WeatherModel *)model{
    self.citynm.text = model.citynm;
    self.days.text = model.days;
    self.week.text = model.week;
    self.weather.text = model.weather;
    self.temperature.text = model.temperature;
    self.wind.text = model.wind;
    self.winp.text = model.winp;
}

- (void)awakeFromNib {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
