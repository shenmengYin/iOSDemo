//
//  HTSUserModel.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-16.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSUserModel.h"

@implementation HTSUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
        @"userID": @"user_id",
        @"avatar": @"avatar",
        @"name": @"name",
        @"intro": @"intro",
        @"followingCount": @"following_count",
        @"followerCount": @"follower_count",
        @"flameCount": @"follower_count"
    };
}

@end
