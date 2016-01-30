//
//  StoryDetailCell.h
//  FeiFanNews
//
//  Created by laouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoryDetailModel;

@interface StoryDetailCell : UICollectionViewCell
@property(nonatomic,retain)UIImageView *photoView;
@property(nonatomic,retain)UILabel *textLable;

- (void)setValueByStoryModel:(StoryDetailModel *)storyModel;
+ (CGFloat)cellHeight:(StoryDetailModel *)storyModel;
@end
