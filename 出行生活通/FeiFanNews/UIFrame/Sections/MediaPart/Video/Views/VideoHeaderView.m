//
//  VideoHeaderView.m
//  FeiFanNews
//
//  Created by lanouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "VideoHeaderView.h"
#import "FeiFanHeader.h"

@interface VideoHeaderView ()


@end

@implementation VideoHeaderView

- (void)dealloc
{
    self.buttonOne = nil;
    self.buttonTwo = nil;
    self.buttonThree = nil;
    self.buttonFour = nil;
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self buildButton];
    }
    return self;


}

- (void)buildButton{
    
    self.buttonOne = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonOne.frame = CGRectMake(0, 0, MAIN_VIDEOHEADER_WIDTH, MAIN_VIDEOHEADER_HEIGHT);
    [self.buttonOne setTitle:@"奇葩" forState:(UIControlStateNormal)];
    self.buttonOne.backgroundColor = [UIColor redColor];
    self.buttonTwo.tintColor = [UIColor magentaColor];

    [self addSubview:self.buttonOne];
    
    
    self.buttonTwo = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonTwo.frame = CGRectMake(MAIN_VIDEOHEADER_WIDTH, 0, MAIN_VIDEOHEADER_WIDTH, MAIN_VIDEOHEADER_HEIGHT);
    [self.buttonTwo setTitle:@"萌物" forState:(UIControlStateNormal)];
    self.buttonTwo.backgroundColor = [UIColor orangeColor];

    [self addSubview:self.buttonTwo];
    
    self.buttonThree = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonThree.frame = CGRectMake(MAIN_VIDEOHEADER_WIDTH*2, 0, MAIN_VIDEOHEADER_WIDTH, MAIN_VIDEOHEADER_HEIGHT);
    [self.buttonThree setTitle:@"美女" forState:(UIControlStateNormal)];
    self.buttonThree.backgroundColor = [UIColor yellowColor];

    [self addSubview:self.buttonThree];
    
    self.buttonFour = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.buttonFour.frame = CGRectMake(MAIN_VIDEOHEADER_WIDTH*3, 0, MAIN_VIDEOHEADER_WIDTH, MAIN_VIDEOHEADER_HEIGHT);
    [self.buttonFour setTitle:@"精品" forState:(UIControlStateNormal)];
    self.buttonFour.backgroundColor = [UIColor greenColor];
  
    [self addSubview:self.buttonFour];
    
    
}





















@end
