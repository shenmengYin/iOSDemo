//
//  HTSEditIntroCell.h
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSEditIntroCell : UITableViewCell

@property (nonatomic, strong) UITextView* introTextView;

- (void)setViewText:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
