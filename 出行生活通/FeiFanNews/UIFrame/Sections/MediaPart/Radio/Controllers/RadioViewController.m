//
//  RadioViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioViewController.h"
#import "FeiFanHeader.h"
#import "RadioMainCollectionViewCell.h"
#import "AFNetworking.h"
#import "RadioMainModel.h"
#import "RadioKindModel.h"
#import "CollectionHeaderView.h"
#import "RadioListViewController.h"
#import "RadioPlayingViewController.h"
#import "MBProgressHUD.h"
#define kItem @"k-cell"
#define kHeaderView @"header-view"

@interface RadioViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *dataSource;//储存数据
@property(nonatomic,retain)NSMutableArray *kindSource;//存分组
@property(nonatomic,retain)MBProgressHUD *hud;

@end

@implementation RadioViewController

- (void)dealloc
{
    self.hud = nil;
    self.collectionView = nil;
    self.dataSource = nil;
    self.dataSource = nil;
    [super dealloc];
}

//初始化dataSource
- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataSource retain]autorelease];
}

- (NSMutableArray *)kindSource{

    if (_kindSource == nil) {
        self.kindSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_kindSource retain]autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readDataFromURL];
    [self buildCollectionView];
    [self buildLoading];
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


#pragma mark 创建collectionView
- (void)buildCollectionView{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH/3, 0.3*MAIN_SCREEN_HEIGHT);
    
    //创建一个UICollectionView对象
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-113) collectionViewLayout:flowLayout];
    
    //设置最小行间距
    flowLayout.minimumLineSpacing = 0;
    //设置Item之间最小列间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直滑动
    
     //返回一个页眉大小
    flowLayout.headerReferenceSize = CGSizeMake(MAIN_SCREEN_WIDTH, 0.06*MAIN_SCREEN_HEIGHT);
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //注册cell
    [self.collectionView registerClass:[RadioMainCollectionViewCell class] forCellWithReuseIdentifier:kItem];
    
    self.collectionView.backgroundColor = [UIColor orangeColor];
   
    
    
//    //注册页眉
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    [flowLayout release];
    
    
}

#pragma mark 读取数据
- (void)readDataFromURL{

    NSString *urlStr = RADIO_MAINVIEW_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __block typeof(self) weakSelf = self;
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.hud hide:YES];
        
        NSMutableArray *mArray = [responseObject valueForKey:@"cList"];
        //分类model
        for (NSDictionary *mDic in mArray) {
            RadioKindModel *kindModel = [[RadioKindModel alloc]init];
            kindModel.cid = [mDic valueForKey:@"cid"];
            kindModel.cname = [mDic valueForKey:@"cname"];
            [weakSelf.kindSource addObject:kindModel];
            [kindModel release];
            NSMutableArray *nArray = [mDic valueForKey:@"tList"];
            for (NSDictionary *nDct in nArray) {
                RadioMainModel *model = [[RadioMainModel alloc]init];
                model.playCount = [nDct valueForKey:@"playCount"];
                model.tid = [nDct valueForKey:@"tid"];
                NSMutableDictionary *pDic = [nDct valueForKey:@"radio"];
                    model.title = [pDic valueForKey:@"title"];
                    model.tname = [pDic valueForKey:@"tname"];
                    model.docid = [pDic valueForKey:@"docid"];
                    model.imgsrc = [pDic valueForKey:@"imgsrc"];
                    [weakSelf.dataSource addObject:model];
                [model release];
            }
            
        }
//        NSLog(@"%@",weakSelf.kindSource);
//        NSLog(@"%@",weakSelf.dataSource );
        [self.collectionView reloadData];
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


#pragma mark collectionView的数据源代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.kindSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 3;
}

//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    RadioMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kItem forIndexPath:indexPath];
    RadioMainModel *model = self.dataSource[indexPath.item + indexPath.section *3];
    [cell assignValueByModel:model];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}

#pragma mark 点击cell手势
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    RadioPlayingViewController *radioPVC = [[RadioPlayingViewController alloc]init];
    radioPVC.docid = [self.dataSource[indexPath.item + indexPath.section*3] valueForKey:@"docid"];
    radioPVC.tid = [self.dataSource[indexPath.item + indexPath.section*3] valueForKey:@"tid"];
    radioPVC.kindname = [self.dataSource[indexPath.item + indexPath.section*3] valueForKey:@"tname"];
    [self.navigationController pushViewController:radioPVC animated:YES];
    [radioPVC release];
    
    
}


#pragma mark //页眉重用
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

        CollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView forIndexPath:indexPath];
        RadioKindModel *model = self.kindSource[indexPath.section];
        view.nameLabel.text = model.cname;
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:tap];
    [tap release];
    
        return view;

}

//实现点击手势
- (void)tapAction:(UITapGestureRecognizer *)sender{

    RadioListViewController *radioListVC = [[RadioListViewController alloc]init];
    
    CollectionHeaderView *headerView = (CollectionHeaderView *)sender.view;//通过点击的手势找到是哪一个页眉视图被点击了
    for (RadioKindModel *model in self.kindSource) {
        if ([headerView.nameLabel.text isEqualToString:model.cname]) {
            radioListVC.cid = model.cid;
            radioListVC.cname = model.cname;
        }
    }
    [self.navigationController pushViewController:radioListVC animated:YES];
    [radioListVC release];
 
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
