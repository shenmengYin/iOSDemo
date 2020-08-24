//
//  HTSEditAvatarView.m
//  iOSDemo
//
//  Created by bytedance on 2020/8/23.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSEditAvatarView.h"

#import <Masonry/Masonry.h>

@interface HTSEditAvatarView ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *changeAvatarLabel;

@end

static const int avatarRadius = 48;

@implementation HTSEditAvatarView
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
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(10);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(avatarRadius*2);
    }];
    [self addSubview:self.changeAvatarLabel];
    [self.changeAvatarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
}

// Getter

- (UIImageView *)avatarImageView{
    if(!_avatarImageView){
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.image = [UIImage imageNamed:@"defaultProfilePicture"];
        _avatarImageView.layer.cornerRadius = avatarRadius;
        _avatarImageView.layer.shouldRasterize = YES;
        _avatarImageView.clipsToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)changeAvatarLabel{
    if(!_changeAvatarLabel){
        _changeAvatarLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
        _changeAvatarLabel.backgroundColor = [UIColor whiteColor];
        _changeAvatarLabel.font = [UIFont systemFontOfSize:14];
        _changeAvatarLabel.textColor = [UIColor redColor];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarLabel:)];
        [_changeAvatarLabel addGestureRecognizer:recognizer];
        _changeAvatarLabel.userInteractionEnabled = YES;
    }
    return _changeAvatarLabel;
}

- (void)tapAvatarLabel:(UIImageView *)avatarImageView{
    __typeof(self.delegate) delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(tapAvatarLabel:)]) {
        [delegate tapAvatarLabel:_avatarImageView];
    }
}

- (void)setLabelStr:(NSString *)title{
    self.changeAvatarLabel.text = title;
}

- (void)setAvatarImage:(UIImage *)avatarImage{
    self.avatarImageView.image = avatarImage;
}

@end
