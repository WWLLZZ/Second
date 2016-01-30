//
//  StroyViewCell.h
//  FeiFanNews
//
//  Created by laouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoryModel;
@interface StroyViewCell : UICollectionViewCell
@property(nonatomic,retain)UIImageView *picView;
@property(nonatomic,retain)UILabel *titleLable;
@property(nonatomic,retain)UILabel *nameLable;
@property(nonatomic,retain)UIImageView *avatarView;
//给cell赋值的方法
- (void)setValueByStoryModel:(StoryModel *)storymodel;
@end
