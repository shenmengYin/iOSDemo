//
//  HTSProfileHeader.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-22.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HTSUserModel;

@interface HTSProfileHeader : UICollectionReusableView

@property (nonatomic, strong) UIImageView                  *avatar;
@property (nonatomic, strong) UIButton                     *editButton;
@property (nonatomic, strong) UILabel                      *userName;
@property (nonatomic, strong) UILabel                      *userIntro;
@property (nonatomic, strong) UIImageView                  *vIcon;
@property (nonatomic, strong) UITextView                   *vTitle;
@property (nonatomic, strong) UIImageView                  *locIcon;
@property (nonatomic, strong) UITextView                   *city;
@property (nonatomic, strong) UILabel                      *flame;
@property (nonatomic, strong) UILabel                      *followerNum;
@property (nonatomic, strong) UILabel                      *followedNum;
@property (nonatomic, strong) UILabel                      *flameTitle;
@property (nonatomic, strong) UILabel                      *followerNumTitle;
@property (nonatomic, strong) UILabel                      *followedNumTitle;

- (void)initData:(HTSUserModel *)user;

@end

NS_ASSUME_NONNULL_END
