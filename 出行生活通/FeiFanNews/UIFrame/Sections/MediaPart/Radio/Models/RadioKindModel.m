//
//  RadioKindModel.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/3.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioKindModel.h"

@implementation RadioKindModel

- (void)dealloc
{
    self.cid = nil;
    self.cname = nil;
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
