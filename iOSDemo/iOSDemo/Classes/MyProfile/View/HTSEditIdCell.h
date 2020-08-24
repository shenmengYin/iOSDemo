//
//  HTSEditIdCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HTSEditIdCell;

@protocol HTSEditIdCellDelegate <NSObject>

- (void)editIdCell:(HTSEditIdCell *)cell copyUserId:(NSString *)userId;             /* 复制火山ID */

@end

@interface HTSEditIdCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *valueTextField;
@property (strong, nonatomic) UIButton *userIdCopyButton;
@property (nonatomic, weak) id<HTSEditIdCellDelegate> delegate;

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
