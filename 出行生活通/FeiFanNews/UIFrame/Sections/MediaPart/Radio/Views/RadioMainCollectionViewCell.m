//
//  RadioMainCollectionViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/2.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioMainCollectionViewCell.h"
#import "RadioMainModel.h"
#import "UIImageView+WebCache.h"
#import "FeiFanHeader.h"



@interface RadioMainCollectionViewCell ()

@property(nonatomic,retain)UILabel *tnameLabel;//电台名
@property(nonatomic,retain)UILabel *titleLabel;//音乐名
@property(nonatomic,retain)UILabel *playCountLabel;//播放量
@property(nonatomic,retain)UIImageView *imgsrcView;//电台图
@property(nonatomic,retain)UIImageView *backImageView;//cell背景
@property(nonatomic,retain)UIImageView *playCountView;//播放图标

@end


@implementation RadioMainCollectionViewCell

- (void)dealloc
{
    self.tnameLabel = nil;
    self.titleLabel = nil;
    self.playCountLabel = nil;
    self.imgsrcView = nil;
    self.backImageView = nil;
    [super dealloc];
}


- (void)assignValueByModel:(RadioMainModel *)model{
    
    [self.imgsrcView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"jpg"]];
    self.tnameLabel.text = model.tname;
    self.titleLabel.text = model.title;
    self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万",[model.playCount doubleValue]/10000];
}

- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backImageView];
    }
    return self;
}

//背景图
- (UIImageView *)backImageView{

    if (_backImageView == nil) {
        self.backImageView = [[[UIImageView alloc]initWithFrame:self.bounds]autorelease];
        self.backImageView.image = [UIImage imageNamed:@"tea.jpg"];
        self.backImageView.layer.cornerRadius = 8.0;
        self.backImageView.layer.masksToBounds = YES;
        [self.backImageView addSubview:self.imgsrcView];
        [self.backImageView addSubview:self.tnameLabel];
        [self.backImageView addSubview:self.playCountLabel];
        [self.backImageView addSubview:self.titleLabel];
        [self.backImageView addSubview:self.playCountView];
    }
    return [[_backImageView retain]autorelease];
}

//电台图
- (UIImageView *)imgsrcView{

    if (_imgsrcView == nil) {
        self.imgsrcView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.0416*MAIN_SCREEN_WIDTH, 0.01775*MAIN_SCREEN_WIDTH, 0.25*MAIN_SCREEN_WIDTH, 0.25*MAIN_SCREEN_WIDTH)]autorelease];
        self.imgsrcView.backgroundColor = [UIColor redColor];
        self.imgsrcView.layer.cornerRadius = MAIN_SCREEN_WIDTH*0.125;
        self.imgsrcView.layer.masksToBounds = YES;
    }
    return [[_imgsrcView retain]autorelease];
}


//电台名
- (UILabel *)tnameLabel{

    if (_tnameLabel == nil) {
        self.tnameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.01*MAIN_SCREEN_WIDTH, 0.266*MAIN_SCREEN_WIDTH, 0.3*MAIN_SCREEN_WIDTH,5.33*MAIN_SCREEN_WIDTH/80)]autorelease];
        self.tnameLabel.font = [UIFont systemFontOfSize:13];
        self.tnameLabel.textAlignment = NSTextAlignmentCenter;
//        self.tnameLabel.backgroundColor = [UIColor greenColor];
    }
    return [[_tnameLabel retain]autorelease];
}

//音乐名
- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.03*MAIN_SCREEN_WIDTH, 25*MAIN_SCREEN_WIDTH/80, 0.3*MAIN_SCREEN_WIDTH,4*MAIN_SCREEN_WIDTH/40)]autorelease];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.alpha = 0.6;
//        self.titleLabel.backgroundColor = [UIColor blueColor];
    }
    return [[_titleLabel retain]autorelease];
}

- (UIImageView *)playCountView{

    if (_playCountView == nil) {
        self.playCountView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.03*MAIN_SCREEN_WIDTH,32.5* MAIN_SCREEN_WIDTH/80, 3*MAIN_SCREEN_WIDTH/80, 3*MAIN_SCREEN_WIDTH/80)]autorelease];
        self.playCountView.image = [UIImage imageNamed:@"cell_tag_audio@2x"];
    }
    return [[_playCountView retain]autorelease];
}

- (UILabel *)playCountLabel{

    if (_playCountLabel == nil) {
        self.playCountLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.1*MAIN_SCREEN_WIDTH,32.5* MAIN_SCREEN_WIDTH/80, 0.15*MAIN_SCREEN_WIDTH, 3*MAIN_SCREEN_WIDTH/80)]autorelease];
        self.playCountLabel.font = [UIFont systemFontOfSize:10];
        self.playCountLabel.alpha = 0.6;
//        self.playCountLabel.backgroundColor = [UIColor yellowColor];
    }
    return [[_playCountLabel retain]autorelease];
}




















@end
