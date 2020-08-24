//
//  HTSProfileEditTextCell.h
//  iOSDemo
//
//  Created by bytedance on 2020/8/23.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HTSProfileEditTextCell;

@protocol HTSProfileEditTextCellDelegate <NSObject>

- (void)editCell:(HTSProfileEditTextCell *)cell copyUserId:(NSString *)userId;             /* 复制火山ID */

@end

@interface HTSProfileEditTextCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *valueTextField;
@property (strong, nonatomic) UIButton *userIdCopyButton;
@property (strong, nonatomic) UILabel *wordCountLabel;
@property (nonatomic, weak) id<HTSProfileEditTextCellDelegate> delegate;

+ (CGFloat)cellHeight;

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;



@end

NS_ASSUME_NONNULL_END
