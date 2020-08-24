//
//  HTSVideoCollectionViewCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-17.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSVideoCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class HTSVideoCellViewModel;

@interface UIButton (RACTitleSupport)
@property (strong, nonatomic) NSString *racExt_Title;
@end

@interface HTSVideoCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSString *imageURL;

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIButton *likeButton;

- (void)bindWithViewModel:(HTSVideoCellViewModel *)viewModel;

- (void)updateWithImageURL:(NSString*) imageURL likeCount:(NSInteger) likeCount;

@end

NS_ASSUME_NONNULL_END
