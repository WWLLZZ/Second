//
//  NewsMoreViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewsMoreViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface NewsMoreViewCell ()
@property (nonatomic,retain)UIImageView *firstView;
@property (nonatomic,retain)UIImageView *secondView;
@property (nonatomic,retain)UIImageView *thirdView;
@property (nonatomic,retain)UILabel     *titleLabel;

@end

@implementation NewsMoreViewCell
- (void)dealloc
{
    self.firstView = nil;
    self.secondView = nil;
    self.thirdView = nil;
    [super dealloc];
}

- (UIImageView *)firstView{
    if (_firstView == nil) {
        self.firstView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, kScreenWidth * 0.3, 80)];
        self.firstView.layer.cornerRadius = 5;
        self.firstView.layer.masksToBounds = YES;
    }
    return [[_firstView retain]autorelease];
}
- (UIImageView *)secondView{
    if (_secondView == nil) {
        self.secondView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.firstView.frame)+10, 20, kScreenWidth * 0.3, 80)];
        self.secondView.layer.cornerRadius = 5;
        self.secondView.layer.masksToBounds = YES;
    }
    return [[_secondView retain]autorelease];
}

- (UIImageView *)thirdView{
    if (_thirdView == nil) {
        self.thirdView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.secondView.frame)+10, 20, kScreenWidth * 0.3, 80)];
        self.thirdView.layer.cornerRadius = 5;
        self.thirdView.layer.masksToBounds = YES;
    }
    return [[_thirdView retain]autorelease];
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 15)];
        self.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return [[_titleLabel retain]autorelease];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.firstView];
        [self.contentView addSubview:self.secondView];
        [self.contentView addSubview:self.thirdView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)assginValueByMovie:(NewsModel *)model{
   
    NSMutableDictionary *imageDic = model.imgextra[0];
    [self.secondView sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"open"]];
    NSMutableDictionary *imageDic1 = model.imgextra[1];
    [self.thirdView sd_setImageWithURL:[NSURL URLWithString:imageDic1[@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"open"]];
   
    [self.firstView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"open"]];
    self.titleLabel.text = model.title;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
