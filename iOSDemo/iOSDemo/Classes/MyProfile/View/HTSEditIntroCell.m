//
//  HTSEditIntroCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditIntroCell.h"

#import <Masonry/Masonry.h>

@implementation HTSEditIntroCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        if (!_introTextView) {
            _introTextView = [[UITextView alloc] initWithFrame:CGRectMake(120, 7, [UIScreen mainScreen].bounds.size.width -(110+10) - 90, 30)];
            _introTextView.backgroundColor = [UIColor clearColor];
            _introTextView.font = [UIFont systemFontOfSize:15];
            _introTextView.textColor = [UIColor blackColor];
            _introTextView.textAlignment = NSTextAlignmentLeft;
//            _textView.adjustsFontSizeToFitWidth = YES;
//            _textView.clearButtonMode = UITextFieldViewModeWhileEditing;
            //_textView.delegate = self;
            //_textView.minimumScaleFactor = 0.6;
            [self.contentView addSubview:_introTextView];
            [_introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).offset(15);
                make.top.mas_equalTo(self.contentView.mas_top).offset(7);
                make.right.mas_equalTo(self.contentView.mas_right).inset(15);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(15);
            }];
            
            
        }

    }
    return self;
}


- (void)setViewText:(NSString *)value{
    _introTextView.text = value;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
