//
//  TravelNotesViewCell.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TravelNotesViewCell.h"
#import "FeiFanHeader.h"
#import "TNModel.h"
#import "UIImageView+WebCache.h"
#define Main_width
@implementation TravelNotesViewCell
- (void)dealloc{
    self.userView = nil;
    self.userNameLable = nil;
    self.BackgroundImage = nil;
    self.dateLable = nil;
    self.dayLable = nil;
    self.viewCount = nil;
    self.minView = nil;
    self.place = nil;
     self.TiteLable = nil;
    [super dealloc];

}
- (void)setValueByTNModel:(TNModel *)tnModel{
    self.place.text = tnModel.popular_place_str;
    self.dateLable.text = [NSString stringWithFormat:@"%@  第%@天  %ld次浏览",tnModel.first_day,tnModel.day_count,(long)tnModel.view_count];
    [self.BackgroundImage sd_setImageWithURL:[NSURL URLWithString:tnModel.cover_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    


}
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //调用添加到cell的方法
        [self p_setup];
    }
    return self;

}
//添加到cell上的方法
- (void)p_setup{
    [self addSubview:self.BackgroundImage];
    [self addSubview:self.minView];
    [self addSubview:self.userView];
    [self addSubview:self.userNameLable];
    [self addSubview:self.dateLable];
    [self addSubview:self.TiteLable];
    [self addSubview:self.place];

}

- (UIImageView *)BackgroundImage{
    if (_BackgroundImage == nil) {
        self.BackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(kSpace, 0, MAIN_SCREEN_WIDTH * 0.93, MAIN_SCREEN_WIDTH * 0.6)];
//        self.BackgroundImage.backgroundColor = [UIColor cyanColor];
         self.BackgroundImage.layer.cornerRadius = 7;
        self.BackgroundImage.layer.masksToBounds = YES;
    }
    return [[_BackgroundImage retain]autorelease];

}
- (UIImageView *)minView{
    if (_minView == nil) {
        self.minView = [[UIImageView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*0.053, MAIN_SCREEN_WIDTH*0.143, 3, MAIN_SCREEN_WIDTH*0.106)];
        self.minView.backgroundColor = [UIColor redColor];
       
    }

    return [[_minView retain]autorelease];

}
-(UIImageView *)userView{
    if (_userView == nil) {
        self.userView = [[UIImageView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.053, MAIN_SCREEN_WIDTH * 0.47, 3*kSpace, 3*kSpace)];
        [self.userView.layer setCornerRadius:CGRectGetHeight([self.userView bounds]) / 2];
        self.userView.layer.masksToBounds = YES;
    }
    return [[_userView retain]autorelease];

}
- (UILabel *)userNameLable{
    if (_userNameLable == nil) {
        self.userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.17, MAIN_SCREEN_WIDTH * 0.47, MAIN_SCREEN_WIDTH *0.5, 3*kSpace)];
        [self.userNameLable setTextColor:[UIColor whiteColor]];
         self.userNameLable.font = [UIFont systemFontOfSize:12.0];

    }
    return [[_userNameLable retain]autorelease];

}

- (UILabel *)dateLable{
    if (_dateLable == nil) {
        self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.08, MAIN_SCREEN_WIDTH * 0.12, MAIN_SCREEN_WIDTH * 0.93, 2*kSpace)];
//        self.dateLable.backgroundColor = [UIColor redColor];
         [self.dateLable setTextColor:[UIColor whiteColor]];
        self.dateLable.font = [UIFont systemFontOfSize:12.0];
    }
    return [[_dateLable retain]autorelease];

}
- (UILabel *)TiteLable{
    if (_TiteLable == nil) {
        self.TiteLable = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.053, 0, MAIN_SCREEN_WIDTH, 35)];
//        self.TiteLable.backgroundColor = [UIColor whiteColor];
         [self.TiteLable setTextColor:[UIColor whiteColor]];
        self.TiteLable.numberOfLines = 0;
    
    }
    return [[_TiteLable retain]autorelease];
}
- (UILabel *)place{
    if (_place == nil) {
        self.place = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.08, MAIN_SCREEN_WIDTH * 0.2,MAIN_SCREEN_WIDTH*0.62, 2*kSpace)];
//        self.place.backgroundColor = [UIColor redColor];
         [self.place setTextColor:[UIColor whiteColor]];
         self.place.font = [UIFont systemFontOfSize:12.0];
    }
    return [[_place retain]autorelease];
}

@end
