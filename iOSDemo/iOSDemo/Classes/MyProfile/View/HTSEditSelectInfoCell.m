//
//  HTSEditSelectInfoCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditSelectInfoCell.h"

@interface HTSEditSelectInfoCell ()
//@property (strong, nonatomic) UILabel *titleLabel, *genderLabel, *birthdayLabel;
@end

@implementation HTSEditSelectInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];

        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_titleLabel];
        }
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
            [self.contentView addSubview:_genderLabel];
            
        }

    }
    return self;
}

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _titleLabel.text = title;
    _genderLabel.text = value;
    _birthdayLabel.text = value;
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

- (void) changeGender:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(profileCellShouldBeginEditing:)]) {
        if (![self.delegate profileCellShouldBeginEditing:self]) {
            return;
        }
    }
    
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(selectInfoCell:changeGender:)]) {
        [delegate selectInfoCell:self changeGender:self.genderLabel.text];
    }
}

- (void) changeBirthday:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(profileCellShouldBeginEditing:)]) {
        if (![self.delegate profileCellShouldBeginEditing:self]) {
            return;
        }
    }
    
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(selectInfoCell:changeBirthday:)]) {
        [delegate selectInfoCell:self changeBirthday:self.birthdayLabel.text];
    }
}

@end
