//
//  HTSEditNameCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface HTSEditNameCell : UITableViewCell
//@property (nonatomic, weak) id <UITextFieldDelegate>    delegate;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *wordCountLabel;
@property (strong, nonatomic) UITextField *valueTextField;


+ (CGFloat)cellHeight;

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
