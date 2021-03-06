//
//  DataBaseHandle.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/6.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DataBaseHandle.h"
#import "FMDB.h"
#import "VideoPlayingViewController.h"
#import "VideoMainModel.h"

#import "StoryModel.h"
#import "TNModel.h"

#import "RadioMainModel.h"


@implementation DataBaseHandle

- (void)dealloc
{
    self.db = nil;
    [super dealloc];
}

#pragma mark 建数据库

static DataBaseHandle *handle;
+ (DataBaseHandle *)shareDataBaseHandle{

    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        handle = [[DataBaseHandle alloc]init];
    });
    return handle;
    
}
- (NSString *)dataBasePath{

//    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]);
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"news.sqlite"];
    
    
}
- (void)createMediaBase{
    self.db = [FMDatabase databaseWithPath:[self dataBasePath]];
    [self.db open];

    
}

#pragma mark 视频表格

- (void)createVideoTable{
    
    [self.db executeUpdate:@"create table if not exists VideoList(id integer primary key autoincrement,title text,mp4_url text,videoID text)"];
    
}
- (void)insertVideoTable:(VideoMainModel *)model{
    
    [self.db executeUpdate:@"insert into VideoList(title,mp4_url,videoID)values(?,?,?)",model.title,model.mp4_url,model.vid];
    
}

//判断表中有无该视频,有的话不再添加,点击删除
- (BOOL)hasVideoBy:(NSString *)title{
    FMResultSet *set = [self.db executeQuery:@"select *from VideoList where title = ?",title];
    NSString *str = nil;
    while ([set next]) {
        str = [set stringForColumn:@"title"];
//        NSLog(@"%@",str);
    }
    return [str isEqualToString:title] ? YES : NO;
    
    
}
- (void)deleteVideoByTitle:(NSString *)title{
    
    [self.db executeUpdate:@"delete from VideoList where title = ?",title];
    
    
    
}

- (void)deleteAllVideo{
    
    [self.db executeUpdate:@"delete from VideoList"];
    
}


- (NSMutableArray *)selectAllVideo{
    
    FMResultSet *set = [self.db executeQuery:@"select *from VideoList"];
    NSMutableArray *arr  = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        VideoMainModel *model = [[VideoMainModel alloc]init];
        model.title = [set stringForColumn:@"title"];
        model.vid = [set stringForColumn:@"videoID"];
        model.mp4_url = [set stringForColumn:@"mp4_url"];
        
        [arr addObject:model];
        [model release];
    }
    return arr;
}


#pragma mark radio
- (void)createRadioTable{
    
    [self.db executeUpdate:@"create table if not exists radioList(id integer primary key autoincrement,tname text,tid text)"];
    
    
}
- (void)insertRadioTable:(RadioMainModel *)model{
    
    [self.db executeUpdate:@"insert into radioList(tname,tid)values(?,?)",model.tname,model.tid];
    
    
}
- (BOOL)hasRadioBy:(NSString *)tname{
    
    FMResultSet *set = [self.db executeQuery:@"select *from radioList where tname = ?",tname];
    NSString *str = nil;
    while ([set next]) {
        str = [set stringForColumn:@"tname"];
//        NSLog(@"%@",str);
    }
    return [str isEqualToString:tname] ? YES : NO;
    
}
- (void)deleteRadioByTname:(NSString *)tname{
    
    [self.db executeUpdate:@"delete from radioList where tname = ?",tname];
    
    
}
- (void)deleteAllRadio{
    
    [self.db executeUpdate:@"delete from radioList"];
    
    
    
}
- (NSMutableArray *)selectAllRadio{
    
    FMResultSet *set = [self.db executeQuery:@"select *from radioList"];
    NSMutableArray *arr  = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        RadioMainModel *model = [[RadioMainModel alloc]init];
        model.tname = [set stringForColumn:@"tname"];
        model.tid = [set stringForColumn:@"tid"];
        
        [arr addObject:model];
        [model release];
    }
    return arr;
}





//创建故事表
- (void)createStory{
    if ([self.db open]) {
        BOOL isCreatStory = [self.db executeUpdate:@"create table if not exists Story(id integer primary key autoincrement,index_cover text,index_title text,name text,avatar_s text,spot_id text)"];
//        NSLog(@"%@",isCreatStory ? @"创建表格成功" : @"创建表格失败");
        
    }else{
//        NSLog(@"打开失败");
        
    }
    
}
//插入数据
- (void)insertStory:(StoryModel *)story{
    BOOL isInsert = [self.db executeUpdate:@"insert into Story(index_title,index_cover,name,avatar_s,spot_id)values(?,?,?,?,?)",story.index_title,story.index_cover,story.name,story.avatar_s,story.spot_id];
//    NSLog(@"%@",isInsert ? @"插入成功":@"插入失败");
}
//根据标题判断是否已经收藏
- (BOOL)hasStoryByID:(NSString *)index_title{
    FMResultSet *set = [self.db executeQuery:@"select *from Story where index_title = ?",index_title];
    NSString *str = nil;
    while ([set next]) {
        str = [set stringForColumn:@"index_title"];
    }
    return [str isEqualToString:index_title] ? YES : NO;
}
//根基标题删除数据
- (void)deleteStoryByID:(NSString *)index_title{
    BOOL isDelegate = [self.db executeUpdate:@"delete from Story where index_title = ?",index_title];
//    NSLog(@"%@",isDelegate ? @"删除成功" : @"删除失败");
    
}
//查找全部表格
- (NSMutableArray *)selectAllStroy;{
    FMResultSet *set = [self.db executeQuery:@"select *from Story"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        StoryModel *story = [[StoryModel alloc]init];
        story.index_title = [set stringForColumn:@"index_title"];
        story.index_cover = [set stringForColumn:@"index_cover"];
        story.name = [set stringForColumn:@"name"];
        story.avatar_s = [set stringForColumn:@"avatar_s"];
        story.spot_id = [set stringForColumn:@"spot_id"];
        [arr addObject:story];
        [story release];
    }
    return arr;
    
}

//游记
- (void)creatTN{
    if ([self.db open]) {
        BOOL isCreatStory = [self.db executeUpdate:@"create table if not exists TN(id integer primary key autoincrement,titleName text,id1 text)"];
//        NSLog(@"%@",isCreatStory ? @"创建表格成功" : @"创建表格失败");
        
    }else{
//        NSLog(@"打开失败");
        
    }
    
}
- (void)insertTN:(TNModel *)tn{
    BOOL isInsert = [self.db executeUpdate:@"insert into TN(titleName,id1)values(?,?)",tn.titleName,tn.id1];
//    NSLog(@"%@",isInsert ? @"插入成功":@"插入失败");
    
    
}
- (BOOL)hasTNByid:(NSString *)titleName{
    FMResultSet *set = [self.db executeQuery:@"select *from TN where titleName = ?",titleName];
    NSString *str = nil;
    while ([set next]) {
        str = [set stringForColumn:@"titleName"];
    }
    return [str isEqualToString:titleName] ? YES : NO;
}
- (void)deleteTNByid:(NSString *)titleName{
    BOOL isDelegate = [self.db executeUpdate:@"delete from TN where titleName= ?",titleName];
//    NSLog(@"%@",isDelegate ? @"删除成功" : @"删除失败");
    
}
- (NSMutableArray *)selectAllTN{
    FMResultSet *set = [self.db executeQuery:@"select *from TN"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        TNModel *tn = [[TNModel alloc]init];
        
        tn.id1 = [set stringForColumn:@"id1"];
        
        tn.titleName = [set stringForColumn:@"titleName"];
        [arr addObject:tn];
        [tn release];
    }
    return arr;
    
    
    
}




@end
