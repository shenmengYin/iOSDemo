//
//  HTSDatePickerView.m
//  iOSDemo
//
//  Created by bytedance on 2020/8/24.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSDatePickerView.h"

#import <Masonry/Masonry.h>

@interface HTSDatePickerView ()

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *selectedDate;


@end

@implementation HTSDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.toolBar];
        [self addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.toolBar.mas_bottom);
            make.left.mas_equalTo(self.toolBar.mas_left);
        }];
    }
    return self;
}

- (UIDatePicker *)datePicker{
    if(!_datePicker){
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setDate:[NSDate date]];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
    }
        return _datePicker;
}

- (UIToolbar *)toolBar
{
    if(!_toolBar){
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.backgroundColor = [UIColor grayColor];
        _toolBar.frame = CGRectMake(0, 0, self.bounds.size.width, 44);
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(datePickerCancel)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDone)];
        _toolBar.items = @[cancel, flexSpace, done];
    }
    return _toolBar;
}

- (void)datePickerCancel{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(datePickerCancel)]) {
        [delegate datePickerCancel];
    }
}

- (void)datePickerDone{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(datePickerDone)]) {
        [delegate datePickerDone];
    }
}

- (NSString *)dateInString{
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"MM/dd/yyyy"];
    self.selectedDate = self.datePicker.date;
    return [self.dateFormatter stringFromDate:self.selectedDate];
}

@end
