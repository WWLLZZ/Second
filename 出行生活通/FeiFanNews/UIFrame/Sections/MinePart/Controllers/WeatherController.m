//
//  WeatherController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WeatherController.h"
#import "WeatherModel.h"
#import "WeatherCell.h"

@interface WeatherController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
//返回按钮
@property (nonatomic,retain)UIButton            *backButton;
//搜索框
@property (nonatomic,retain)UISearchBar         *searchPlace;
//接收数据
@property (nonatomic,retain)NSMutableDictionary *placeDic;
@property (nonatomic,retain)NSMutableArray      *weatherArray;
@property (nonatomic,retain)NSString            *weaidKey;
@property (nonatomic,retain)WeatherModel        *model;

@end

@implementation WeatherController
- (void)dealloc
{
    self.backButton = nil;
    [super dealloc];
}
- (UIButton *)backButton{
    if (_backButton ==nil) {
        self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return [[_backButton retain]autorelease];
}
- (NSMutableArray *)weatherArray{
    if (_weatherArray == nil) {
        self.weatherArray = [NSMutableArray arrayWithCapacity:0];
    }
    return [[_weatherArray retain]autorelease];
}


- (void)loadView{
    [super loadView];
//    self.view
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[WeatherCell class] forCellReuseIdentifier:@"cellId"];
 
//    [self.backButton setTitle:@"返回" forState:(UIControlStateNormal)];
    [self.backButton setImage:[UIImage imageNamed:@"back_button"] forState:(UIControlStateNormal)];
    [self.backButton addTarget:self action:@selector(backtoWeather:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.backButton];
    [self placeLoadDateShow];
    self.searchPlace = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 240, 30)];
    self.searchPlace.placeholder = @"请输入地点:";
    self.navigationItem.titleView = self.searchPlace;
    self.searchPlace.showsCancelButton = YES;
    self.searchPlace.layer.cornerRadius = 7;
    self.searchPlace.layer.masksToBounds = YES;
    self.searchPlace.delegate = self;
    self.weaidKey = @"59";
    [self weatherLoadDataShow];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
//    [view addSubview:self.backButton];
//    [self.tableView.tableHeaderView addSubview:self.backButton];
//     self.tableView.tableHeaderView = view;
    
}

//获取地点
- (void)placeLoadDateShow{
    NSString *urlString = @"http://api.k780.com:88/?app=weather.city&format=json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (NSString *key in dataDic) {
                if ([key isEqualToString:@"result"]) {
                    self.placeDic = dataDic[key];
                }
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)weatherLoadDataShow
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.k780.com:88/?app=weather.future&weaid=%@&appkey=15080&sign=ce13066b71dd9f5e156148e40eb4ca8f&format=json" , self.weaidKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (NSString *key in [dataDic allKeys]) {
                if ([key isEqualToString:@"result"]) {
                    for (NSDictionary *miniDic in dataDic[key]) {
                        self.model = [[WeatherModel alloc] init];
                        [self.model setValuesForKeysWithDictionary:miniDic];
                        [self.weatherArray addObject:self.model];
                    }
                }
            }
        }
        [self.tableView reloadData];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.weatherArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 30;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215;
}
- (void)backtoWeather:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellId = @"cellId";
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather.jpg"]];
    WeatherModel *model = [[WeatherModel alloc] init];
    model = self.weatherArray[indexPath.section];
    [cell assginValueByMovie:model];
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [self.searchPlace resignFirstResponder];
    
    for (NSString *placeKey in [self.placeDic allKeys]) {
        NSDictionary *miniDic  = self.placeDic[placeKey];
        //搜索框输入汉字 对应的key值 @"citynm" 英语@"cityno"
        if ([self.searchPlace.text isEqualToString:miniDic[@"citynm"]] || [self.searchPlace.text isEqualToString:[NSString stringWithFormat:@"%@省" ,miniDic[@"citynm"]]] ||  [self.searchPlace.text isEqualToString:[NSString stringWithFormat:@"%@市" ,miniDic[@"citynm"]]] ||  [self.searchPlace.text isEqualToString:[NSString stringWithFormat:@"%@县" ,miniDic[@"citynm"]]]) {
            self.weaidKey = miniDic[@"weaid"];
        }
    }
    [self.weatherArray removeAllObjects];
    [self weatherLoadDataShow];

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
