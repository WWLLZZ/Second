//
//  TNDetailTextCell.h
//  FeiFanNews
//
//  Created by laouhn on 15/10/31.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TNRowModel;
@interface TNDetailTextCell : UITableViewCell
@property (nonatomic , retain) UILabel *textLab;
@property (nonatomic , retain) UILabel *local_timeLable;
@property(nonatomic,retain)UIImageView *clockView;

- (void)setValueByTNRowModel:(TNRowModel *)TNdetail;
+ (CGFloat)cellHeight:(TNRowModel *)tnDetail;

@end
