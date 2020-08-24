//
//  HTSEditViewModel.h
//  iOSDemo
//
//  Created by bytedance on 2020/8/23.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSEditViewModel : NSObject

- (NSString *)readFromLocalData:(NSString *)key;

- (void)writeToLocalDataWithKey: (NSString *)key value:(NSString *)value;

- (NSNumber *)cellHeight: (NSInteger)section;

- (NSArray *)textEditItemArray;

- (NSArray *)pickerItemArray;

- (void)changeGender: (NSString *)gender;

@end

NS_ASSUME_NONNULL_END
