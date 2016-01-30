//
//  KindVideoViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/31.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "KindVideoViewController.h"
#import "VideoMainModel.h"
#import "VideoMainViewCell.h"
#import "FeiFanHeader.h"
#import "AFNetworking.h"
#import "VideoPlayingViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#define kMaincell @"videoMain-cell"

@interface KindVideoViewController ()

@property(nonatomic,retain)MPMoviePlayerController *mediaPlayer;//播放器
@property(nonatomic,copy)NSString *mp4_url;//视频地址
@property(nonatomic,retain)MBProgressHUD *hud;
@property(nonatomic,retain)NSMutableArray *dataSource;//储存网络请求数据
@property(nonatomic,assign)NSInteger page;//页数

@end

@implementation KindVideoViewController

- (void)dealloc
{
    self.mediaPlayer = nil;
    self.mp4_url = nil;
    self.hud = nil;
    self.dataSource = nil;
    self.sid = nil;
    [super dealloc];
}

//初始化数组
- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataSource retain]autorelease];
}

////隐藏tabBar
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = self.kindName;
    //注册cell
    [self.tableView registerClass:[VideoMainViewCell class] forCellReuseIdentifier:kMaincell];
    [self readDataFromURL];
    [self refreshData];
    [self buildLoading];
    
}

- (void)refreshData{
    
   
    //下拉刷新
    [self.tableView addHeaderWithCallback:^{
        self.page = 0;
        [self readDataFromURL];
    }];
    
    //上拉加载
    [self.tableView addFooterWithCallback:^{
        self.page += 11;
        [self readDataFromURL];
    }];
    [self.tableView headerBeginRefreshing];
//    [self.tableView footerBeginRefreshing];
    
}

#pragma mark loading图
- (void)buildLoading{
    
    self.hud = [[[MBProgressHUD alloc]init]autorelease];
    self.hud.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) ;
    self.hud.minSize = CGSizeMake(50, 50);
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    
}

#pragma mark 读取网络数据

- (void)readDataFromURL{
    
    NSString *urlStr = [NSString stringWithFormat:VIEDO_KINDVIDEO_URL,self.sid,self.page];
    
    //创建请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置支持的数据格式
    
    //请求数据
    __block typeof(self) weakSelf = self;
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //读取完数据关闭loading
        [self.hud hide:YES];
        
        //获取视频列表
        NSMutableArray *mArray = [responseObject valueForKey:self.sid];
        NSMutableArray *currentArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in mArray) {
            VideoMainModel *model = [[VideoMainModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            model.descriptionTitle = [dic valueForKey:@"description"];
            if ([model.title rangeOfString:@"下体"].location == NSNotFound  &&[model.title rangeOfString:@"高潮"].location == NSNotFound  &&[model.title rangeOfString:@"裸体"].location == NSNotFound && [model.title rangeOfString:@"强奸"].location == NSNotFound &&[model.title rangeOfString:@"黑鬼"].location == NSNotFound &&[model.title rangeOfString:@"胸"].location == NSNotFound && [model.title rangeOfString:@"乳"].location == NSNotFound &&
                [model.title rangeOfString:@"上床"].location == NSNotFound &&
                [model.descriptionTitle rangeOfString:@"下体"].location == NSNotFound && [model.title rangeOfString:@"打飞机"].location == NSNotFound
                )
            {
                
                [currentArray addObject:model];
            }
            
            [model release];
        }
        
        //当page值为1的时候,self.dataSource中只存放第一页的数据
        if (0 == weakSelf.page) {
            weakSelf.dataSource = [NSMutableArray arrayWithArray:currentArray];
            [self.tableView headerEndRefreshing];
            
        }else{
            //当page值为其他数值时,将临时数组中的数据拼接到self.dataSource
            [weakSelf.dataSource addObjectsFromArray:currentArray];
            [self.tableView footerEndRefreshing];
        }
//                NSLog(@"%@",weakSelf.dataSource);
        
        //刷新UI
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoMainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMaincell forIndexPath:indexPath];
    VideoMainModel *model = self.dataSource[indexPath.row];
    [cell assignValueByVideoMainModel:model];
    
    [cell.playButton addTarget:self action:@selector(handlePlay:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

#pragma mark 点击cell上播放button
- (void)handlePlay:(UIButton *)button{
    
    VideoMainViewCell *cell = (VideoMainViewCell *)button.superview.superview.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    self.mp4_url = [self.dataSource[index.row] valueForKey:@"mp4_url"];
    
    [self.mediaPlayer.view removeFromSuperview];
    //配置播放器
    self.mediaPlayer = [[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.mp4_url]] autorelease];

    [self.mediaPlayer.view setFrame:CGRectMake(0.016*MAIN_SCREEN_WIDTH,index.row*0.44*MAIN_SCREEN_HEIGHT+0.07*MAIN_SCREEN_HEIGHT, 0.972*MAIN_SCREEN_WIDTH, 0.317*MAIN_SCREEN_HEIGHT)];
    [self.tableView addSubview:self.mediaPlayer.view];
//    self.mediaPlayer.view.userInteractionEnabled = YES;
    self.mediaPlayer.shouldAutoplay = YES;//自动播放
    //    [self.mediaPlayer setFullscreen:YES animated:YES];
    self.mediaPlayer.scalingMode = MPMovieScalingModeFill;//适应屏幕大小,保持宽高比.可剪裁
    
    [self.mediaPlayer play];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.44*MAIN_SCREEN_HEIGHT;
}

#pragma mark //跳转到视频播放页面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.mediaPlayer.view removeFromSuperview];
    
    VideoPlayingViewController *videoPlayerVC = [[VideoPlayingViewController alloc]init];
    //跳转前传值
    videoPlayerVC.mp4_url = [self.dataSource[indexPath.row] valueForKey:@"mp4_url"];
    videoPlayerVC.videoID = [self.dataSource[indexPath.row] valueForKey:@"vid"];
    videoPlayerVC.videoName = [self.dataSource[indexPath.row] valueForKey:@"title"];
    
    [self.navigationController pushViewController:videoPlayerVC animated:YES];
    [videoPlayerVC release];
    
    
}

#pragma mark 返回之前让tabBar出现
- (void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
    
    [self.mediaPlayer stop];
   
//    self.tabBarController.tabBar.hidden = NO;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
