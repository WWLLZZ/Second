//
//  MainController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "MainController.h"
#import "NewsViewController.h"
#import "TravelViewController.h"
#import "MediaViewController.h"
#import "MineViewController.h"
#import "DataBaseHandle.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViewControl];
    [[DataBaseHandle shareDataBaseHandle]createMediaBase];
}
- (void)configureViewControl{
    NewsViewController *newVC = [[NewsViewController alloc]init];
    UINavigationController *newNC = [[UINavigationController alloc]initWithRootViewController:newVC];
    newVC.title = @"新闻";
    newVC.tabBarItem.image = [[UIImage imageNamed:@"achi_calendar@2x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];

    TravelViewController *travelVC = [[TravelViewController alloc]init];
    UINavigationController *travelNC = [[UINavigationController alloc]initWithRootViewController:travelVC];
    travelVC.title = @"游记";
    travelVC.tabBarItem.image = [[UIImage imageNamed:@"tn"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    MediaViewController *mediaVC = [[MediaViewController alloc]init];
    UINavigationController *mediaNC = [[UINavigationController alloc]initWithRootViewController:mediaVC];
    mediaVC.title = @"视听";
    mediaVC.tabBarItem.image = [[UIImage imageNamed:@"music-cd"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    mineVC.title = @"我的";
    mineVC.tabBarItem.image = [[UIImage imageNamed:@"lanrentuku_Fotor.jpg"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    self.viewControllers = @[newNC,travelNC,mediaNC,mineNC];
    self.tabBarController.tabBar.tintColor = [UIColor brownColor];
    self.selectedIndex = 0;
    
    

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
