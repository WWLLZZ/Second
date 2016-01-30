//
//  RadioListViewCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioMainModel;

@interface RadioListViewCell : UITableViewCell



- (void)assignValueByModel:(RadioMainModel *)model;


@end
