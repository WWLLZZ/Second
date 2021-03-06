//
//  TNPicViewController.m
//  FeiFanNews
//
//  Created by laouhn on 15/11/2.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TNPicViewController.h"

#import "TNRowModel.h"
#import "FeiFanHeader.h"
#import "UIImageView+WebCache.h"
#import "FeiFanHeader.h"
#import "UMSocial.h"
@interface TNPicViewController ()
@property (nonatomic , retain) UILabel *indexLab;
@property (nonatomic , retain) UIImageView *imageView;
@property (nonatomic , retain) UIScrollView *scrollView;
@property (nonatomic , retain) NSMutableArray *photoArray;
@property (nonatomic , assign) NSInteger shareIndex;
@property (nonatomic , retain) UIImage *photo;

@end

@implementation TNPicViewController
- (void)dealloc{
    self.dataArray = nil;
    self.indexLab = nil;
    self.scrollView = nil;
    self.photoArray = nil;
    self.imageView = nil;
    self.photo = nil;
    [super dealloc];
}

- (NSMutableArray *)photoArray{
    if (_photoArray == nil) {
        self.photoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_photoArray retain]autorelease];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView release];
    [self creatScrollView];
    [self creatButton];
    
}

- (void)creatScrollView{
    NSMutableArray *textArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *timeArr = [NSMutableArray arrayWithCapacity:0];
    for (TNRowModel *model in self.dataArray) {
        if (![model.photo isEqualToString:@""]) {
            [self.photoArray addObject:model.photo];
            [textArr addObject:model.text];
            [timeArr addObject:model.local_time];
        }
    }
    
    
    
    for (int i = 0; i <self.photoArray.count; i++) {
        //创建imageView
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH *i, 15*kSpace, MAIN_SCREEN_WIDTH, MAIN_SCREEN_WIDTH * 0.68)];
       
        self.imageView.userInteractionEnabled = YES;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoArray[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:self.imageView];
        [self.imageView release];
        //创建图片索引Label
        self.indexLab = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * i, 80, MAIN_SCREEN_WIDTH, 30)];
        self.indexLab.textAlignment = NSTextAlignmentCenter;
        self.indexLab.textColor = [UIColor whiteColor];
        //        self.indexLab.font = [UIFont systemFontOfSize:15];
        self.indexLab.text = [NSString stringWithFormat:@"%d/%ld"  , i + 1 , self.photoArray.count];
//        self.indexLab.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:self.indexLab];
        
        // text Lab
        UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * i+5, self.scrollView.frame.size.height - 120, MAIN_SCREEN_WIDTH-10, 80)];
        textLab.text = textArr[i];
        textLab.numberOfLines = 0;
//        textLab.backgroundColor = [UIColor redColor];
        textLab.textColor = [UIColor whiteColor];
        textLab.font = [UIFont systemFontOfSize:12];
        [self.scrollView addSubview:textLab];
        [textLab release];
        
        
        // 时间lab
        
        UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * i, self.scrollView.frame.size.height - 30, MAIN_SCREEN_WIDTH, 30)];
        [self.scrollView addSubview:dateLab];
        
        UIImageView *clockView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 8.5, 13, 13)];
        clockView.image = [UIImage imageNamed:@"clock"];
        [dateLab addSubview:clockView];
        [clockView release];
        
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, MAIN_SCREEN_WIDTH, 30)];
        timeLab.text = timeArr[i];
     
        timeLab.font = [UIFont systemFontOfSize:10];
        timeLab.textColor = [UIColor whiteColor];
        
        [dateLab addSubview:timeLab];
        [timeLab release];
    }
    // 设置偏移量
    self.scrollView.contentOffset = CGPointMake(MAIN_SCREEN_WIDTH * self.index, 0);
    self.scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH * self.photoArray.count, self.view.frame.size.height);
    
    // 按一个整页滑动
    self.scrollView.pagingEnabled = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)creatButton{
    //返回按钮
    UIButton *backBttonn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBttonn.frame = CGRectMake(2*kSpace, 4*kSpace, 30, 30);
    [backBttonn setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    //    [backBtn setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateSelected];
    [backBttonn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBttonn];
    //分享按钮
//    UIButton *shareBrn = [UIButton buttonWithType:UIButtonTypeSystem];
//    shareBrn.frame = CGRectMake(MAIN_SCREEN_WIDTH - 52, 4*kSpace, 30, 30);
//    shareBrn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:15];
//    //    [shareBrn setTitle:@"分享" forState:UIControlStateNormal];
//    [shareBrn setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
//    //    [shareBrn setTintColor:[UIColor whiteColor]];
//    [shareBrn addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:shareBrn];


}
// button点击事件
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
////分享点击事件的实现
//- (void)shareButtonAction:(UIButton *)sender{
//    self.shareIndex = self.scrollView.contentOffset.x / self.view.frame.size.width;
//    
//    NSString *photoStr = self.photoArray[self.shareIndex];
//    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photoStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.photo = image;
//    }];
//
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"5580039667e58e9e15000e9f"
//                                      shareText:@"分享图片"
//                                     shareImage:self.photo
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToQzone,UMShareToWechatTimeline,nil]
//                                       delegate:nil];
//    
//    
//    
//}



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
