//
//  VideoMainViewCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoMainModel;

@interface VideoMainViewCell : UITableViewCell

@property(nonatomic,retain)UIButton *playButton;//播放按钮
@property(nonatomic,retain)UIImageView *backImageView;//背景图
@property(nonatomic,retain)UILabel *titleLabel;//标题
@property(nonatomic,retain)UILabel *descriptionLabel;//副标题
@property(nonatomic,retain)UIImageView *coverImageView;//图片
@property(nonatomic,retain)UILabel *lengthLabel;//视频长度
@property(nonatomic,retain)UILabel *playCountLabel;//播放量
@property(nonatomic,retain)UILabel *replyCountLabel;//评论数;
@property(nonatomic,retain)UIImageView *lengthView;//影长图
@property(nonatomic,retain)UIImageView *playCountView;//播放量图
//@property(nonatomic,retain)UIButton *shareButton;//分享

//提供赋值接口
- (void)assignValueByVideoMainModel:(VideoMainModel *)model;


@end
