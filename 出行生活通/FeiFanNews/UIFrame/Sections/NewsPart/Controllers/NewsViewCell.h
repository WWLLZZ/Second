//
//  NewsViewCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsViewCell : UITableViewCell
- (void)assginValueByMovie:(NewsModel *)model;
@end
