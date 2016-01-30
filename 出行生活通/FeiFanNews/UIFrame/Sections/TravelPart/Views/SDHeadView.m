//
//  SDHeadView.m
//  FeiFanNews
//
//  Created by laouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SDHeadView.h"

@implementation SDHeadView
- (void)dealloc{
    self.userView = nil;
    self.nameLable = nil;
    [super dealloc];

}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.userView];
        [self addSubview:self.nameLable];
    }
    return self;


}

- (UIImageView *)userView{
    if (_userView == nil) {
        self.userView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        [self.userView.layer setCornerRadius:CGRectGetHeight([self.userView bounds]) / 2];
        self.userView.layer.masksToBounds = YES;
    }
    return [[_userView retain]autorelease];


}

- (UILabel *)nameLable{
    if (_nameLable == nil) {
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(45, 5, 250, 30)];
     
    }
    return [[_nameLable retain]autorelease];

}
@end
