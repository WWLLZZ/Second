//
//  RadioMainModel.h
//  FeiFanNews
//
//  Created by lanouhn on 15/11/2.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioMainModel : NSObject



//电台
@property(nonatomic,copy)NSString *tname;//电台名
@property(nonatomic,copy)NSString *title;//音乐名
@property(nonatomic,copy)NSString *docid;//电台id
@property(nonatomic,copy)NSString *playCount;//播放次数
@property(nonatomic,copy)NSString *imgsrc;//电台图片
@property(nonatomic,copy)NSString *tid;//推荐列表id



@end
