//
//  RadioMainCollectionViewCell.h
//  FeiFanNews
//
//  Created by lanouhn on 15/11/2.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioMainModel;

@interface RadioMainCollectionViewCell : UICollectionViewCell

- (void)assignValueByModel:(RadioMainModel *)model;

@end
