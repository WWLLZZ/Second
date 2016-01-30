//
//  TNDetailiModel.h
//  FeiFanNews
//
//  Created by laouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDetailiModel : NSObject
//@property(nonatomic,copy)NSString *photo;//t图片
//@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *date;//日期
//@property(nonatomic,copy)NSString *local_time;
@property(nonatomic,assign)NSString *day;
@property (nonatomic , retain) NSArray *waypoints;
@end
