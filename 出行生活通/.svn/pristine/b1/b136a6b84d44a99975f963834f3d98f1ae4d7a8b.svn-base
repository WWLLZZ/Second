//
//  TNDetailTextCell.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/31.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TNDetailTextCell.h"
#import "FeiFanHeader.h"
#import "TNRowModel.h"
@implementation TNDetailTextCell
- (void)dealloc{
    self.local_timeLable = nil;
    self.textLab = nil;
    self.clockView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.local_timeLable];
        [self.contentView addSubview:self.textLab];
        [self.contentView addSubview:self.clockView];
        
    }
    return self;

}

- (void)setValueByTNRowModel:(TNRowModel *)TNdetail{
    self.textLab.text = TNdetail.text;
    CGRect tectRect = self.textLab.frame;
    tectRect.size.height = [[self class]textLableHeight:TNdetail.text];
    self.textLab.frame = tectRect;



}
+ (CGFloat)cellHeight:(TNRowModel *)tnDetail{
    CGFloat textHeight = [self textLableHeight:tnDetail.text];
    return 8.5+20+10+textHeight;


}


//自适应内容的高度
+ (CGFloat)textLableHeight:(NSString *)text{
    CGSize contentSize = CGSizeMake(330, 0);
    NSDictionary *attibute = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0]};
    CGRect textRect = [text boundingRectWithSize:contentSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attibute context:nil];
    return textRect.size.height;
    
}

- (UIImageView *)clockView{
    if (_clockView == nil) {
        self.clockView = [[UIImageView alloc]initWithFrame:CGRectMake(0.3*kSpace, 0.85*kSpace, 1.3*kSpace, 1.3*kSpace)];
//        self.clockView.backgroundColor = [UIColor redColor];
        self.clockView.image = [UIImage imageNamed:@"clock"];
    }
    return [[_clockView retain]autorelease];
    
}

- (UILabel *)local_timeLable{
    if (_local_timeLable == nil) {
        self.local_timeLable = [[UILabel alloc]initWithFrame:CGRectMake(1.7*kSpace,0.85*kSpace, MAIN_SCREEN_WIDTH * 0.62, 1.3*kSpace)];
//        self.local_timeLable.backgroundColor = [UIColor redColor];
    }
    
    return [[_local_timeLable retain]autorelease];
}
- (UILabel *)textLab{
    if (_textLab == nil) {
        self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(1.7*kSpace, 30, MAIN_SCREEN_WIDTH * 0.87, MAIN_SCREEN_WIDTH *0.31)];
//        self.textLab.backgroundColor = [UIColor redColor];
        self.textLab.numberOfLines = 0;
    }
    return [[_textLab retain]autorelease];


}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
