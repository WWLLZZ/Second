//
//  TNDetailiModel.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TNDetailiModel.h"

@implementation TNDetailiModel
- (void)dealloc{
    //self.photo = nil;
    //self.text = nil;
    self.date = nil;
    //self.local_time = nil;
    self.waypoints = nil;
    self.day = nil;
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{



}
@end
