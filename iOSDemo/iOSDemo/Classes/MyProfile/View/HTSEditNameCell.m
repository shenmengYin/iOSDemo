//
//  HTSEditNameCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditNameCell.h"
#import <Masonry/Masonry.h>

@interface HTSEditNameCell ()
//@property (strong, nonatomic) UILabel *titleLabel;
//@property (strong, nonatomic) UILabel *wordCountLabel;
//@property (strong, nonatomic) UITextField *valueTextField;

@end

@implementation HTSEditNameCell

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
            _valueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            //_valueTextField.delegate = self;
            [_valueTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
            //_valueTextField.minimumScaleFactor = 0.6;
            [self.contentView addSubview:_valueTextField];
        }
        if (!_wordCountLabel) {
            _wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 7, 100, 30)];
            _wordCountLabel.backgroundColor = [UIColor clearColor];
            _wordCountLabel.font = [UIFont systemFontOfSize:16];
            _wordCountLabel.textColor = [UIColor grayColor];
            [self.contentView addSubview:_wordCountLabel];
            [_wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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




- (void)textFieldDidChanged:(UITextField *)textField {
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    if (textField.text.length > 10) {
        textField.text = [textField.text substringToIndex:10];
    }
    
    // 剩余字数显示 UI 更新
    _wordCountLabel.text = [NSString stringWithFormat:@"%lu/10", textField.text.length];
    
}

@end
