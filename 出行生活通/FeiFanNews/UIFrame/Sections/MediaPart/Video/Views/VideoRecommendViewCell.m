//
//  VideoRecommendViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoRecommendViewCell.h"
#import "FeiFanHeader.h"
#import "UIImageView+WebCache.h"
#import "VideoRecommendModel.h"


@interface VideoRecommendViewCell ()

@property(nonatomic,retain)UIImageView *VideoTimeView;//时间图片
@property(nonatomic,retain)UIImageView *backImageView;//cell背景
@property(nonatomic,retain)UIImageView *coverImageView;//视频图
@property(nonatomic,retain)UILabel *titleLabel;//视图名
@property(nonatomic,retain)UILabel *lengthLabel;//视频长度



@end

@implementation VideoRecommendViewCell

- (void)dealloc
{
    self.VideoTimeView = nil;
    self.backImageView = nil;
    self.coverImageView = nil;
    self.titleLabel = nil;
    self.lengthLabel = nil;
//    self.playingLabel = nil;
    [super dealloc];
}


- (void)assignValueByVideoRecommendModel:(VideoRecommendModel *)model{

    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"tea.jpg"]];
    self.titleLabel.text = model.title;
    self.lengthLabel.text = [NSString stringWithFormat:@"%ld:%.2ld",model.length/60,model.length%60];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backImageView];
 }

    return self;
}

- (UIImageView *)backImageView{

    if (_backImageView == nil) {
        self.backImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.13*MAIN_SCREEN_HEIGHT)]autorelease];
        self.backImageView.image = [UIImage imageNamed:@"tea.jpg"];

        [self.backImageView addSubview:self.VideoTimeView];

//        [self.playingLabel release];
        
    }
    return [[_backImageView retain]autorelease];
}

//视频截图
- (UIImageView *)coverImageView{

    if (_coverImageView == nil) {
        self.coverImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.02*MAIN_SCREEN_WIDTH, 0.0125*MAIN_SCREEN_WIDTH, self.backImageView.frame.size.width*0.375, 0.95*self.backImageView.frame.size.height)]autorelease];
        self.coverImageView.layer.cornerRadius = 12;
        self.coverImageView.layer.masksToBounds = YES;
        [self.backImageView addSubview:self.coverImageView];
        
        
    }
    return [[_coverImageView retain]autorelease];
}

//视频名
- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.backImageView.frame.size.width*0.425, 0, 0.55*self.backImageView.frame.size.width, 0.8*self.backImageView.frame.size.height)]autorelease];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.numberOfLines = 0;
        [self.backImageView addSubview:self.titleLabel];
    }
    return [[_titleLabel retain]autorelease];
}

- (UIImageView *)VideoTimeView{

    if (_VideoTimeView == nil) {
        self.VideoTimeView = [[[UIImageView alloc]initWithFrame:CGRectMake(self.backImageView.frame.size.width*0.415, 0.7*self.backImageView.frame.size.height, 0.25*self.backImageView.frame.size.height, 0.25*self.backImageView.frame.size.height)]autorelease];
        self.VideoTimeView.image = [UIImage imageNamed:@"video_list_cell_time@2x"];
        
    }
    return [[_VideoTimeView retain]autorelease];
}

//视频时长
- (UILabel *)lengthLabel{

    if (_lengthLabel == nil) {
        self.lengthLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.backImageView.frame.size.width*0.48, 0.7*self.backImageView.frame.size.height, 0.16*self.backImageView.frame.size.width, 0.25*self.backImageView.frame.size.height)]autorelease];
        self.lengthLabel.textAlignment = NSTextAlignmentCenter;
        self.lengthLabel.font = [UIFont systemFontOfSize:12];
        [self.backImageView addSubview:self.lengthLabel];
    }
    return [[_lengthLabel retain]autorelease];
}

//  正在播放标示
//- (UILabel *)playingLabel{
//
//    if (_playingLabel == nil) {
//  
//        self.playingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.6*self.backImageView.frame.size.width, 0.6*self.backImageView.frame.size.height, 0.4*self.backImageView.frame.size.width, 0.4*self.backImageView.frame.size.height)];
//        self.playingLabel.text = @"正在播放";
//        self.playingLabel.textColor = [UIColor redColor];
//        self.playingLabel.alpha = 0;
//        [self.backImageView addSubview:self.playingLabel];
//    }
//    return [[_playingLabel retain]autorelease];
//}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
