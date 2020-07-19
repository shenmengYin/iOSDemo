//
//  HTSVideoCollectionViewCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-17.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HTSVideoModel;

@interface HTSVideoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *likeButton;

-(void)initWithVideo: (HTSVideoModel *) video;

@end

NS_ASSUME_NONNULL_END
