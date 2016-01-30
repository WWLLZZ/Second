//
//  CollectionHeaderView.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "FeiFanHeader.h"

@interface CollectionHeaderView ()

@property(nonatomic,retain)UIImageView *kindImageView;//分类图
@property(nonatomic,retain)UILabel *moreLabel;//更多图

@end

@implementation CollectionHeaderView

- (void)dealloc
{
    self.kindImageView = nil;
    self.moreLabel = nil;
    self.nameLabel = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.kindImageView];
        [self addSubview:self.moreLabel];
        [self addSubview:self.nameLabel];
    }
    return self;
}

- (UIImageView *)kindImageView{
    if (_kindImageView == nil) {
        self.kindImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.06*self.frame.size.width, 0, self.frame.size.height, self.frame.size.height)]autorelease];
        self.kindImageView.image = [UIImage imageNamed:@"audio_block_bg@2x"];
    }
    return [[_kindImageView retain]autorelease];
}


- (UILabel *)nameLabel{

    if (_nameLabel == nil) {
        self.nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.2*self.frame.size.width, 0, self.frame.size.width*0.2, self.frame.size.height)]autorelease];
//        self.nameLabel.backgroundColor = [UIColor redColor];
    }
    return [[_nameLabel retain]autorelease];
}

- (UILabel *)moreLabel{
    
    if (_moreLabel == nil) {
        self.moreLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.8*MAIN_SCREEN_WIDTH, 0, 0.2*MAIN_SCREEN_WIDTH, self.frame.size.height)]autorelease];
        self.moreLabel.text = @"点击更多精彩";
        self.moreLabel.font = [UIFont systemFontOfSize:10];
        self.moreLabel.alpha = 0.6;
    }
    return [[_moreLabel retain]autorelease];
}














@end
