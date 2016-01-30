//
//  TNCollectController.m
//  FeiFanNews
//
//  Created by laouhn on 15/11/7.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TNCollectController.h"
#import "DataBaseHandle.h"
#import "TNModel.h"
#import "TravelNotesController.h"
@interface TNCollectController ()
@property(nonatomic,retain)NSMutableArray *dataSource;
@end

@implementation TNCollectController
- (void)dealloc{
    self.dataSource = nil;
    [super dealloc];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tn"];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_dataSource retain]autorelease];
}
- (void)viewWillAppear:(BOOL)animated{
    self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllTN];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tn" forIndexPath:indexPath];
    TNModel *tn = self.dataSource[indexPath.row];
    cell.textLabel.text = tn.titleName;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelNotesController *detailVC = [[TravelNotesController alloc]init];
    TNModel *tn = self.dataSource[indexPath.row];
    detailVC.id = tn.id1;
    detailVC.titleName = tn.titleName;
       
    [self.navigationController pushViewController:detailVC animated:NO];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    TNModel *tn = self.dataSource[indexPath.row];
    [[DataBaseHandle shareDataBaseHandle]deleteTNByid:tn.titleName];
    self.dataSource = [[DataBaseHandle shareDataBaseHandle]selectAllTN];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];

    
    
    
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
