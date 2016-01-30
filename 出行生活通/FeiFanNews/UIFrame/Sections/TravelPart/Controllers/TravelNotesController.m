//
//  TravelNotesController.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TravelNotesController.h"
#import "TNDetailCell.h"
#import "AFNetworking.h"
#import "TNDetailiModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "FeiFanHeader.h"
#import "TNRowModel.h"
#import "TNDetailTextCell.h"
#import "TNPicViewController.h"
#import "TNModel.h"
#import "DataBaseHandle.h"
@interface TravelNotesController ()

//@property(nonatomic,retain)NSMutableArray *sectionArray2;
@property(nonatomic,retain)NSMutableArray *sectionArray;
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation TravelNotesController
- (void)dealloc{
    self.id = nil;
    self.sectionArray = nil;
//    self.sectionArray2 = nil;
    self.hud = nil;
    self.name = nil;
    self.titleName = nil;
    [super dealloc];

}

- (NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        self.sectionArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_sectionArray retain]autorelease];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加右侧收藏按钮
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collect"] style:(UIBarButtonItemStylePlain) target:self action:@selector(collectAction:)];
    if ([[DataBaseHandle shareDataBaseHandle]hasTNByid:self.titleName]) {
        collectItem.image = [UIImage imageNamed:@"collection"];
    }

    self.navigationItem.rightBarButtonItem = collectItem;
 
    [self.tableView registerClass:[TNDetailCell class] forCellReuseIdentifier:@"detail-cell"];
    [self.tableView registerClass:[TNDetailTextCell class] forCellReuseIdentifier:@"text-cell"];
    [self readDataFromNet];
    [self setHud];
}
//收藏按钮的方法实现
- (void)collectAction:(UIBarButtonItem *)sender{
    
   
        if ([[DataBaseHandle shareDataBaseHandle]hasTNByid:self.titleName]) {
//                    [[DataBaseHandle shareDataBaseHandle]deleteTNByid:self.titleName];
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"collection"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已经收藏过了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else{
            TNModel *tn = [[TNModel alloc]init];
            tn.name = self.name;
            tn.id1 = self.id;
            tn.titleName = self.titleName;
            [[DataBaseHandle shareDataBaseHandle]creatTN];
            [[DataBaseHandle shareDataBaseHandle]insertTN:tn];
            self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"collection"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }
        

    
}

//设置菊花的方法
- (void)setHud{
    self.hud = [[[MBProgressHUD alloc]init]autorelease];
    self.hud.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    self.hud.minSize = CGSizeMake(0, 0);
    [self.view addSubview:self.hud];
    [self.hud show:YES];

}

- (void)readDataFromNet{
  
    NSString *strURL = [NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/",self.id];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    __block typeof (self)weakSelf = self;
    [manger GET:strURL parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *marr = responseObject[@"days"];
      
        for (NSDictionary *dic in marr) {
            NSMutableArray *photoArr = dic[@"waypoints"];
          
           
            for (NSMutableDictionary *secDic in photoArr) {
               
                TNRowModel *model = [[TNRowModel alloc]init];
                
                model.photo = secDic[@"photo"];
                model.text =secDic[@"text"];
                model.local_time = secDic[@"local_time"];
//                NSLog(@"%@",model);
                [self.sectionArray addObject:model];
                [model release];
            }
//            TNDetailiModel *detailModel = [[TNDetailiModel alloc]init];
//            detailModel.date = dic[@"date"];
//            detailModel.day = dic[@"day"];
//            detailModel.waypoints = [NSMutableArray arrayWithArray:self.sectionArray];
//            [weakSelf.sectionArray2 addObject:detailModel];
//            
//
//            [detailModel release];

        }
             
        [weakSelf.tableView reloadData];
        [self.hud hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;//self.sectionArray2.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.sectionArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TNRowModel *model = self.sectionArray[indexPath.row];
    
    
    if ([model.photo isEqualToString:@""]) {
        TNDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text-cell" forIndexPath:indexPath];
        cell.textLab.text = model.text;
        cell.local_timeLable.text = model.local_time;
        [cell setValueByTNRowModel:model];
        return cell;
    }else{
        
        TNDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail-cell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor grayColor];
        
        cell.textLab.text = model.text;
        cell.local_timeLable.text = model.local_time;
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [cell setValueByTNRowModel:model];
        
        return cell;
    
    }
    
}
//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TNRowModel *model = self.sectionArray[indexPath.row];
    if ([model.photo isEqualToString:@""]) {
        return [TNDetailTextCell cellHeight:model];
    }else{
    return [TNDetailCell cellHeight:model];
    }
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TNPicViewController *picVC = [[TNPicViewController alloc]init];
    picVC.dataArray = self.sectionArray;
    picVC.index = indexPath.row;
    [self.navigationController presentViewController:picVC animated:YES completion:nil];
    picVC.tabBarController.tabBar.hidden = YES;
    picVC.navigationController.navigationBarHidden = YES;
    [picVC release];
    
    
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
