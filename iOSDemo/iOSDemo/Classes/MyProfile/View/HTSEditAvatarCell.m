//
//  HTSEditAvatarCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-08-08.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "HTSEditAvatarCell.h"

@interface HTSEditAvatarCell ()

@property (nonatomic, strong) UIView *container;
@property (strong, nonatomic) UILabel *titleLabel;


@end

@implementation HTSEditAvatarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _container = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_container];
        __weak typeof(self) weakSelf = self;
        int avatarRadius = 48;
        _avatar = [[UIImageView alloc] init];
        _avatar.image = [UIImage imageNamed:@"defaultProfilePicture"];
        _avatar.layer.cornerRadius = avatarRadius;
        _avatar.layer.shouldRasterize = YES;
        _avatar.clipsToBounds = YES;
        [_container addSubview:_avatar];
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
            make.centerX.equalTo(weakSelf);
            make.width.height.mas_equalTo(avatarRadius*2);
        }];

        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:14];
            _titleLabel.textColor = [UIColor redColor];
            [self.contentView addSubview:_titleLabel];
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.avatar.mas_bottom).offset(10);
                make.centerX.equalTo(weakSelf);
            }];
        }
    }
    return self;
}


- (void)setTitleStr:(NSString *)title{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLabel.text = title;
}

- (void)setAvatarImage:(UIImage *)avatarImage{
    _avatar.image = avatarImage;
}

+ (CGFloat)cellHeight{
    return 132.0;
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
