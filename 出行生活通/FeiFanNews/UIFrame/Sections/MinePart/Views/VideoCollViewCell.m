//
//  VideoCollViewCell.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/6.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoCollViewCell.h"

@implementation VideoCollViewCell

- (void)dealloc
{
    self.titleLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:self.frame]autorelease];
        self.titleLabel.backgroundColor = [UIColor greenColor];
    }
    return [[_titleLabel retain]autorelease];
}














- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
