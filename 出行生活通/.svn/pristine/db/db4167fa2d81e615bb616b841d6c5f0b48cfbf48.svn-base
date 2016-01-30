//
//  RadioListViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioListViewCell.h"
#import "FeiFanHeader.h"
#import "RadioMainModel.h"
#import "UIImageView+WebCache.h"

@interface RadioListViewCell ()

@property(nonatomic,retain)UILabel *tnameLabel;//电台名
@property(nonatomic,retain)UILabel *titleLabel;//音乐名
@property(nonatomic,retain)UILabel *playCountLabel;//播放量
@property(nonatomic,retain)UIImageView *imgsrcView;//电台图
@property(nonatomic,retain)UIImageView *backImageView;//cell背景
@property(nonatomic,retain)UIImageView *playCountView;//播放图标

@end

@implementation RadioListViewCell

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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backImageView];
        
        
    }
    return self;
}

//背景图
- (UIImageView *)backImageView{
    
    if (_backImageView == nil) {
        self.backImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.25*MAIN_SCREEN_WIDTH)]autorelease];
        self.backImageView.image = [UIImage imageNamed:@"tea.jpg"];
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
        self.imgsrcView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.0156*MAIN_SCREEN_WIDTH,0.0156*MAIN_SCREEN_WIDTH,0.219*MAIN_SCREEN_WIDTH,0.219*MAIN_SCREEN_WIDTH)]autorelease];
        self.imgsrcView.backgroundColor = [UIColor redColor];
        self.imgsrcView.layer.cornerRadius = MAIN_SCREEN_WIDTH/16;
        self.imgsrcView.layer.masksToBounds = YES;
        
    }
    return [[_imgsrcView retain]autorelease];
}


//电台名
- (UILabel *)tnameLabel{
    
    if (_tnameLabel == nil) {
        self.tnameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.25*MAIN_SCREEN_WIDTH,0.0312*MAIN_SCREEN_WIDTH,0.525*MAIN_SCREEN_WIDTH,0.0625*MAIN_SCREEN_WIDTH)]autorelease];
        self.tnameLabel.font = [UIFont systemFontOfSize:15];
//        self.tnameLabel.textAlignment = NSTextAlignmentCenter;
//        self.tnameLabel.backgroundColor = [UIColor greenColor];
    }
    return [[_tnameLabel retain]autorelease];
}

//音乐名
- (UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.25*MAIN_SCREEN_WIDTH,0.125*MAIN_SCREEN_WIDTH,0.7187*MAIN_SCREEN_WIDTH,0.0937*MAIN_SCREEN_WIDTH)]autorelease];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.alpha = 0.6;
//                self.titleLabel.backgroundColor = [UIColor blueColor];
    }
    return [[_titleLabel retain]autorelease];
}

- (UIImageView *)playCountView{
    
    if (_playCountView == nil) {
        self.playCountView = [[[UIImageView alloc]initWithFrame:CGRectMake(0.78*MAIN_SCREEN_WIDTH,0.0312*MAIN_SCREEN_WIDTH,0.05*MAIN_SCREEN_WIDTH,0.05*MAIN_SCREEN_WIDTH)]autorelease];
        self.playCountView.image = [UIImage imageNamed:@"cell_tag_audio@2x"];
    }
    return [[_playCountView retain]autorelease];
}

- (UILabel *)playCountLabel{
    
    if (_playCountLabel == nil) {
        self.playCountLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.85*MAIN_SCREEN_WIDTH,0.0312*MAIN_SCREEN_WIDTH,0.13*MAIN_SCREEN_WIDTH,0.0625*MAIN_SCREEN_WIDTH)]autorelease];
        self.playCountLabel.font = [UIFont systemFontOfSize:10];
        self.playCountLabel.alpha = 0.6;
//                self.playCountLabel.backgroundColor = [UIColor yellowColor];
    }
    return [[_playCountLabel retain]autorelease];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
