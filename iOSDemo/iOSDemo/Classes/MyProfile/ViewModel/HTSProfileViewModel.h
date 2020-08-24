//
//  HTSProfileViewModel.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-19.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


NS_ASSUME_NONNULL_BEGIN

@interface HTSProfileViewModel : NSObject

//@property (nonatomic, readonly) RACSignal *dataSignal;  // <NSArray<HTSVideoModel *> *>
//@property (nonatomic, readonly) RACSignal *errorSignal;
//@property (nonatomic, readonly) RACCommand *loadDataCommand;

- (NSArray *)loadVideoData;

//- (RACSignal *)loadVideoData;

@end

NS_ASSUME_NONNULL_END
