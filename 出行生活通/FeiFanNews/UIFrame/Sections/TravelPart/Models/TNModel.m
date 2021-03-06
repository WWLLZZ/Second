//
//  TNModel.m
//  FeiFanNews
//
//  Created by laouhn on 15/10/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TNModel.h"

@implementation TNModel
- (void)dealloc{
    self.id1 = nil;
    self.titleName = nil;
    self.cover_image = nil;
    self.first_day = nil;
    self.day_count = nil;
    
    self.name = nil;
    self.avatar_s = nil;
    self.type = nil;
    self.popular_place_str = nil;
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.id1 = value;
    }

}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@--%ld--%@",_titleName,_name,_first_day,_cover_image,_popular_place_str,_view_count,_type];
}

@end
