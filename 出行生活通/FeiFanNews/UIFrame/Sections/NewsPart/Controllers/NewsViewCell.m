//
//  NewsViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewsViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface NewsViewCell ()
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UIImageView *picImageView;
@property (nonatomic,retain)UILabel *ptimeLabel;
@property (nonatomic,retain)UILabel *digestLabel;
@property (nonatomic,retain)UILabel *votecountLabel;
@end

@implementation NewsViewCell
- (void)dealloc
{
    self.votecountLabel = nil;
    self.titleLabel = nil;
    self.picImageView = nil;
    self.ptimeLabel = nil;
    self.digestLabel = nil;
    [super dealloc];
}


- (UIImageView *)picImageView{
    if (_picImageView == nil) {
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, 5.f, kScreenWidth * 0.35, 105)];
        self.picImageView.backgroundColor = [UIColor cyanColor];
        self.picImageView.layer.cornerRadius = 7;
        self.picImageView.layer.masksToBounds = YES;
    }
    return [[_picImageView retain]autorelease];
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 10, CGRectGetMinY(self.picImageView.frame), kScreenWidth * 0.6, 30.f)];
//        self.titleLabel.backgroundColor = [UIColor greenColor];
//        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:13];
    }
    return [[_titleLabel retain]autorelease];
}
- (UILabel *)digestLabel {
    if (_digestLabel == nil) {
        self.digestLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+50, kScreenWidth * 0.55, self.textLabel.bounds.size.height - 45.f)];
//        self.digestLabel.backgroundColor = [UIColor redColor];
        self.digestLabel.font = [UIFont systemFontOfSize:12];
        self.digestLabel.numberOfLines = 0;
    }
    return [[_digestLabel retain]autorelease];
}

- (UILabel *)votecountLabel{
    if (_votecountLabel == nil) {
        self.votecountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame)+100, CGRectGetMaxY(self.digestLabel.frame)+10, 150, 15)];
        self.votecountLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:13];
    }
    return [[_votecountLabel retain]autorelease];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.digestLabel];
        [self.contentView addSubview:self.votecountLabel];
    }
    return self;
}
- (void)assginValueByMovie:(NewsModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"open"]];
    self.titleLabel.text = model.title;
    self.digestLabel.text = model.digest;

    NSString *vote = [NSString stringWithFormat:@"%ld",model.votecount];
    self.votecountLabel.text = [vote stringByAppendingString:@"跟帖"];
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
