//
//  StoryDetailCell.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "StoryDetailCell.h"
#import "StoryDetailModel.h"
#import "UIImageView+WebCache.h"
#import "FeiFanHeader.h"

@implementation StoryDetailCell
- (void)dealloc{
    self.photoView = nil;
    self.textLable = nil;
    [super dealloc];

}
+ (CGFloat)cellHeight:(StoryDetailModel *)storyModel{
    CGFloat textHeight = [self textLableHeight:storyModel.text];
    return 10+MAIN_SCREEN_WIDTH*0.9+20+textHeight;
    

}

//自适应内容的高度
+ (CGFloat)textLableHeight:(NSString *)text{
    CGSize contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, 0);
    NSDictionary *attibute = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0]};
    CGRect textRect = [text boundingRectWithSize:contentSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attibute context:nil];
    return textRect.size.height;
    
}


- (void)setValueByStoryModel:(StoryDetailModel *)storyDetailModel{

   
    CGRect tectRect = self.textLable.frame;
    tectRect.size.height = [[self class]textLableHeight:storyDetailModel.text];
    self.textLable.frame = tectRect;
 

}
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.photoView];
        [self addSubview:self.textLable];
    }
     return self;
}
- (UIImageView *)photoView{
    if (_photoView == nil) {
        self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH-20, MAIN_SCREEN_WIDTH * 0.9)];
//        self.photoView.backgroundColor = [UIColor redColor];
        self.photoView.layer.cornerRadius = 7;
        self.photoView.layer.masksToBounds = YES;
    }
    return [[_photoView retain]autorelease];

}
- (UILabel *)textLable{
    if (_textLable == nil) {
        self.textLable = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.003, CGRectGetMaxY(self.photoView.frame)+5, MAIN_SCREEN_WIDTH *0.93, MAIN_SCREEN_WIDTH * 0.25)];
        self.textLable.numberOfLines = 0;
//        self.textLable.backgroundColor = [UIColor redColor];
    }
    return [[_textLable retain]autorelease];


}
@end
