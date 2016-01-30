//
//  NewsModel.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (nonatomic,copy)NSString *photosetID;
@property (nonatomic,copy)NSString *tid;
@property (nonatomic,copy)NSString *tname;
@property (nonatomic,copy)NSString *digest;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *imgsrc;
@property (nonatomic,copy)NSString *skipType;
@property (nonatomic,assign)NSInteger imgType;
@property (nonatomic,retain)NSMutableArray *imgextra;
@property (nonatomic,assign)NSInteger votecount;
@property (nonatomic,retain)NSString *docid;
@property (nonatomic,retain)NSString *body;
@property (nonatomic,retain)NSMutableArray *img;
@property (nonatomic,retain)NSString *ptime;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *setname;
@property (nonatomic,retain)NSMutableArray *photos;
@property (nonatomic,retain)NSString *imgtitle;
@property (nonatomic,retain)NSString *note;
@property (nonatomic,retain)NSMutableArray *ads;

//图片的尺寸
@property (nonatomic,copy)NSString *pixel;
//图片的位置
@property (nonatomic,copy)NSString *ref;
@property (nonatomic,copy)NSString *src;
@property (nonatomic,copy)NSString *squareimgurl;
//保存视频
@property (nonatomic,retain)NSMutableArray *video;
//视频的网址
@property (nonatomic,retain)NSString *url_mp4;
+(instancetype)detailImageWithDic:(NSDictionary *)dict;
@end
