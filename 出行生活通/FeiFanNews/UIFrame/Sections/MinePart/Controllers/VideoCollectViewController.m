//
//  VideoCollectViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/6.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoCollectViewController.h"
#import "VideoCollViewCell.h"
#import "DataBaseHandle.h"
#import "VideoMainModel.h"
#import "VideoPlayingViewController.h"

@interface VideoCollectViewController ()<UIAlertViewDelegate>
@property(nonatomic,retain)NSMutableArray *dataSource;

@end

@implementation VideoCollectViewController

- (void)dealloc
{
    self.dataSource = nil;
    [super dealloc];
}

- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataSource retain]autorelease];
}

- (void)viewDidAppear:(BOOL)animated{

    self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllVideo];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[VideoCollViewCell class] forCellReuseIdentifier:@"cell"];
    [self buileDeleteButton];
    
}

#pragma mark 右键清空
- (void)buileDeleteButton{

    UIBarButtonItem *deleteAllButton = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleDeleteAll:)];
    self.navigationItem.rightBarButtonItem = deleteAllButton;
    [deleteAllButton release];
}


- (void)handleDeleteAll:(UIBarButtonItem *)sender{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];

    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
        [[DataBaseHandle shareDataBaseHandle]deleteAllVideo];
        self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllVideo];
        [self.tableView reloadData];
            break;
            
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.dataSource.count;
}

#pragma mark 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    VideoMainModel *model = self.dataSource[indexPath.row];
    cell.titleLabel.text = model.title;

    
//    NSLog(@"%@",[self.dataSource[indexPath.row] valueForKey:@"title"]);
    
    return cell;
}

#pragma mark 点击cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    VideoPlayingViewController *videoPVC = [[VideoPlayingViewController alloc]init];
    
    videoPVC.mp4_url = [self.dataSource[indexPath.row] valueForKey:@"mp4_url"];
    videoPVC.videoID = [self.dataSource[indexPath.row] valueForKey:@"vid"];
    videoPVC.videoName = [self.dataSource[indexPath.row] valueForKey:@"title"];
    [self.navigationController pushViewController:videoPVC animated:YES];
    [videoPVC release];

    
}









// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


#pragma mark 删除cell.更新数据

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoMainModel *model = self.dataSource[indexPath.row];
    [[DataBaseHandle shareDataBaseHandle]deleteVideoByTitle:model.title];
    self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllVideo];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
