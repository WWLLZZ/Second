//
//  VideoPlayingViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoPlayingViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FeiFanHeader.h"
#import "AFNetworking.h"
#import "VideoRecommendModel.h"
#import "VideoRecommendViewCell.h"
#import "MBProgressHUD.h"
#import "DataBaseHandle.h"
#import "VideoMainModel.h"
#define kVideoCell @"video-cell"


@interface VideoPlayingViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,retain)MBProgressHUD *hud;
@property(nonatomic,retain)UIImageView *playBackView;//视频背景
@property(nonatomic,retain)UILabel *recommendLabel;//推荐
@property(nonatomic,retain)MPMoviePlayerController *mediaPlayer;//播放器
@property(nonatomic,retain)NSMutableArray *dataSource;//存网络请求数据
@property(nonatomic,retain)UITableView *tableView;//推荐视频



@end

@implementation VideoPlayingViewController

- (void)dealloc
{

    
    self.hud = nil;
    self.playBackView = nil;
    self.tableView = nil;
    self.recommendLabel = nil;
    self.videoID = nil;
    self.mp4_url = nil;
    self.mediaPlayer = nil;
    [super dealloc];
}


//隐藏tabBar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = self.videoName;
    
    [self buildTableView];
    [self buildVideoPlayer];
    [self readDataFromUrl];
    [self buildLoading];
    [self buildCollectButton];
    
}

#pragma mark 右titlebutton
- (void)buildCollectButton{

    UIBarButtonItem *collectButton = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleCollect:)];
//    if ([[DataBaseHandle shareDataBaseHandle]hasVideoBy:self.videoName]) {
//        [self showMessage:@"已收藏,请勿重复收藏"];
//    }
    
    
    self.navigationItem.rightBarButtonItem = collectButton;
    [collectButton release];
    
    
}



#pragma mark 收藏功能的实现

- (void)handleCollect:(UIBarButtonItem *)sender{
//    NSLog(@"%@",self.videoName);

    if ([[DataBaseHandle shareDataBaseHandle]hasVideoBy:self.videoName]) {
//        [[DataBaseHandle shareDataBaseHandle]deleteVideoByTitle:self.videoName];
//        self.navigationItem.rightBarButtonItem.title = @"收藏";
        [self showMessage:@"已收藏,请勿重复收藏!"];
    }else{
        
        VideoMainModel *model = [[VideoMainModel alloc]init];
        model.vid = self.videoID;
        model.title = self.videoName;
        model.mp4_url = self.mp4_url;
        [[DataBaseHandle shareDataBaseHandle]insertVideoTable:model];
//        self.navigationItem.rightBarButtonItem.title = @"已收藏";
        [self showMessage:@"收藏成功"];
    }
    
  
}

//收藏提示信息
- (void)showMessage:(NSString *)message{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    
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



//添加播放器

- (void)buildVideoPlayer{
    
    self.playBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, 0.42*MAIN_SCREEN_HEIGHT)];
    self.playBackView.image = [UIImage imageNamed:@"video_content_bg@2x"];
    
    self.playBackView.userInteractionEnabled = YES;
    self.mediaPlayer = [[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.mp4_url]] autorelease];
    [self.mediaPlayer.view setFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.42*MAIN_SCREEN_HEIGHT)];
    [self.playBackView addSubview:self.mediaPlayer.view];
    self.mediaPlayer.shouldAutoplay = YES;//自动播放
    [self.mediaPlayer setFullscreen:YES animated:YES];
    self.mediaPlayer.scalingMode = MPMovieScalingModeFill;//适应屏幕大小,保持宽高比.可剪裁
    
    [self.mediaPlayer play];
    [self.view addSubview:self.playBackView];
    [self.playBackView release];

    
}


#pragma mark 配置tableView
- (void)buildTableView{
    

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.42*MAIN_SCREEN_HEIGHT+64, MAIN_SCREEN_WIDTH, 0.58*MAIN_SCREEN_HEIGHT-64) style:(UITableViewStylePlain)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //注册cell
    [self.tableView registerClass:[VideoRecommendViewCell class] forCellReuseIdentifier:kVideoCell];
    
    [self.view addSubview:self.tableView];
    [self.tableView release];


}



#pragma mark 请求网络数据
- (void)readDataFromUrl{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block typeof(self) weakSelf = self;
    NSString *urlStr = [NSString stringWithFormat:VIDEO_PLAYVIEW_URL,self.videoID];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.hud hide:YES];
        
        NSMutableArray *mArray = [responseObject valueForKey:@"recommend"];
        
        if (mArray == nil) {
            [self.tableView removeFromSuperview];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_HEIGHT/2-50, MAIN_SCREEN_HEIGHT*0.38+100, 100, 40)] ;
            label.text = @"暂无推荐";
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:19];
            [self.view addSubview:label];
            [label release];
        }


//        NSLog(@"%@",mArray);
        NSMutableArray *currentArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in mArray) {
            VideoRecommendModel *model = [[VideoRecommendModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            if ([model.title rangeOfString:@"下体"].location == NSNotFound  &&[model.title rangeOfString:@"高潮"].location == NSNotFound  &&[model.title rangeOfString:@"裸体"].location == NSNotFound && [model.title rangeOfString:@"强奸"].location == NSNotFound &&[model.title rangeOfString:@"黑鬼"].location == NSNotFound &&[model.title rangeOfString:@"胸"].location == NSNotFound && [model.title rangeOfString:@"乳"].location == NSNotFound &&
                [model.title rangeOfString:@"上床"].location == NSNotFound
                
                )
            {
                
                [currentArray addObject:model];
            }

            [model release];
        }
        weakSelf.dataSource = currentArray;
//                NSLog(@"%@",weakSelf.dataSource);
        
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

#pragma mark 显示cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     VideoRecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoCell forIndexPath:indexPath];
    VideoRecommendModel *model = self.dataSource[indexPath.row];;
    [cell assignValueByVideoRecommendModel:model];
    
   
   
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    
    return 0.13*MAIN_SCREEN_HEIGHT;

}


#pragma mark 配置页眉
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *aView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.05 * MAIN_SCREEN_HEIGHT)];
    aView.image = [UIImage imageNamed:@"tea.jpg"];
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT * 0.05)];
    aLabel.text = @"推荐视频";
    [aView addSubview:aLabel];
    
    return aView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MAIN_SCREEN_HEIGHT * 0.05;
}




#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    self.mp4_url = [self.dataSource[indexPath.row] valueForKey:@"mp4_url"];
    [self.mediaPlayer stop];
    self.mediaPlayer.contentURL = [NSURL URLWithString:self.mp4_url];
    [self.mediaPlayer prepareToPlay];
    self.navigationItem.title = [self.dataSource[indexPath.row] valueForKey:@"title"];
    self.videoName = [self.dataSource[indexPath.row] valueForKey:@"title"];
    self.videoID = [self.dataSource[indexPath.row] valueForKey:@"videoid"];
    
    
}



- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
