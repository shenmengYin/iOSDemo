//
//  HTSVideoModel.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-16.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSVideoModel.h"

@implementation HTSVideoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
        @"videoID": @"video_id",
        @"playAddr": @"play_addr",
        @"coverAddr": @"cover_addr",
        @"likeCount": @"like_count",
        @"playCount": @"play_count"
    };
}

+ (NSValueTransformer *)play_addrJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[PlayAddress class]];
}

@end

@implementation PlayAddress

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
        @"urlList" : @"url_list",
        @"uri" : @"uri"
    };
}

@end
