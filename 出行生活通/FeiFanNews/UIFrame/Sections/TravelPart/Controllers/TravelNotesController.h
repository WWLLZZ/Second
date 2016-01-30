//
//  TravelNotesController.h
//  FeiFanNews
//
//  Created by laouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelNotesController : UITableViewController
@property(nonatomic,copy)NSString *id;
@property (nonatomic , retain) NSIndexPath *TNIndexPath;

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *titleName;

@end
