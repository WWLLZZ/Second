//
//  RadioPlayModel.m
//  FeiFanNews
//
//  Created by lanouhn on 15/11/4.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RadioPlayModel.h"

@implementation RadioPlayModel

- (void)dealloc
{
    self.docid = nil;
    self.title = nil;
    self.ptime = nil;
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
