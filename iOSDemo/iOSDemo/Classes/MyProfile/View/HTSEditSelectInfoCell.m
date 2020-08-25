//
//  HTSEditSelectInfoCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditSelectInfoCell.h"
#import "HTSDatePickerView.h"

@interface HTSEditSelectInfoCell ()

@end

@implementation HTSEditSelectInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.genderLabel];
        [self addSubview:self.birthdayLabel];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)genderLabel{
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, [UIScreen mainScreen].bounds.size.width -(110+10) - 30, 30)];
        _genderLabel.backgroundColor = [UIColor clearColor];
        _genderLabel.font = [UIFont systemFontOfSize:15];
        _genderLabel.textColor = [UIColor blackColor];
        _genderLabel.textAlignment = NSTextAlignmentLeft;
        _genderLabel.adjustsFontSizeToFitWidth = YES;
        _genderLabel.minimumScaleFactor = 0.6;
        _genderLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeGender:)];
        [_genderLabel addGestureRecognizer:tapGesture];
    }
    return _genderLabel;
}

- (UILabel *)birthdayLabel{
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, [UIScreen mainScreen].bounds.size.width -(110+10) - 30, 30)];
        _birthdayLabel.backgroundColor = [UIColor clearColor];
        _birthdayLabel.font = [UIFont systemFontOfSize:15];
        _birthdayLabel.textColor = [UIColor blackColor];
        _birthdayLabel.textAlignment = NSTextAlignmentLeft;
        _birthdayLabel.adjustsFontSizeToFitWidth = YES;
        _birthdayLabel.minimumScaleFactor = 0.6;
        _birthdayLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBirthday:)];
        [_birthdayLabel addGestureRecognizer:tapGesture];
    }
    return _birthdayLabel;
}


- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    NSArray *needGenderSelector = [NSArray arrayWithObjects:@"性别", nil];
    NSArray *needBirthdaySelector = [NSArray arrayWithObjects:@"生日", nil];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = title;
    self.genderLabel.text = value;
    self.birthdayLabel.text = value;
    if([needGenderSelector containsObject:title]){
        [self.birthdayLabel removeFromSuperview];
    }
    if([needBirthdaySelector containsObject:title]){
        [self.genderLabel removeFromSuperview];
    }
}

+ (CGFloat)cellHeight{
    return 44.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshGenderLabel{
    [self.genderLabel removeFromSuperview];
    [self.contentView addSubview:self.genderLabel];
}

- (void)changeGender:(UITapGestureRecognizer *)tapGesture
{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(selectInfoCell:changeGender:)]) {
        [delegate selectInfoCell:self changeGender:self.genderLabel.text];
    }
}

- (void)changeBirthday:(UITapGestureRecognizer *)tapGesture
{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(selectInfoCell:changeBirthday:)]) {
        [delegate selectInfoCell:self changeBirthday:self.birthdayLabel.text];
    }
}


@end
