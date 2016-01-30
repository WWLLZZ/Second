//
//  VideoMainModel.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoMainModel : NSObject


//videoList
@property(nonatomic,copy)NSString *title;//视频标题
@property(nonatomic,copy)NSString *descriptionTitle;//视频副标题
@property(nonatomic,copy)NSString *cover;//视图截图
@property(nonatomic,assign)NSInteger length;//视图时长
@property(nonatomic,assign)NSInteger playCount;//播放次数
@property(nonatomic,assign)NSInteger replyCount;//评论次数
@property(nonatomic,copy)NSString *mp4_url;//视频地址
@property(nonatomic,copy)NSString *vid;//视频id




@end
