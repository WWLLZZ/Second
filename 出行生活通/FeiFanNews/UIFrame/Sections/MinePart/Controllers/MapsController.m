//
//  MapsController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "MapsController.h"
#import "PopoverView.h"
//导入地图
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>
#import "MapsAnnotation.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MapsController ()<UISearchBarDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,retain)MKMapView *mapsView;
@property (nonatomic,retain)CLLocationManager *locationManager;
@property (nonatomic,retain)CLGeocoder *geocoder;
@property (nonatomic,retain)UIButton *backButton;

@end

@implementation MapsController

- (UIButton *)backButton{
    if (_backButton == nil) {
        self.backButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        self.backButton.frame = CGRectMake(-15, 20, 80, 30);
    }
    return [[_backButton retain]autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self.backButton setImage:[UIImage imageNamed:@"back_button"] forState:(UIControlStateNormal)];
//    self.backButton.frame = CGRectMake(0, 20, 100, 30);
    [self.backButton addTarget:self action:@selector(backtoWeather:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.backButton];
    
    
//    添加搜索框
    self.searchPlace = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - self.backButton.bounds.size.width-60, 30)];
    self.searchPlace.placeholder = @"请输入地点";
    self.searchPlace.barStyle = UIBarStyleDefault;
    self.navigationItem.titleView = self.searchPlace;
    self.searchPlace.showsCancelButton = YES;
    self.searchPlace.layer.cornerRadius = 6;
    self.searchPlace.layer.masksToBounds = YES;
    self.searchPlace.delegate = self;
//  类型选择按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"类型" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    
    
//   添加地图View
    self.mapsView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.mapsView];
//   添加地图的代理:
    self.mapsView.delegate = self;
//    地图视图上面显示的数据类型,标准MKMapTypeStandard 卫星MKMapTypeSatellite 混合MKMapTypeHybrid
    self.mapsView.mapType = MKMapTypeStandard;
    
    
//    请求定位服务
    self.locationManager = [[CLLocationManager alloc]init];
    
    self.locationManager.delegate = self;
//    定位精度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
//    开始定位用户当前的位置
    [self.locationManager startUpdatingLocation];
    
    
    if (![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestWhenInUseAuthorization];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"定位系统已被禁止,请进行设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
        [alertView release];
    }
//    设置跟踪模式
    self.mapsView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
//    设置单个地图标记位置
    self.geocoder = [[CLGeocoder alloc]init];

//    [self listPlacemark];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, kScreenHeight * 0.11, 40, 40);
    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"location"]];
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button release];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    // 用来表示某个位置的地理信息, 比如经纬度, 海拔等等
    CLLocation *location = [locations lastObject];
//    NSLog(@"经度 == %f, 纬度 == %f", location.coordinate.longitude, location.coordinate.latitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            NSString *city = placemark.administrativeArea;
//            NSLog(@"位于:%@",city);
            self.searchPlace.text = city;
        } else {
//            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    // 停止更新位置
    [manager stopUpdatingLocation];
}
- (void)buttonTouch:(UIButton *)sender{
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:nil message:@"是否需要打开系统地图?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alterView show];
    [alterView release];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self listPlacemark];
            break;
        default:
            break;
    }
    
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}

//地理编码
- (void)getcoordinateByAddress:(NSString *)address{
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
//     1.取得一个地标，地标中存储了详细的地址信息
//        一个地名可能搜索出多个地址
        CLPlacemark *placeMark = [placemarks firstObject];
        CLLocation *location = placeMark.location;
        //2.取出位置坐标
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
        NSLog(@"%@",placeMark.administrativeArea);
    
        //3.添加大头针
        CLLocationCoordinate2D location1= CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        MapsAnnotation *annotation = [[MapsAnnotation alloc]init];
        annotation.title = self.searchPlace.text;
        annotation.coordinate = location1;
        annotation.image = [UIImage imageNamed:@"11"];
        [self.mapsView addAnnotation:annotation];
        [annotation release];

        
        
//4.设置地图显示的区域(显示区域大小和中心点)
        MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
        MKCoordinateRegion region = MKCoordinateRegionMake(location1, span);
        [self.mapsView setRegion:region animated:YES];
    }];


}
#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[MapsAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapsView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];//定义详情左侧视图
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((MapsAnnotation *)annotation).image;//设置大头针视图的图片
        return annotationView;
        
    }else {
        return nil;
    }
}

#pragma mark 在地图上定位
//-(void)location{
//    //根据“北京市”进行地理编码
//    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *clPlacemark=[placemarks firstObject];//获取第一个地标
//        MKPlacemark *mkplacemark=[[MKPlacemark alloc]initWithPlacemark:clPlacemark];//定位地标转化为地图的地标
//        NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
//        MKMapItem *mapItem=[[MKMapItem alloc]initWithPlacemark:mkplacemark];
//        [mapItem openInMapsWithLaunchOptions:options];
//    }];
//}
-(void)listPlacemark{
    //根据“北京市”进行地理编码
//    NSString *string = self.searchPlace.text;
    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark1=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark1=[[MKPlacemark alloc]initWithPlacemark:clPlacemark1];
        //注意地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        [_geocoder geocodeAddressString:@"郑州市" completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *clPlacemark2=[placemarks firstObject];//获取第一个地标
            MKPlacemark *mkPlacemark2=[[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
            NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
            //MKMapItem *mapItem1=[MKMapItem mapItemForCurrentLocation];//当前位置
            MKMapItem *mapItem1=[[MKMapItem alloc]initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
            
        }];
        
    }];
}

#pragma mark - 搜索框的代理事件
//取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchPlace setShowsCancelButton:YES animated:YES];
    self.searchPlace.text = nil;
    [self.searchPlace resignFirstResponder];
}
//搜索按钮的点击事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self getcoordinateByAddress:self.searchPlace.text];
    [self.searchPlace resignFirstResponder];
}

#pragma mark - right的点击事件
- (void)rightAction:(UIButton*)sender
{
    CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width , self.navigationController.navigationBar.frame.size.height + 20);
    NSArray *titles = @[@"标准" , @"卫星" , @"混合"];
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:nil];
    pop.selectRowAtIndex = ^(NSInteger index){
        if (index == 0) {
            self.mapsView.mapType = MKMapTypeStandard;
        }else if (index == 1){
            self.mapsView.mapType = MKMapTypeSatellite;
        }else{
            self.mapsView.mapType = MKMapTypeHybrid;
        }
    };
    [pop show];
}
- (void)backtoWeather:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - left的点击事件
- (void)leftAction:(UIBarButtonItem *)sender
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
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
