//
//  NewsBigViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewsBigViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface NewsBigViewCell ()

@property (nonatomic,retain)UIImageView *imageBigView;
@property (nonatomic,retain)UILabel     *titleLabel;
@property (nonatomic,retain)UILabel     *digestLabel;

@end

@implementation NewsBigViewCell
- (void)dealloc
{
    self.imageBigView = nil;
    self.titleLabel = nil;
    self.digestLabel = nil;
    [super dealloc];
}
- (UIImageView *)imageBigView{
    if (_imageBigView == nil) {
        self.imageBigView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, kScreenWidth-10, 60)];
        self.imageBigView.layer.cornerRadius = 7;
        self.imageBigView.layer.masksToBounds = YES;
    }
    return [[_imageBigView retain]autorelease];
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 15)];
        self.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:13];
    }
    return [[_titleLabel retain]autorelease];
}

- (UILabel *)digestLabel{
    if (_digestLabel == nil) {
        self.digestLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageBigView.frame)+2, kScreenWidth-10, 30)];
        self.digestLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:13];
        self.digestLabel.numberOfLines = 0;
    }
    return [[_digestLabel retain]autorelease];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    [self.contentView addSubview:self.imageBigView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.digestLabel];
    }
    return self;
}
- (void)assginValueByMovie:(NewsModel *)model{
    [self.imageBigView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"open"]];
    self.titleLabel.text = model.title;
    self.digestLabel.text = model.digest;
}

- (void)awakeFromNib {
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
