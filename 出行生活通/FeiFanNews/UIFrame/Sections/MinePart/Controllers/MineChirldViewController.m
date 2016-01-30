//
//  MineChirldViewController.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "MineChirldViewController.h"
#import "WeatherController.h"
#import "CollectController.h"
#import "MapsController.h"


#import "EFAnimationViewController.h"

@interface MineChirldViewController ()
@property (nonatomic,retain)UIImageView *cloudView;
@property (nonatomic,retain)UIButton *mapsButton;
@property (nonatomic,retain)UIButton *weatherButton;
@property (nonatomic,retain)UIButton *collectButton;
@property (nonatomic,retain)UIButton *cleanButton;
@property (nonatomic,retain)EFAnimationViewController *viewController;
@end

@implementation MineChirldViewController
- (void)dealloc
{
    [self.viewController.view removeFromSuperview];
    [self.viewController removeFromParentViewController];
    self.cloudView = nil;
    [super dealloc];
}
- (UIImageView *)cloudView{
    if (_cloudView == nil) {
        self.cloudView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    }
    return [[_cloudView retain]autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.viewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });
    self.mapsButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.mapsButton.frame = CGRectMake(100, 100, 100, 30);
    self.mapsButton.backgroundColor = [UIColor greenColor];
    [self.mapsButton setTitle:@"地图" forState:(UIControlStateNormal)];
    [self.mapsButton addTarget:self action:@selector(handleMaps:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.collectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectButton.frame = CGRectMake(100, 150, 100, 30);
    self.collectButton.backgroundColor = [UIColor cyanColor];
    [self.collectButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    [self.collectButton addTarget:self action:@selector(handleCollect:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.weatherButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.weatherButton.frame = CGRectMake(100, 200, 100, 30);
    
    self.weatherButton.backgroundColor = [UIColor magentaColor];
    [self.weatherButton setTitle:@"天气" forState:(UIControlStateNormal)];
    [self.weatherButton addTarget:self action:@selector(handleWeather:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.weatherButton];
    [self.view addSubview:self.collectButton];
    [self.view addSubview:self.mapsButton];
}
- (void)handleMaps:(UIButton *)handle{
    MapsController *maps = [[MapsController alloc]init];
    [self.navigationController pushViewController:maps animated:YES];
    [maps release];
}
- (void)handleCollect:(UIButton *)sender{

    CollectController *collect = [[CollectController alloc]init];
    [self.navigationController pushViewController:collect animated:YES];
    [collect release];
}

- (void)handleWeather:(UIButton *)sender{
    WeatherController *weather = [[WeatherController alloc]init];

    [self.navigationController pushViewController:weather animated:YES];
    [weather release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



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
