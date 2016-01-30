//
//  MineViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "MineViewController.h"
#import "MineChirldViewController.h"
#import "WeatherController.h"
#import "CollectController.h"
#import "MapsController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface MineViewController ()<UIAlertViewDelegate>
@property (nonatomic,retain)MineChirldViewController *mineVC;
@property (nonatomic,retain)UINavigationController *mineNC;
@property (nonatomic,assign)BOOL isRight;
@property (nonatomic,retain)UIViewController *viewControl;

@property (nonatomic,retain)UIImageView *cloudView;
@property (nonatomic,retain)UIButton *mapsButton;
@property (nonatomic,retain)UIButton *weatherButton;
@property (nonatomic,retain)UIButton *collectButton;
@property (nonatomic,retain)UIButton *cleanButton;
@property (nonatomic,retain)UILabel *cacheLabel;
@property(nonatomic,retain)UIButton *MyButton;

@end

@implementation MineViewController
- (void)dealloc
{
    self.cacheLabel = nil;
    self.viewControl = nil;
    self.mineNC = nil;
    self.mineVC = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{
    
    //计算当前缓存大小
    NSString *path = [self _getCachePath];
    CGFloat cacheSize = [self _folderSizeWithPath:path]/1024.0/1024.0;
    self.cacheLabel.text = [NSString stringWithFormat:@"(%.2lfMB)",cacheSize];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self drawerinView];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bobo_video_cover@2x"]];
    self.mapsButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.mapsButton.frame = CGRectMake(kScreenWidth *0.28, kScreenWidth * 0.31, kScreenWidth * 0.31, kScreenWidth * 0.09);
    self.mapsButton.backgroundColor = [UIColor greenColor];
    [self.mapsButton setTitle:@"地图" forState:(UIControlStateNormal)];
    [self.mapsButton addTarget:self action:@selector(handleMaps:) forControlEvents:(UIControlEventTouchUpInside)];
    self.mapsButton.layer.cornerRadius = 7;
    self.collectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectButton.frame = CGRectMake(kScreenWidth * 0.40, kScreenWidth * 0.46, kScreenWidth * 0.31, kScreenWidth * 0.09);
    self.collectButton.backgroundColor = [UIColor cyanColor];
    [self.collectButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    self.collectButton.layer.cornerRadius = 7;
    [self.collectButton addTarget:self action:@selector(handleCollect:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.weatherButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.weatherButton.frame = CGRectMake(kScreenWidth * 0.28, kScreenWidth * 0.62, kScreenWidth * 0.31, kScreenWidth * 0.09);
    
    self.weatherButton.backgroundColor = [UIColor magentaColor];
    [self.weatherButton setTitle:@"天气" forState:(UIControlStateNormal)];
    [self.weatherButton addTarget:self action:@selector(handleWeather:) forControlEvents:(UIControlEventTouchUpInside)];
    self.weatherButton.layer.cornerRadius = 7;
    self.cleanButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.cleanButton.frame = CGRectMake(kScreenWidth * 0.40, kScreenWidth * 0.78, kScreenWidth * 0.31, kScreenWidth * 0.09);
    self.cleanButton.backgroundColor = [UIColor blueColor];
    [self.cleanButton setTitle:@"清除缓存" forState:(UIControlStateNormal)];
    [self.cleanButton addTarget:self action:@selector(handleClean:) forControlEvents:(UIControlEventTouchUpInside)];
    self.cleanButton.layer.cornerRadius = 7;
    
//    self.cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 250, 100, 30)];
//    self.cacheLabel.backgroundColor = [UIColor orangeColor];
    //计算当前缓存大小
//    NSString *path = [self _getCachePath];
//    CGFloat cacheSize = [self _folderSizeWithPath:path]/1024.0/1024.0;
//    self.cacheLabel.text = [NSString stringWithFormat:@"%.2lfMB",cacheSize];
    
    self.MyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.MyButton.backgroundColor = [UIColor orangeColor];
    self.MyButton.frame = CGRectMake(kScreenWidth * 0.28, kScreenWidth * 0.93, kScreenWidth * 0.31, kScreenWidth * 0.09);
    [self.MyButton addTarget:self action:@selector(HandleMine:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.MyButton setTitle:@"关于我们" forState:(UIControlStateNormal)];
    self.MyButton.layer.cornerRadius = 7;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.22, kScreenWidth * 1.1, kScreenWidth * 0.25, kScreenWidth * 0.09)];
    label.text = @"夜间模式";
    label.backgroundColor = [UIColor grayColor];
    label.layer.cornerRadius = 7;
    label.layer.masksToBounds = YES;
    UISwitch *aswitch = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth * 0.5, kScreenWidth * 1.1, 0, 0)];
  
    [aswitch addTarget:self action:@selector(nightAction:) forControlEvents:(UIControlEventValueChanged)];
    aswitch.tintColor = [UIColor cyanColor];
    [self.view addSubview:aswitch];
    [self.view addSubview:label];
    [self.view addSubview:self.MyButton];
    [self.view addSubview:self.cacheLabel];
    [self.view addSubview:self.cleanButton];
    [self.view addSubview:self.weatherButton];
    [self.view addSubview:self.collectButton];
    [self.view addSubview:self.mapsButton];
    
    [self.cacheLabel release];
    
}

- (void)nightAction:(UISwitch *)sender{
    switch ((int)sender.on) {
        case YES:
            //发出通知,让appdelegate里面执行night方法
            [[NSNotificationCenter defaultCenter]postNotificationName:@"night" object:nil userInfo:nil];
            break;
            case NO:
            //发出通知,让appdelegate里面执行day方法
            [[NSNotificationCenter defaultCenter]postNotificationName:@"day" object:nil userInfo:nil];
            break;
        default:
            break;
    }
    
    
    
}
- (void)HandleMine:(UIButton *)sender{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"有我随行-出行生活通" message:@"姓名:刘少华\n班级:12数字多媒体\n指导老师:张亚娟" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    
}


- (void)handleMaps:(UIButton *)handle{
    MapsController *maps = [[MapsController alloc]init];
    [self.navigationController pushViewController:maps animated:YES];
}
- (void)handleCollect:(UIButton *)sender{
    
    CollectController *collect = [[CollectController alloc]init];
    [self.navigationController pushViewController:collect animated:YES];
    
}

- (void)handleWeather:(UIButton *)sender{
    WeatherController *weather = [[WeatherController alloc]init];
    
    [self.navigationController pushViewController:weather animated:YES];
}

#pragma mark 清空缓存
- (void)handleClean:(UIButton *)sender{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        return;
    }else{
        
        NSString *cachePath = [self _getCachePath];//获取文件缓存路径
        [self _clearCache:cachePath];//清除缓存文件
        self.cacheLabel.text = @"0.00MB";//清除后label置为0
    }
    
}

//获取文件缓存路径
- (NSString *)_getCachePath{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    return  path;
    
}

//根据文件路径计算缓存文件的大小
- (CGFloat)_folderSizeWithPath:(NSString *)folderPath{
    
    NSFileManager *manamger = [NSFileManager defaultManager];
    folderPath = [self _getCachePath];//获取路径
    if (![manamger fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manamger subpathsAtPath:folderPath]objectEnumerator];
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        float singleFileSize = 0.0;
        if ([manamger fileExistsAtPath:fileAbsolutePath]) {
            singleFileSize = [[manamger attributesOfItemAtPath:fileAbsolutePath error:nil]fileSize];
        }
        folderSize += singleFileSize;
    }
    return folderSize;
    
}

//根据文件路径清除缓存
- (void)_clearCache:(NSString *)floderPath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //遍历文件夹
    if ([fileManager fileExistsAtPath:floderPath]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:floderPath];
        for (NSString *fileName in childerFiles) {
            NSString *absoultePath = [floderPath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absoultePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];//三方
    
    
}




- (void)drawerinView{
    self.view.backgroundColor = [UIColor greenColor];
//    UIImageView *backImageView  = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    backImageView.image = [UIImage imageNamed:@"12"];
    self.mineVC = [[MineChirldViewController alloc]init];
    UINavigationController *rootNC = [[UINavigationController alloc]initWithRootViewController:self.mineVC];
    self.mineNC = rootNC;
//    self.mineVC = [[MineChirldViewController alloc]init];
    self.mineVC.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    [self addChildViewController:self.mineNC];
     [self.view addSubview:self.mineNC.view];
   
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"抽屉" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
        rightBarButtonItem;
    });
}
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    if (!self.isRight) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mineNC.view.frame = CGRectMake(-kScreenWidth*0.21, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -kScreenWidth*0.1 );
            self.navigationController.navigationBar.frame = CGRectMake(-kScreenWidth *0.21, 0, kScreenWidth, 64);
            self.tabBarController.tabBar.frame = CGRectMake(-kScreenWidth *0.21, kScreenHeight-64, kScreenWidth, 49);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.mineNC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, kScreenWidth, 64);
            self.tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
        }];
    }
    self.isRight = !_isRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
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
