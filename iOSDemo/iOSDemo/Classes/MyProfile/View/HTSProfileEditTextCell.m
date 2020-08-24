//
//  HTSProfileEditTextCell.m
//  iOSDemo
//
//  Created by bytedance on 2020/8/23.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSProfileEditTextCell.h"

#import <Masonry/Masonry.h>

static NSString *const editIdCellIdentifier = @"HTSProfileEditIdCell";

@implementation HTSProfileEditTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueTextField];
    }
    return self;
}

- (UILabel *)wordCountLabel{
    if(!_wordCountLabel){
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
    return _wordCountLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)valueTextField{
    if (!_valueTextField) {
        _valueTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 7, [UIScreen mainScreen].bounds.size.width -(110+10) - 90, 30)];
        _valueTextField.backgroundColor = [UIColor clearColor];
        _valueTextField.font = [UIFont systemFontOfSize:15];
        _valueTextField.textColor = [UIColor blackColor];
        _valueTextField.textAlignment = NSTextAlignmentLeft;
        _valueTextField.adjustsFontSizeToFitWidth = YES;
        _valueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_valueTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_valueTextField];
    }
    return _valueTextField;
}

- (UIButton *)userIdCopyButton{
    if (!_userIdCopyButton){
        _userIdCopyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userIdCopyButton.backgroundColor = [UIColor clearColor];
        _userIdCopyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_userIdCopyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_userIdCopyButton setTitle:@"点击复制" forState:UIControlStateNormal];
        _userIdCopyButton.layer.borderColor = [UIColor redColor].CGColor;
        _userIdCopyButton.layer.borderWidth = 1;
        _userIdCopyButton.layer.cornerRadius = 10;
        [_userIdCopyButton addTarget:self action:@selector(copyUserId:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_userIdCopyButton];
        [_userIdCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(7);
            make.right.mas_equalTo(self.contentView.mas_right).inset(15);
        }];
    }
    return _userIdCopyButton;
}

- (void)addCopyButton{
    NSArray *needCopyButton = [NSArray arrayWithObjects:@"火山号", nil];
    if([needCopyButton containsObject:self.titleLabel.text]){
        [self.contentView addSubview:self.userIdCopyButton];
    }
}

- (void)addWordCountLabel{
    NSArray *needWordCount = [NSArray arrayWithObjects:@"昵称", nil];
    if([needWordCount containsObject:self.titleLabel.text]){
        [self.contentView addSubview:self.wordCountLabel];
    }
}

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLabel.text = title;
    _valueTextField.text = value;
    [self addCopyButton];
    [self addWordCountLabel];
}

+ (CGFloat)cellHeight{
    return 44.0;
}

-(void) copyUserId:(UIButton *)button{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(editCell:copyUserId:)]) {
        [delegate editCell:self copyUserId:self.valueTextField.text];
    }
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
