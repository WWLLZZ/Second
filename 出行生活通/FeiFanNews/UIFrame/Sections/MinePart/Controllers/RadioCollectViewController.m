//
//  RadioCollectViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/6.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioCollectViewController.h"
#import "VideoCollViewCell.h"
#import "DataBaseHandle.h"
#import "RadioMainModel.h"
#import "RadioPlayingViewController.h"


@interface RadioCollectViewController ()<UIAlertViewDelegate>

@property(nonatomic,retain)NSMutableArray *dataSource;


@end

@implementation RadioCollectViewController

- (void)dealloc
{
    self.dataSource = nil;
    [super dealloc];
}

- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllRadio];
    [self.tableView reloadData];
    
    NSLog(@"%@",self.dataSource);
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
            [[DataBaseHandle shareDataBaseHandle]deleteAllRadio];
            self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllRadio];
            [self.tableView reloadData];
            break;
            
        default:
            break;
    }
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


#pragma mark 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    RadioMainModel *model = self.dataSource[indexPath.row];
    cell.titleLabel.text = model.tname;
    

    
    return cell;
}

#pragma mark 点击cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RadioPlayingViewController *radioPVC = [[RadioPlayingViewController alloc]init];
    radioPVC.kindname = [self.dataSource[indexPath.row] valueForKey:@"title"];
    radioPVC.tid = [self.dataSource[indexPath.row] valueForKey:@"tid"];
    [self.navigationController pushViewController:radioPVC animated:YES];
    [radioPVC release];
    
    
}

#pragma mark 删除cell.更新数据

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    RadioMainModel *model = self.dataSource[indexPath.row];
    [[DataBaseHandle shareDataBaseHandle]deleteRadioByTname:model.tname];
    self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllRadio];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];


    [self.tableView reloadData];
    
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
