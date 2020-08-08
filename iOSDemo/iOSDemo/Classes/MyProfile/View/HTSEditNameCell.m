//
//  HTSEditNameCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditNameCell.h"

@interface HTSEditNameCell ()
@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;
@end

@implementation HTSEditNameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];

        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_titleLabel];
        }
        if (!_valueLabel) {
            _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, [UIScreen mainScreen].bounds.size.width -(110+10) - 30, 30)];
            _valueLabel.backgroundColor = [UIColor clearColor];
            _valueLabel.font = [UIFont systemFontOfSize:15];
            _valueLabel.textColor = [UIColor blackColor];
            _valueLabel.textAlignment = NSTextAlignmentRight;
            _valueLabel.adjustsFontSizeToFitWidth = YES;
            _valueLabel.minimumScaleFactor = 0.6;
            [self.contentView addSubview:_valueLabel];
        }
    }
    return self;
}

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;

    _titleLabel.text = title;
    _valueLabel.text = value;
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

@end
