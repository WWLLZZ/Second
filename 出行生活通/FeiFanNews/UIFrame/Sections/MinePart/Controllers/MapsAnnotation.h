//
//  MapsAnnotation.h
//  FeiFanNews
//
//  Created by lanouhn on 15/11/5.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapsAnnotation : NSObject<MKAnnotation>
@property (nonatomic)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;
@property (nonatomic,retain)UIImage *image;
#pragma mark 大头针详情左侧图标
@property (nonatomic,retain) UIImage *icon;
#pragma mark 大头针详情描述
@property (nonatomic,retain) NSString *detail;
#pragma mark 大头针右下方星级评价
@property (nonatomic,retain) NSString *name;

@end
