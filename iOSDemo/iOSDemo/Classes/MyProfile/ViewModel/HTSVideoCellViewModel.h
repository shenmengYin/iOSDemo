//
//  HTSVideoCellViewModel.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-19.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN
@class HTSVideoModel;
@interface HTSVideoCellViewModel : NSObject

@property (nonatomic) NSString *cellName;
@property (nonatomic) RACSignal *coverImageSignal; //UIImage
@property (nonatomic) RACSignal *likeCountSignal; //NSNumber
@property (nonatomic) RACSignal *playCountSignal; //NSNumber
@property (nonatomic) RACSignal *displaySignal; //NSNumber


- (instancetype)initWithVideo:(HTSVideoModel *)video;

@end

NS_ASSUME_NONNULL_END
