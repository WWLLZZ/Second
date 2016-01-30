//
//  NewsDetailController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NewsDetailController.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NewsController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface NewsDetailController ()<UIWebViewDelegate>
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)NSMutableArray *imgArray;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *bodyLabel;
@property (nonatomic,retain)NewsModel *model;
@property (nonatomic,retain)UIWebView *webView;
//视频播放器
@property (nonatomic,retain)MPMoviePlayerViewController *mediaPlayer;

@end

@implementation NewsDetailController
- (void)dealloc
{
    self.webView = nil;
    self.model = nil;
    self.scrollView = nil;
    self.imgArray = nil;
    self.titleLabel = nil;
    self.bodyLabel = nil;
    self.otherID = nil;
    self.detailID = nil;
    self.mediaPlayer = nil;
    [super dealloc];
}
//- (UIWebView *)webView{
//    if (_webView == nil) {
//        self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
//        self.webView.backgroundColor = [UIColor cyanColor];
//    }
//    return [[_webView retain]autorelease];
//}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bodyLabel.frame];
    }
    return [[_scrollView retain]autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self readDateFromNetWorking];
    if (self.model.video != nil) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0 ,200, kScreenWidth, [UIScreen mainScreen].bounds.size.height-250)];
        //    UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        //    [webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL    URLWithString:@"http://flv2.bn.netease.com/videolib3/1510/30/oiuxC0185/SD/oiuxC0185-mobile.mp4"]]];
        //    [self.view addSubview:webView1];
        self.mediaPlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1510/30/oiuxC0185/SD/oiuxC0185-mobile.mp4"]];
        [self.mediaPlayer.view setFrame:CGRectMake(0, 44, kScreenWidth, 200)];
        [self.view addSubview:self.mediaPlayer.view];
    }else{
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0 ,0, kScreenWidth, [UIScreen mainScreen].bounds.size.height)];
    }
    self.webView.backgroundColor = [UIColor whiteColor];
//    去掉黑块
    self.webView.opaque = NO;


//    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.detailID];
    [self.view addSubview:_webView];

    self.webView.delegate = self;
}

- (void)readDateFromNetWorking{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.detailID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    __block typeof(self) weakSelf = self;
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.model = [NewsModel detailImageWithDic:responseObject[self.detailID]];
        [self showInWebView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"model.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    

    
    [self.webView loadHTMLString:html baseURL:nil];
    
//    NSLog(@"@@@@@@@@@@@%@",self.webView);
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.model.ptime];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.model.title];
       if (self.model.body != nil) {
        [body appendString:self.model.body];
    }
    // 遍历img
//    NSLog(@"%@",self.model.img);
    for (NSDictionary *dict in self.model.img) {
        NewsModel *detailImgModel = [[NewsModel alloc]init];
        [detailImgModel setValuesForKeysWithDictionary:dict];
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
//        [imgHtml appendFormat:@"<embed src=\"%@\" quality=\"high\" width=\"305\" height=\"200\1\"align=\"middle\" allowScriptAccess=\"always\" allowFullScreen=\"true\" mode=\"transparent\" type=\"application/x-shockwave-mp4\"></embed>",self.model.url_mp4];
//        [imgHtml appendFormat:@"<video webkit-playsinline width=\"%f\" height=\"%f\" class=\"vplayinside notaplink\" x-webkit-airplay controls loop=\"loop\" <source src=\"%@\" type=\"video/mp4\"></video>",width,height,self.model.url_mp4];

        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        
 
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
   return body;
}





- (void)handlePage{
    CGFloat x = self.scrollView.contentOffset.x;
    x+=[UIScreen mainScreen].bounds.size.width;
    if (x > kScreenWidth * 6) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(x, 0);}
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
