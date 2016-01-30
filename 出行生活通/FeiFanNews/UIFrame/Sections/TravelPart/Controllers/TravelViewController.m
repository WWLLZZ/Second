//
//  TravelViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TravelViewController.h"
#import "StoryDetailController.h"
#import "TravelNotesController.h"
#import "MoreStoryController.h"
#import "StroyViewCell.h"
#import "HeadView.h"
#import "FeiFanHeader.h"
#import "TravelNotesViewCell.h"
#import "AFNetworking.h"
#import "StoryModel.h"
#import "TNModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "SDCycleScrollView.h"

@interface TravelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *dataSource;//存储数据
@property (nonatomic,retain)NSMutableArray *tnDataArray;//存储数据
@property(nonatomic,retain)MBProgressHUD *hud;

@end

@implementation TravelViewController
- (void)dealloc{
    self.story = nil;
    self.collectionView = nil;
    self.dataSource = nil;
    self.tnDataArray = nil;
    self.hud = nil;
    [super dealloc];
}
//懒加载存储数据的数组
- (NSMutableArray *)tnDataArray{
    if (_tnDataArray == nil) {
        self.tnDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _tnDataArray;
}

//懒加载存储数据的数组
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataSource retain]autorelease];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    [self configureCollectionView];
    [self readFromNet];
    [self setHud];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(readFromNet) name:@"reload" object:nil];
}


//设置菊花的方法

- (void)setHud{
    self.hud = [[[MBProgressHUD alloc]init]autorelease];
    self.hud.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    self.hud.minSize = CGSizeMake(0, 0);
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
}


//数据解析的方法
- (void)readFromNet{
 
    NSString *storyURL = @"http://api.breadtrip.com/v2/index/?lat=34.82626071841663&lng=113.5561093259392&sign=6c0d50def697a9b7af54e968a2be4926";
    AFHTTPRequestOperationManager *manger= [AFHTTPRequestOperationManager manager];
    __block typeof(self) weakSelf = self;
    [manger GET:storyURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        NSArray *array = dict[@"elements"];
       
        for (int i = 2; i < 6; i++) {
            NSDictionary *diction = array[i];
            NSArray *arr = diction[@"data"];
            NSDictionary *dict1 = [arr lastObject];
            StoryModel *story = [[StoryModel alloc]init];
            NSDictionary *userDic = dict1[@"user"];
           
            story.avatar_s = [userDic valueForKey:@"avatar_s"];
            story.name = [userDic valueForKey:@"name"];
            [story setValuesForKeysWithDictionary:dict1];
            [self.dataSource addObject:story];
            [story release];
            
        }
        for (int i = 7; i < array.count; i++) {
            NSDictionary *dict = array[i];
            
            NSArray *arr = dict[@"data"];
            NSDictionary *dict1 = [arr lastObject];
            TNModel *tn = [[TNModel alloc]init];
            [tn setValuesForKeysWithDictionary:dict1];
            tn.titleName = [dict1 valueForKey:@"name"];
            NSDictionary *usedic = dict1[@"user"];
            tn.avatar_s = [usedic valueForKey:@"avatar_s"];
            tn.name = [usedic valueForKey:@"name"];
            tn.type = [dict valueForKey:@"type"];
            [self.tnDataArray addObject:tn];
            NSString *str = [NSString stringWithFormat:@"%@",tn.type];
            //判断cell类型
            if ([str isEqualToString:@"5"]) {
                [self.tnDataArray removeObject:tn];
            }
            
            [tn release];
        }
        //刷新UI
        [weakSelf.collectionView reloadData];
        //让菊花消失
        [self.hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
  
}

//创建collectionView
- (void)configureCollectionView{
    UICollectionViewFlowLayout *flyout = [[UICollectionViewFlowLayout alloc]init];
    //指定页眉大小
    flyout.headerReferenceSize = CGSizeMake(320, 50);
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flyout];
    collectView.backgroundColor = [UIColor clearColor];
    //指定代理
    collectView.delegate =self;
    collectView.dataSource = self;
    //注册故事的cell
    [collectView registerClass:[StroyViewCell class] forCellWithReuseIdentifier:kCell];
    //注册游记的cell
    [collectView registerClass:[TravelNotesViewCell class] forCellWithReuseIdentifier:kNoteCell];
    //注册页眉
    [collectView registerClass:[HeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead];
    self.collectionView = collectView;
    
    [self.view addSubview:self.collectionView];
    [collectView release];
    [flyout release];
    

}
//根据分区返回不同的item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return CGSizeMake(MAIN_SCREEN_WIDTH * 0.45, MAIN_SCREEN_WIDTH * 0.55);
    }else{
        return CGSizeMake(MAIN_SCREEN_WIDTH, MAIN_SCREEN_WIDTH *0.6);
    }


}
//根据分区返回不同的偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (0 == section) {
        return UIEdgeInsetsMake(5, 10, 5, 10);
    }else{
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }


}
//根据分区返回该分区的item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (0 == section) {
        return self.dataSource.count;
    }else{
        return self.tnDataArray.count;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;

}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        StroyViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
        StoryModel *story = self.dataSource[indexPath.row];
        [cell setValueByStoryModel:story];
        [cell.avatarView sd_setImageWithURL:[NSURL URLWithString:story.avatar_s] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.nameLable.text = story.name;

        return cell;

    }else{
        TravelNotesViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNoteCell forIndexPath:indexPath];
        TNModel *tn = self.tnDataArray[indexPath.row];
        [cell setValueByTNModel:tn];
        [cell.userView sd_setImageWithURL:[NSURL URLWithString:tn.avatar_s] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.userNameLable.text = tn.name;
        cell.TiteLable.text = tn.titleName;
        return cell;
    
    }
    
}


//返回页眉
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHead forIndexPath:indexPath];
        if (0 == indexPath.section) {
            view.titleLable.text = @"每日精彩故事";
            [view addSubview:view.moreButton];
            [view.moreButton addTarget:self action:@selector(pushIn:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }else{
        view.titleLable.text = @"精彩游记和专题";
        [view.moreButton removeFromSuperview];
        
        }
        
       
        return view;
    }else{
        return nil;
    
    }
}
//点击cell跳转页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        
        //跳转到详情页面
        StoryDetailController *storyController = [[StoryDetailController alloc]init];
        StoryModel *story = self.dataSource[indexPath.row];
        //传值给详情页面
        storyController.id = story.spot_id;
        storyController.name = story.name;
        storyController.userStr = story.avatar_s;
        storyController.index_title = story.index_title;
        [self.navigationController pushViewController:storyController animated:YES];
        
        [storyController release];
        
        
    }else{
        TravelNotesController *noteController = [[TravelNotesController alloc]init];
        TNModel *tnmodel = self.tnDataArray[indexPath.row];
        noteController.id = tnmodel.id1;
        noteController.name = tnmodel.name;
        noteController.titleName = tnmodel.titleName;
        [self.navigationController pushViewController:noteController animated:YES];
        [noteController release];
    
    
    }
}

//更多按钮的方法实现
- (void)pushIn:(UIButton *)button{
    MoreStoryController *moreStroyColler = [[MoreStoryController alloc]init];
    [self.navigationController pushViewController:moreStroyColler animated:YES];
    [moreStroyColler release];
    
}
- (void)setupScrollView
{
//    NSArray *images = @[[UIImage imageNamed:@"lunbo1.jpeg"] , [UIImage imageNamed:@"lunbo2.jpg"] , [UIImage imageNamed:@"lunbo3.jpg"]];
//    NSArray *titles = @[@"梦想，并不奢侈，只要勇敢地迈出第一步。" , @"因为有梦,所以勇敢出发，选择出发，便是风雨兼程。" , @"旅游不在乎终点，而是在意途中的美好记忆和景色。"];
//    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width, MAIN_SCREEN_WIDTH*0.53) imagesGroup:images];
//    scrollView.titlesGroup = titles;
//    scrollView.autoScrollTimeInterval = 4.0;
//   
//    scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    scrollView.delegate = self;
      
}
#pragma mark - 轮播代理协议
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

@end
