//
//  RadioListViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioListViewController.h"
#import "RadioListViewCell.h"
#import "AFNetworking.h"
#import "FeiFanHeader.h"
#import "RadioMainModel.h"
#import "RadioPlayingViewController.h"
#import "MBProgressHUD.h"

@interface RadioListViewController ()

@property(nonatomic,retain)NSMutableArray *dataSource;//存放数据
@property(nonatomic,retain)MBProgressHUD *hud;

@end

@implementation RadioListViewController

- (void)dealloc
{
    self.hud = nil;
    self.dataSource = nil;
    self.cid = nil;
    self.cname = nil;
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

    self.navigationItem.title = self.cname;
    [self readDataFromURL];
    
    //注册cell
    [self.tableView registerClass:[RadioListViewCell class] forCellReuseIdentifier:@"cell"];
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

#pragma mark 读取网络数据
- (void)readDataFromURL{

    NSString *urlStr = [NSString stringWithFormat:RADIO_LISTVIEW_URL,self.cid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block typeof(self) weakSelf = self;
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         [self.hud hide:YES];
        
        NSMutableArray *mArray = [responseObject valueForKey:@"tList"];
        for (NSDictionary *nDct in mArray) {
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
        
//        NSLog(@"%@",weakSelf.dataSource);
        [self.tableView reloadData];
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 0.25*MAIN_SCREEN_WIDTH;
}

//显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RadioListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    RadioMainModel *model = self.dataSource[indexPath.row] ;
    [cell assignValueByModel:model];
    
    
    return cell;
}

#pragma mark 点击cell跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    RadioPlayingViewController *radioPVC = [[RadioPlayingViewController alloc]init];
    radioPVC.docid = [self.dataSource[indexPath.row]valueForKey:@"docid"];
    radioPVC.tid = [self.dataSource[indexPath.row] valueForKey:@"tid"];

    radioPVC.kindname = [self.dataSource[indexPath.row] valueForKey:@"tname"];
    [self.navigationController pushViewController:radioPVC animated:YES];
    [radioPVC release];
    
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
