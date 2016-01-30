//
//  RadioRecommendViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/4.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioRecommendViewCell.h"
#import "RadioPlayModel.h"
#import "FeiFanHeader.h"

@interface RadioRecommendViewCell ()



@end


@implementation RadioRecommendViewCell

- (void)dealloc
{
    self.backImageView = nil;
    self.titleLabel = nil;
    self.ptimeLabel = nil;
    [super dealloc];
}

- (void)assignValueByModel:(RadioPlayModel *)model{

    self.titleLabel.text = model.title;
    self.ptimeLabel.text = model.ptime;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backImageView];
        
    }
    return self;
}

- (UIImageView *)backImageView{

    if (_backImageView == nil) {
        self.backImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.1875*MAIN_SCREEN_WIDTH)]autorelease];
        self.backImageView.image = [UIImage imageNamed:@"tea.jpg"];
        [self.backImageView addSubview:self.titleLabel];
        [self.backImageView addSubview:self.ptimeLabel];
    }
    return [[_backImageView retain]autorelease];
}

- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.0312*MAIN_SCREEN_WIDTH, 0.0156*MAIN_SCREEN_WIDTH, 0.937*MAIN_SCREEN_WIDTH, 0.0937*MAIN_SCREEN_WIDTH)]autorelease];
//        self.titleLabel.backgroundColor = [UIColor redColor];
    }
    return [[_titleLabel retain]autorelease];
}

- (UILabel *)ptimeLabel{
    if (_ptimeLabel == nil) {
        self.ptimeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0.67*MAIN_SCREEN_WIDTH, 0.14*MAIN_SCREEN_WIDTH, 0.28*MAIN_SCREEN_WIDTH, 0.032*MAIN_SCREEN_WIDTH)]autorelease];
//        self.ptimeLabel.backgroundColor = [UIColor greenColor];
        self.ptimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return [[_ptimeLabel retain]autorelease];
}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
