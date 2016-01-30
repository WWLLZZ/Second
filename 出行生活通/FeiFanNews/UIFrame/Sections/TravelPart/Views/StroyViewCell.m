//
//  StroyViewCell.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "StroyViewCell.h"
#import "FeiFanHeader.h"
#import "StoryModel.h"
#import "UIImageView+WebCache.h"
@implementation StroyViewCell
- (void)dealloc{
    self.avatarView = nil;
    self.picView = nil;
    self.nameLable = nil;
    self.titleLable = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.picView];
        [self addSubview:self.titleLable];
        [self addSubview:self.avatarView];
        [self addSubview:self.nameLable];

        
    }
    return self;

}
//给cell赋值的方法
- (void)setValueByStoryModel:(StoryModel *)storymodel{
    self.titleLable.text = storymodel.index_title;
 
    [self.picView sd_setImageWithURL:[NSURL URLWithString:storymodel.index_cover] placeholderImage:[UIImage imageNamed:@"placeholder"]];



}

- (UIImageView *)picView{
    if (_picView == nil) {
        self.picView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH * 0.45, MAIN_SCREEN_HEIGHT * 0.2)];
        self.picView.layer.cornerRadius = 7;
        self.picView.layer.masksToBounds = YES;
      
    }

    return [[_picView retain]autorelease];
}
//懒加载标题Lable
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picView.frame), MAIN_SCREEN_WIDTH * 0.45, MAIN_SCREEN_WIDTH * 0.1)];
//        self.titleLable.backgroundColor = [UIColor redColor];
        self.titleLable.numberOfLines = 0;
        self.titleLable.font = [UIFont systemFontOfSize:14.0];
        [self.titleLable setTextColor:[UIColor redColor]];
       
    }
    return [[_titleLable retain]autorelease];
}
//懒加载头像Imageview
- (UIImageView *)avatarView{
    if (_avatarView == nil) {
        self.avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(self.titleLable.frame), MAIN_SCREEN_WIDTH * 0.1, MAIN_SCREEN_WIDTH *0.1)];
//        self.avatarView.backgroundColor = [UIColor redColor];
        [self.avatarView.layer setCornerRadius:CGRectGetHeight([self.avatarView bounds]) / 2];
        self.avatarView.layer.masksToBounds = YES;
    }
    return [[_avatarView retain]autorelease];

}
//懒加载nameLable
- (UILabel *)nameLable{
    if (_nameLable == nil) {
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10+MAIN_SCREEN_WIDTH * 0.1, CGRectGetMinY(self.avatarView.frame), MAIN_SCREEN_WIDTH*0.3, MAIN_SCREEN_WIDTH*0.1)];
        //self.nameLable.backgroundColor = [UIColor redColor];
        self.nameLable.font = [UIFont systemFontOfSize:12.0];
    }
    return [[_nameLable retain]autorelease];

}

@end
