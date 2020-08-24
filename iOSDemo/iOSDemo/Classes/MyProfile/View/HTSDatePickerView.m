//
//  HTSDatePickerView.m
//  iOSDemo
//
//  Created by bytedance on 2020/8/24.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSDatePickerView.h"

@interface HTSDatePickerView ()

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

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
        _toolBar.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0];
        _toolBar.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, 44);
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelChangeBirthday)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeBirthday)];
        _toolBar.items = @[cancel, flexSpace, done];
    }
    
    return _toolBar;
}

- (void)cancelChangeBirthday{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(cancelChangeBirthday)]) {
        [delegate cancelChangeBirthday];
    }
}

- (void)changeBirthday{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(changeBirthday)]) {
        [delegate changeBirthday];
    }
}

@end
