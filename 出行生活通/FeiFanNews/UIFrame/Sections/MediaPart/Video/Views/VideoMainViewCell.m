//
//  VideoMainViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoMainViewCell.h"
#import "VideoMainModel.h"
#import "UIImageView+WebCache.h"
#import "FeiFanHeader.h"
#define kCellHeight 0.44*MAIN_SCREEN_HEIGHT

@interface VideoMainViewCell ()



@end


@implementation VideoMainViewCell

- (void)dealloc
{
//    self.shareButton = nil;
    self.playButton = nil;
    self.lengthView = nil;
    self.playCountView = nil;
    self.titleLabel = nil;
    self.descriptionLabel = nil;
    self.lengthLabel = nil;
    self.coverImageView = nil;
    self.playCountLabel = nil;
    self.replyCountLabel = nil;
    self.backImageView = nil;
    
    [super dealloc];
}



- (void)assignValueByVideoMainModel:(VideoMainModel *)model{

    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"tea.jpg"]];

    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.descriptionTitle;
    self.lengthLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",model.length/60,model.length % 60];
    self.playCountLabel.text = [NSString stringWithFormat:@"%.2f万",(CGFloat)model.playCount/10000];
    self.replyCountLabel.text = [NSString stringWithFormat:@"已有%ld人评论",model.replyCount];

}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backImageView.userInteractionEnabled = YES;
        self.coverImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.backImageView];
        
    }
    return self;
}

- (UIImageView *)backImageView{

    if (_backImageView == nil) {
        self.backImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.44*MAIN_SCREEN_HEIGHT)]autorelease];
        self.backImageView.image = [UIImage imageNamed:@"tea.jpg"];
        [self.backImageView addSubview:self.lengthView];
        [self.backImageView addSubview:self.playCountView];

    }

    return [[_backImageView retain]autorelease];
}


- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.016*MAIN_SCREEN_WIDTH, 0.02*kCellHeight, 0.968*MAIN_SCREEN_WIDTH, 0.08*kCellHeight)]autorelease];
        [self.backImageView addSubview:self.titleLabel];
        
    }
    return [[_titleLabel retain]autorelease];
}

- (UILabel *)descriptionLabel{
    
    if (_descriptionLabel == nil) {
        self.descriptionLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.016*MAIN_SCREEN_WIDTH, 0.1*kCellHeight, 0.968*MAIN_SCREEN_WIDTH, 0.04*kCellHeight)]autorelease];
        self.descriptionLabel.font = [UIFont systemFontOfSize:10];
        self.descriptionLabel.alpha = 0.6;
        [self.backImageView addSubview:self.descriptionLabel];

    }
    
    return [[_descriptionLabel retain]autorelease];
}


- (UIImageView *)coverImageView{
    
    if (_coverImageView == nil) {
        self.coverImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.016*MAIN_SCREEN_WIDTH, 0.16*kCellHeight, 0.968*MAIN_SCREEN_WIDTH, 0.72*kCellHeight)]autorelease];
        self.coverImageView.layer.cornerRadius = 12;
        self.coverImageView.layer.masksToBounds = YES;
        [self.backImageView addSubview:self.coverImageView];
        [self.coverImageView addSubview:self.playButton];
    }
    return [[_coverImageView retain]autorelease];
}

- (UIImageView *)lengthView{

    if (_lengthView == nil) {
        self.lengthView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.016*MAIN_SCREEN_WIDTH, 0.9*kCellHeight, 0.0625*MAIN_SCREEN_WIDTH, 0.0625*MAIN_SCREEN_WIDTH)]autorelease];
        self.lengthView.image = [UIImage imageNamed:@"video_list_cell_time@2x"];
        
    }
    return [[_lengthView retain]autorelease] ;
}

- (UILabel *)lengthLabel{
    
    if (_lengthLabel == nil) {
        self.lengthLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.1*MAIN_SCREEN_WIDTH, 0.9*kCellHeight, 0.125*MAIN_SCREEN_WIDTH, 0.0625*MAIN_SCREEN_WIDTH)]autorelease];
        self.lengthLabel.font = [UIFont systemFontOfSize:10];
        self.lengthLabel.alpha = 0.6;
        [self.backImageView addSubview:self.lengthLabel];
    }
    return [[_lengthLabel retain]autorelease];
}

- (UIImageView *)playCountView{

    if (_playCountView == nil) {
        self.playCountView = [[UIImageView alloc]initWithFrame:CGRectMake(0.21*MAIN_SCREEN_WIDTH, 0.9*kCellHeight, 0.0625*MAIN_SCREEN_WIDTH, 0.0625*MAIN_SCREEN_WIDTH)];
        self.playCountView.image = [UIImage imageNamed:@"video_list_cell_count@2x"];
 
        
    }
    return [[_playCountView retain]autorelease];
}

- (UILabel *)playCountLabel{
    
    if (_playCountLabel == nil) {
        self.playCountLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.305*MAIN_SCREEN_WIDTH, 0.9*kCellHeight, 0.125*MAIN_SCREEN_WIDTH, 0.0625*MAIN_SCREEN_WIDTH)]autorelease];
        self.playCountLabel.font = [UIFont systemFontOfSize:10];
        self.playCountLabel.alpha = 0.6;
        [self.backImageView addSubview:self.playCountLabel];
    }
    return [[_playCountLabel retain]autorelease];
}

- (UILabel *)replyCountLabel{
    
    if (_replyCountLabel == nil) {
        self.replyCountLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.6*MAIN_SCREEN_WIDTH, 0.9*kCellHeight, 0.25*MAIN_SCREEN_WIDTH, 0.0625*MAIN_SCREEN_WIDTH)]autorelease];
        self.replyCountLabel.font = [UIFont systemFontOfSize:10];
        self.replyCountLabel.alpha = 0.6;
        [self.backImageView addSubview:self.replyCountLabel];
    }
    return [[_replyCountLabel retain]autorelease];
}

- (UIButton *)playButton{

    if (_playButton == nil) {
        self.playButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.playButton.frame = CGRectMake(0.484*MAIN_SCREEN_WIDTH-20, 0.36*kCellHeight-20, 40, 40);
//        self.playButton.center = self.coverImageView.center;
        [self.playButton setImage:[UIImage imageNamed:@"video_play_medium@2x"] forState:(UIControlStateNormal)];
    }
    return _playButton;
}

//- (UIButton *)shareButton{
//
//    if (_shareButton == nil) {
//        self.shareButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.shareButton.frame = CGRectMake(0.85*MAIN_SCREEN_WIDTH, 0.9*kCellHeight, 0.0625*MAIN_SCREEN_WIDTH, 0.0625*MAIN_SCREEN_WIDTH);
//        [self.shareButton setImage:[UIImage imageNamed:@"night_video_category_share@2x"] forState:(UIControlStateNormal)];
//        [self.backImageView addSubview:self.shareButton];
//    }
//    return _shareButton;
//}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
