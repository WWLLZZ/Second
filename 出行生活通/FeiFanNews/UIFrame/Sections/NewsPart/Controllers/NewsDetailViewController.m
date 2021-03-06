//
//  NewsDetailViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/31.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "NewsDetailModel.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface NewsDetailViewController ()<UIActionSheetDelegate>

@property (nonatomic,retain) UIScrollView *photoScrollView;
@property (nonatomic,retain)NewsDetailModel *newsModel;
@property (nonatomic,retain)NSMutableArray *photoArray;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *countLabel;
@property (nonatomic,retain)UITextView *contentText;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) NSMutableArray *textArr;
@property (nonatomic,assign)NSInteger i;
@property (nonatomic,assign)BOOL isTouched;
@property (nonatomic,assign)NSInteger contentoff;


@end

@implementation NewsDetailViewController

- (void)dealloc
{
    self.newsModel = nil;
    self.photoArray = nil;
    self.titleLabel = nil;
    self.countLabel = nil;
    self.detailID = nil;
    [super dealloc];
}
- (NSMutableArray *)textArr{
    if (_textArr == nil) {
        self.textArr = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_textArr retain]autorelease];
}


- (NewsDetailModel *)newsModel{
    if (_newsModel == nil) {
        self.newsModel = [[NewsDetailModel alloc]init];
    }
    return  [[_newsModel retain]autorelease];
}


- (NSMutableArray *)photoArray{
    if (_photoArray == nil) {
        self.photoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_photoArray retain]autorelease];
}
- (UITextView *)contentText{
    if (_contentText == nil) {
        self.contentText = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+10, CGRectGetMaxY(self.titleLabel.frame)+10, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    }
    return [[_contentText retain]autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
//    NSLog(@"%@",self.detailID);
    [self sendRequestWithUrl];
    self.photoScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.photoScrollView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.photoScrollView addGestureRecognizer:tap];
    
    [self.view addSubview:self.photoScrollView];
}
- (void)handleTap:(UITapGestureRecognizer *)hendle{
    [UIView animateWithDuration:1 animations:^{
        if (self.isTouched) {
            
            [self.navigationController setNavigationBarHidden:YES];
            self.tabBarController.tabBar.hidden = YES;
            
        }else{
            [self.navigationController setNavigationBarHidden:NO];
            self.tabBarController.tabBar.hidden = NO;
        }
        self.isTouched = !_isTouched;
    }];
//    [];
}

- (void)sendRequestWithUrl
{
    NSString *two = [self.detailID substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];
//    NSLog(@"%@ %@",[three firstObject],[three lastObject]);
     NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        __block typeof(self) weakSelf = self;
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *mArray = [NSMutableArray array];
        [mArray addObject:responseObject[@"photos"]];
         weakSelf.titleLabel.text = responseObject[@"setname"];
        self.newsModel = [[NewsDetailModel alloc]init];
//        NSArray *arr = [NSArray array];
        for (NSMutableArray *arr in mArray) {
            self.photoArray = arr;
            for ( NSMutableDictionary *dic in arr) {
                [self.newsModel setValuesForKeysWithDictionary:dic];
//                 NSLog(@"%@",self.newsModel);
                NSString *str = self.newsModel.note;
                NSString *str2 = self.newsModel.imgtitle;
                if (self.newsModel.note.length == 0) {
                    [self.textArr addObject:str2];
                 
                }else{
                    [self.textArr addObject:str];
                }
                [self creatScrollwView:self.newsModel withNumber:self.textArr.count - 1];
//                NSLog(@"%ld",self.textArr.count);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
// 创建scrollowView
- (void)creatScrollwView:(NewsDetailModel *)detailModel withNumber:(NSInteger)i
{
        // 创建imageView
        self.imageView = [UIImageView new];
        self.imageView.frame = CGRectMake(kScreenWidth * i, -25, kScreenWidth, [UIScreen mainScreen].bounds.size.height);
//    self.imageView.backgroundColor = [UIColor redColor];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:detailModel.imgurl]];
        self.imageView.tag = 300+i;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.photoScrollView addSubview:self.imageView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(savePhotos:)];
//        tap.numberOfTapsRequired = 2;
//        [self.imageView addGestureRecognizer:tap];
    
        [self.imageView release];
        // 图片索引Lab
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * i, 75, kScreenWidth, 30)];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.textColor = [UIColor whiteColor];
        //        self.indexLab.font = [UIFont systemFontOfSize:15];
        self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu", (long)i + 1,(unsigned long)self.photoArray.count];
        [self.photoScrollView addSubview:self.countLabel];
        
        // text Lab
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * i+10, self.photoScrollView.frame.size.height-150, kScreenWidth- 10, 150)];
        self.titleLabel.text = self.textArr[i];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.photoScrollView addSubview:self.titleLabel];
//        [self.titleLabel release];
    int index = self.photoScrollView.contentOffset.x / kScreenWidth;

    // 设置偏移量
    self.photoScrollView.contentOffset = CGPointMake(kScreenWidth * index, 0);
    self.photoScrollView.contentSize = CGSizeMake(kScreenWidth * self.photoArray.count, self.view.frame.size.height);
    
    // 按一个整页滑动
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.directionalLockEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
//}
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.contentoff= self.photoScrollView.contentOffset.x;
    
}
//- (void)savePhotos:(UITapGestureRecognizer *)sender{
//      UIActionSheet *sheet = [[[UIActionSheet alloc]initWithTitle:@"是否将照片存入相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil]autorelease];
//    
//    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    
//    [sheet showInView:self.view];
//
//
//}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSInteger x = self.contentoff / kScreenWidth ;
//    UIImageView *image = (UIImageView *)[self.photoScrollView viewWithTag:301+x];
//
//    switch (buttonIndex) {
//        case 0:
//            UIImageWriteToSavedPhotosAlbum(image.image, self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(int *)contextInfo{
//    
//    if (error == nil) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//    }else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [alert show];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
