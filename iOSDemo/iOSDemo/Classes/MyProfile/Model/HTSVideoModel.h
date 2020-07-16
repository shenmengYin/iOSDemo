//
//  HTSVideoModel.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-16.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@class PlayAddress;

@interface HTSVideoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *video_id;

@property (nonatomic, strong) PlayAddress *play_addr;

@property (nonatomic, copy) NSString *cover_addr;

@property (nonatomic, assign) NSInteger like_count;

@property (nonatomic, assign) NSInteger play_count;

@end

@interface PlayAddress : NSObject

@property (nonatomic, copy) NSArray<NSString *> *url_list;

@property (nonatomic, copy) NSString *uri;

@end

NS_ASSUME_NONNULL_END
