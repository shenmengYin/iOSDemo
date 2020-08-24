//
//  HTSEditIdCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditIdCell.h"

#import <Masonry/Masonry.h>

@interface HTSEditIdCell ()
//@property (strong, nonatomic) UILabel *titleLabel;
//@property (strong, nonatomic) UITextField *valueTextField;
//@property (strong, nonatomic) UIButton *userIdCopyButton;
@end

@implementation HTSEditIdCell

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
        if (!_valueTextField) {
            _valueTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 7, [UIScreen mainScreen].bounds.size.width -(110+10) - 90, 30)];
            _valueTextField.backgroundColor = [UIColor clearColor];
            _valueTextField.font = [UIFont systemFontOfSize:15];
            _valueTextField.textColor = [UIColor blackColor];
            _valueTextField.textAlignment = NSTextAlignmentLeft;
            _valueTextField.adjustsFontSizeToFitWidth = YES;
            [self.contentView addSubview:_valueTextField];
        }
        if (!_userIdCopyButton){
            _userIdCopyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _userIdCopyButton.backgroundColor = [UIColor clearColor];
            _userIdCopyButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [_userIdCopyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_userIdCopyButton setTitle:@"点击复制" forState:UIControlStateNormal];
            [_userIdCopyButton addTarget:self action:@selector(copyUserId:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_userIdCopyButton];
            [_userIdCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.mas_top).offset(7);
                make.right.mas_equalTo(self.contentView.mas_right).inset(15);
            }];
        }
    }
    return self;
}

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _titleLabel.text = title;
    _valueTextField.text = value;
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

- (void)copyUserId:(UIButton *)button{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(editIdCell:copyUserId:)]) {
        [delegate editIdCell:self copyUserId:self.valueTextField.text];
    }
}

@end
