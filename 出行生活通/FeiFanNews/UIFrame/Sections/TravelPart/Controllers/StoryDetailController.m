//
//  StoryDetailController.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "StoryDetailController.h"
#import "StoryDetailCell.h"
#import "AFNetworking.h"
#import "StoryDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "FeiFanHeader.h"
#import "SDHeadView.h"
#import "SDPicViewController.h"
#import "DataBaseHandle.h"
#import "StoryModel.h"
#define kScell @"scell"
#define kSDHead @"SDhead"
@interface StoryDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>
@property(nonatomic,retain)NSMutableArray *dataSource;
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)StoryDetailModel *detaili;
@property(nonatomic,retain)MBProgressHUD *hud;
@end
@implementation StoryDetailController
- (void)dealloc{
    self.id = nil;
    self.dataSource = nil;
    self.collectionView = nil;
    self.detaili = nil;
    self.name = nil;
    self.userStr = nil;
    self.hud = nil;
    self.index_cover = nil;
    self.index_title = nil;
    
   

    [super dealloc];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataSource retain]autorelease];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCollection];
    [self readDataFromNet];
    [self setHud];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collect"] style:(UIBarButtonItemStylePlain) target:self action:@selector(collectAction:)];
    if ([[DataBaseHandle shareDataBaseHandle]hasStoryByID:self.index_title]) {
        collectItem.image = [UIImage imageNamed:@"collection"];
    }

    
    self.navigationItem.rightBarButtonItem = collectItem;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)collectAction:(UIBarButtonItem *)sender{
    if ([[DataBaseHandle shareDataBaseHandle]hasStoryByID:self.index_title]) {
//        [[DataBaseHandle shareDataBaseHandle]deleteStoryByID:self.index_title];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"collection"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已经收藏过了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
        StoryModel *story = [[StoryModel alloc]init];
        story.spot_id = self.id;
        story.name = self.name;
        story.avatar_s = self.userStr;
        story.index_title = self.index_title;
        story.index_cover = self.index_cover;
        [[DataBaseHandle shareDataBaseHandle]createStory];
        [[DataBaseHandle shareDataBaseHandle]insertStory:story];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"collection"];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
       
    }

   

}

//配置collectionview
- (void)configureCollection{
    UICollectionViewFlowLayout *flylayout = [[UICollectionViewFlowLayout alloc]init];
    //设置页眉大小
    flylayout.headerReferenceSize = CGSizeMake(MAIN_SCREEN_WIDTH, 4*kSpace);
    //设置item大小
    //    flylayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH-20,MAIN_SCREEN_WIDTH-20);
    //设置缩进量
    flylayout.sectionInset = UIEdgeInsetsMake(kSpace, kSpace, kSpace, kSpace);
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flylayout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    //注册cell
    [self.collectionView registerClass:[StoryDetailCell class] forCellWithReuseIdentifier:kScell];
    //注册页眉
    [self.collectionView registerClass:[SDHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSDHead];
    self.collectionView.dataSource =self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    [flylayout release];



}


//设置菊花
- (void)setHud{
    self.hud = [[[MBProgressHUD alloc]init]autorelease];
    self.hud.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    self.hud.minSize = CGSizeMake(0, 0);
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
}
//数据解析的方法
- (void)readDataFromNet{
    NSString *URL = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/?spot_id=%@",self.id];
    
    AFHTTPRequestOperationManager *manger= [AFHTTPRequestOperationManager manager];
    __block typeof (self)weakSelf = self;
    [manger GET:URL parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = responseObject[@"data"];
        NSDictionary *dictionary1 = dictionary[@"spot"];
        NSArray *marr = dictionary1[@"detail_list"];
       
        for (NSDictionary *dic in marr) {
            StoryDetailModel *detail = [[StoryDetailModel alloc]init];
            [detail setValuesForKeysWithDictionary:dic];
            [weakSelf.dataSource addObject:detail];
            [detail release];
           // NSLog(@"%@",weakSelf.dataSource);
        }
        [weakSelf.collectionView reloadData];
        [self.hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

  
}
//返回item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;

}
//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kScell forIndexPath:indexPath];
    StoryDetailModel * detail = self.dataSource[indexPath.row];
    [cell setValueByStoryModel:detail];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:detail.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
   
    cell.textLable.text = detail.text;
    
    return cell;

}
//设置cell的高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(MAIN_SCREEN_WIDTH-20, [StoryDetailCell cellHeight:self.dataSource[indexPath.row]]);

}
//返回页眉
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SDHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSDHead forIndexPath:indexPath];
        view.nameLable.text = self.name;
        [view.userView sd_setImageWithURL:[NSURL URLWithString:self.userStr] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        return view;
    }else{
        return nil;
    
    }
    
}
//点击cell跳转页面的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SDPicViewController *sdVC = [[SDPicViewController alloc]init];
       sdVC.dataArr = self.dataSource;
    NSInteger indexCount = 0;
    //把index值传过去
    indexCount = indexPath.row;
    sdVC.index = indexCount;
   //模态到图片页面
    [self.navigationController presentViewController:sdVC animated:YES completion:nil];
    //    self.navigationController.navigationBar.hidden = NO;
    //隐藏标签栏
    self.tabBarController.tabBar.hidden = YES;

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
