//
//  HTSUserModel.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-16.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSUserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger follower_count;

@property (nonatomic, assign) NSInteger following_count;



@end

NS_ASSUME_NONNULL_END
