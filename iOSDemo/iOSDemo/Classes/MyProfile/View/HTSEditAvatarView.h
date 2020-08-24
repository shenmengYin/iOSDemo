//
//  HTSEditAvatarView.h
//  iOSDemo
//
//  Created by bytedance on 2020/8/23.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class HTSEditAvatarView;

@protocol HTSEditAvatarViewDelegate <NSObject>

- (void)tapAvatarLabel:(UIImageView *)imageView;

@end

@interface HTSEditAvatarView : UIView

@property (nonatomic, weak) id<HTSEditAvatarViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (UIImageView *)avatarImageView;

- (void)setLabelStr:(NSString *)title;

- (void)setAvatarImage:(UIImage *)avatarImage;


@end

NS_ASSUME_NONNULL_END
