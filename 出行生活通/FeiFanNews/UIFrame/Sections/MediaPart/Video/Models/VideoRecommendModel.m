//
//  VideoRecommendModel.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoRecommendModel.h"

@implementation VideoRecommendModel

- (void)dealloc
{
    self.cover = nil;
    self.mp4_url = nil;
    self.title = nil;
    self.videoid = nil;
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}



@end
