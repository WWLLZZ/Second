//
//  DataBaseHandle.h
//  FeiFanNews
//
//  Created by lanouhn on 15/11/6.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@class VideoMainModel;

@class StoryModel;
@class TNModel;
@class RadioMainModel;


@interface DataBaseHandle : NSObject
@property(nonatomic,retain)FMDatabase *db;

+ (DataBaseHandle *)shareDataBaseHandle;
- (NSString *)dataBasePath;
- (void)createMediaBase;
//video
- (void)createVideoTable;
- (void)insertVideoTable:(VideoMainModel *)model;
- (BOOL)hasVideoBy:(NSString *)title;
- (void)deleteVideoByTitle:(NSString *)title;
- (void)deleteAllVideo;
- (NSMutableArray *)selectAllVideo;

//radio
- (void)createRadioTable;
- (void)insertRadioTable:(RadioMainModel *)model;
- (BOOL)hasRadioBy:(NSString *)tname;
- (void)deleteRadioByTname:(NSString *)tname;
- (void)deleteAllRadio;
- (NSMutableArray *)selectAllRadio;



//故事
- (void)createStory;
- (void)insertStory:(StoryModel *)story;
- (BOOL)hasStoryByID:(NSString *)ID;
- (void)deleteStoryByID:(NSString *)ID;
- (NSMutableArray *)selectAllStroy;


//游记
- (void)creatTN;
- (void)insertTN:(TNModel *)tn;
- (BOOL)hasTNByid:(NSString *)titleName;
- (void)deleteTNByid:(NSString *)titleName;
- (NSMutableArray *)selectAllTN;

@end
