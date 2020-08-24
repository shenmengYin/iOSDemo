//
//  HTSEditViewModel.m
//  iOSDemo
//
//  Created by bytedance on 2020/8/23.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditViewModel.h"

@implementation HTSEditViewModel

- (NSArray *)textEditItemArray{
    return [NSArray arrayWithObjects:@"昵称", @"火山号", nil];
}

- (NSArray *)pickerItemArray{
    return [NSArray arrayWithObjects:@"性别", @"生日", nil];
}

- (NSString *)readFromLocalData:(NSString *)key{
    NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [sandBoxPath objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userInfo.plist"];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return dataDic[key] ?: @"";
}

- (void)writeToLocalDataWithKey: (NSString *)key value:(NSString *)value{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [sandBoxPath objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"userInfo.plist"];
    NSMutableDictionary *dataDic;
    if (![fileManager fileExistsAtPath: plistPath]){
        [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
        dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    else{
        dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    }
    [dataDic setObject:value ?: @"" forKey:key];
    [dataDic writeToFile:plistPath atomically:YES];
}

- (NSNumber *)cellHeight: (NSInteger)section{
    return section == 1 ? @132 : @44;
}

- (void)changeGender: (NSString *)gender{
    [self writeToLocalDataWithKey:@"性别" value:gender];
}

@end
