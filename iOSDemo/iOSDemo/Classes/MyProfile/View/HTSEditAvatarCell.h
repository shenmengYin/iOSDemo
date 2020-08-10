//
//  HTSEditAvatarCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSEditAvatarCell : UITableViewCell

@property (nonatomic, assign) NSString *avatarUrl;
@property (nonatomic, strong) UIImageView *avatar;

+ (CGFloat)cellHeight;


- (void)setTitleStr:(NSString *)title;
//- (void)bindWithViewModel:(HTSVideoCellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
