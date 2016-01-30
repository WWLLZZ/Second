//
//  NewsController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewsController.h"
#import "NewsViewCell.h"
#import "NewsModel.h"
#import "FMDB.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NewsDetailController.h"
#import "NewsBigViewCell.h"
#import "NewsMoreViewCell.h"
#import "NewsDetailViewController.h"
#import "MJRefresh.h"
#import "MJRefreshBaseView.h"
#import "SVPullToRefresh.h"

@interface NewsController ()

@property (nonatomic,retain)NSMutableArray *idArray;
@property (nonatomic,retain)NSMutableArray *nameArray;
@property (nonatomic,retain)NSMutableDictionary *mDic;
@property (nonatomic,retain)NSMutableArray *dateSources;
@property (nonatomic,retain)NSMutableArray *detailID;
@property (nonatomic,retain)NSMutableArray *otherID;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,retain)NSMutableArray *adsArray;
#define kNewsCell @"new-cell"
#define kNewsBigCell @"big-cell"
#define kNewsMoreCell @"more-cell"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@end

@implementation NewsController
- (NSMutableArray *)otherID{
    if (_otherID == nil) {
        self.otherID = [NSMutableArray arrayWithCapacity:0];
    }
    return  [[_otherID retain]autorelease];
}
//存放对应的ID
- (NSMutableArray *)detailID{
    if (_detailID == nil) {
        self.detailID = [NSMutableArray arrayWithCapacity:0];
    }
    return  [[_detailID retain]autorelease];
}
//存放对应的数据
- (NSMutableArray *)dateSources{
    if (_dateSources == nil) {
        self.dateSources = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dateSources retain]autorelease];
}
//存放全部的ID
- (NSMutableArray *)idArray{
    if (_idArray == nil) {
        self.idArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_idArray retain]autorelease];
}
//存放所有的标题名
- (NSMutableArray *)nameArray{
    if (_nameArray == nil) {
        self.nameArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_nameArray retain]autorelease];
}


- (NSMutableArray *)adsArray{
    if (_adsArray == nil) {
        self.adsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_adsArray retain]autorelease];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    [self.tableView registerClass:[NewsViewCell class] forCellReuseIdentifier:kNewsCell];
    [self.tableView registerClass:[NewsBigViewCell class] forCellReuseIdentifier:kNewsBigCell];
    [self.tableView registerClass:[NewsMoreViewCell class] forCellReuseIdentifier:kNewsMoreCell];
    
    
    //    下拉刷新
    __block typeof(self) weahSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weahSelf.page = 0;
        [self readDateFromNetWorking];
    }];
    
    [self.tableView headerBeginRefreshing];
    //    上拉加载
    [self.tableView addFooterWithCallback:^{
        weahSelf.page ++;
        [self readDateFromNetWorking];
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(readDateFromNetWorking) name:@"reload" object:nil];
    
    [self.tableView triggerPullToRefresh];

}

- (void)readDateFromNetWorking{
    NSString *urlStr = @"http://c.3g.163.com/nc/topicset/ios/subscribe/manage/listspecial.html";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block typeof(self) weakSelf = self;
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *mArray = responseObject[@"tList"];
        for (NSDictionary *dic in mArray) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.idArray addObject:model.tid];
            [weakSelf.nameArray addObject:model.tname];
            self.mDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [self.mDic setValue:model.tid forKey:model.tname];
//             NSLog(@"%@",self.mDic);
             NSString *ID = [self.mDic objectForKey:self.title];
            if (ID != nil) {
            [self readDetailDate:ID];
          }
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self.mDic removeAllObjects];
    [self.idArray removeAllObjects];
    [self.nameArray removeAllObjects];
}
- (void)readDetailDate:(NSString *)ID{
    if ([self.title isEqualToString:@"头条"]) {
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/%ld-20.html",ID,self.page * 20];
        
        [self resolvingDate:urlString ids:ID];
//        NSLog(@"%@", urlString);
    }else{
        NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/%ld-20.html",ID,self.page * 20];
        [self resolvingDate:urlString ids:ID];
       
    }
}

- (void)resolvingDate:(NSString *)urlString ids:(NSString *)ID{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __block typeof(self) weakSelf = self;
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [self.adsArray removeAllObjects];
        NSMutableArray *currentArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *array = responseObject[ID];
        for (NSDictionary *detailDic in array) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:detailDic];
//            [self.dateSources addObject:model];
            [currentArray addObject:model];
            if ([model.skipType isEqualToString:@"photoset"]) {
                [self.detailID addObject:model.photosetID];
            }
            else {
                [self.detailID addObject:model.docid];
            }
            [model release];
        }
        
//        NSLog(@"----%lu", (unsigned long)currentArray.count);
//        当page值为0的时候，self.dataSourse中只存放第一页的数据
        if (0 == (long)weakSelf.page) {
            weakSelf.dateSources = [NSMutableArray arrayWithArray:currentArray];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
                    [self.tableView headerEndRefreshing];
        }else{
            [weakSelf.dateSources addObjectsFromArray:currentArray];
//            停止上拉加载的动画
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [self.tableView footerEndRefreshing];
        }

        
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@", [error localizedDescription]);
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%d",self.dateSources.count);
    return self.dateSources.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = self.dateSources[indexPath.row];
    if (model.imgType == 1) {
          NewsBigViewCell *bigCell = [tableView dequeueReusableCellWithIdentifier:kNewsBigCell forIndexPath:indexPath];
        [bigCell assginValueByMovie:model];
        return bigCell;
    }else if([model.skipType isEqualToString:@"photoset"]){
         NewsMoreViewCell *moreCell = [tableView dequeueReusableCellWithIdentifier:kNewsMoreCell forIndexPath:indexPath];
//        self.num += 1;
        [moreCell assginValueByMovie:model];
        return moreCell;
    }else{
        NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewsCell forIndexPath:indexPath];
        [cell assginValueByMovie:model];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

//点击cell触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = self.dateSources[indexPath.row];
    
    if([model.skipType isEqualToString:@"photoset"]){
        NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]init];
        newsDetailVC.detailID = self.detailID[indexPath.row];
        [self.navigationController pushViewController:newsDetailVC animated:YES];
        
    }else{
        NewsDetailController *detailVC = [[NewsDetailController alloc]init];
        detailVC.detailID = self.detailID[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    self.navigationController.hidesBarsOnSwipe = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];

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
