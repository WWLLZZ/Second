//
//  NewsBigViewCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@interface NewsBigViewCell : UITableViewCell
- (void)assginValueByMovie:(NewsModel *)model;
@end
