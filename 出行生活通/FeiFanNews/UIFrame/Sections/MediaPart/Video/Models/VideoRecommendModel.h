//
//  VideoRecommendModel.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoRecommendModel : NSObject

@property(nonatomic,copy)NSString *cover;//图片
@property(nonatomic,copy)NSString *title;//视频标题
@property(nonatomic,copy)NSString *mp4_url;//视频地址
@property(nonatomic,assign)NSInteger length;//视频长度
@property(nonatomic,copy)NSString *videoid;

@end
