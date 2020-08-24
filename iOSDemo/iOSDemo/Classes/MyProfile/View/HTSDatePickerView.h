//
//  HTSDatePickerView.h
//  iOSDemo
//
//  Created by bytedance on 2020/8/24.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HTSDatePickerView;

@protocol HTSDatePickerViewDelegate <NSObject>

- (void)cancelChangeBirthday;
- (void)changeBirthday;

@end

@interface HTSDatePickerView : UIView

@property (nonatomic, weak) id<HTSDatePickerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
