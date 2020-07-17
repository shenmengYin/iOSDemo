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

@property (nonatomic, copy) NSString *videoID;

@property (nonatomic, strong) PlayAddress *playAddr;

@property (nonatomic, copy) NSString *coverAddr;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, assign) NSInteger playCount;

@end

@interface PlayAddress : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray<NSString *> *urlList;

@property (nonatomic, copy) NSString *uri;

@end

NS_ASSUME_NONNULL_END
