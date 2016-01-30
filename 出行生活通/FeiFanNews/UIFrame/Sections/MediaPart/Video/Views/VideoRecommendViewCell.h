//
//  VideoRecommendViewCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoRecommendModel;

@interface VideoRecommendViewCell : UITableViewCell

//@property(nonatomic,retain)UILabel *playingLabel;//正在播放标示
- (void)assignValueByVideoRecommendModel:(VideoRecommendModel *)model;


@end
