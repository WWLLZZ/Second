//
//  HeadView.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "HeadView.h"
#import "FeiFanHeader.h"

#define Main_width [UIScreen mainScreen].bounds.size.width
@implementation HeadView
- (void)dealloc{
    self.view = nil;
    self.titleLable = nil;
    self.moreButton = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.moreButton];
        [self addSubview:self.titleLable];
        [self addSubview:self.view];
    }
    return self;
}

- (UIButton *)moreButton{
    if (_moreButton == nil) {
        self.moreButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.moreButton.frame = CGRectMake(MAIN_SCREEN_WIDTH*0.81, MAIN_SCREEN_WIDTH*0.053, 40, 40);
        [self.moreButton setTitle:@"更多" forState:(UIControlStateNormal)];
//        [self.moreButton setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
      
    }
    return [[_moreButton retain]autorelease];

}

- (UIImageView *)view{
    if (_view == nil) {
        self.view = [[[UIImageView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*0.053, MAIN_SCREEN_WIDTH*0.08, 0.8*kSpace, 2*kSpace)]autorelease];
        self.view.backgroundColor = [UIColor cyanColor];
//        self.view.image = [UIImage imageNamed:@"bg_navigationBar@2x.png"];
    }
    return [[_view retain]autorelease];

}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*0.1, MAIN_SCREEN_WIDTH*0.053,MAIN_SCREEN_WIDTH * 0.46, 4*kSpace)]autorelease];
//        self.titleLable.backgroundColor = [UIColor cyanColor];
        self.titleLable.text = @"每日精选故事";
    }
    return [[_titleLable retain]autorelease];
}

@end
