//
//  WeatherCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/11/4.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherModel;
@interface WeatherCell : UITableViewCell
@property (nonatomic , retain) UILabel *citynm;
@property (nonatomic , retain) UILabel *days;
@property (nonatomic , retain) UILabel *week;
@property (nonatomic , retain) UILabel *lable1;
@property (nonatomic , retain) UILabel *weather;
@property (nonatomic , retain) UILabel *lable2;
@property (nonatomic , retain) UILabel *temperature;
@property (nonatomic , retain) UILabel *lable3;
@property (nonatomic , retain) UILabel *wind;
@property (nonatomic , retain) UILabel *winp;
//@property (nonatomic , retain) UIImageView *weatherImage;

- (void)assginValueByMovie:(WeatherModel *)model;


@end
