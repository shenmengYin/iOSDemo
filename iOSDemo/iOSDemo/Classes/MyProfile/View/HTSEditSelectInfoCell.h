//
//  HTSEditSelectInfoCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HTSEditSelectInfoCell;

@protocol HTSEditSelectInfoCellDelegate <NSObject>

- (BOOL)profileCellShouldBeginEditing:(HTSEditSelectInfoCell *)cell;
- (void)selectInfoCell:(HTSEditSelectInfoCell *)cell changeGender:(NSString *)gender;
- (void)selectInfoCell:(HTSEditSelectInfoCell *)cell changeBirthday:(NSString *)birthday;

@end

@interface HTSEditSelectInfoCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel, *genderLabel, *birthdayLabel;
@property (nonatomic, weak) id<HTSEditSelectInfoCellDelegate> delegate;

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
