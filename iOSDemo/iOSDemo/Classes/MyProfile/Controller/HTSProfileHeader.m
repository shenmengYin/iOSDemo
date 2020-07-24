//
//  HTSProfileHeader.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-22.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSProfileHeader.h"
#import "HTSUserModel.h"
#import <Masonry/Masonry.h>

#define SafeAreaTopHeight (([UIScreen mainScreen].bounds.size.height >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 88 : 64)

@interface HTSProfileHeader ()

@property (nonatomic, strong) UIView *container;

@end

@implementation HTSProfileHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _container = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_container];
    [self initAvatar];
    [self initActionsView];
    [self initInfoView];
}

- (void) initAvatar {
    int avatarRadius = 48;
    _avatar = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"defaultProfilePicture"];
    _avatar.layer.cornerRadius = avatarRadius;
    _avatar.layer.shouldRasterize = YES;
    _avatar.clipsToBounds = YES;
    [_container addSubview:_avatar];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SafeAreaTopHeight);
        make.left.equalTo(self).offset(15);
        make.width.height.mas_equalTo(avatarRadius*2);
    }];
}


- (void) initActionsView {
    _editButton = [[UIButton alloc] init];
    [_editButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _editButton.clipsToBounds = YES;
    _editButton.layer.borderColor = [UIColor redColor].CGColor;
    _editButton.layer.borderWidth = 1;
    _editButton.layer.cornerRadius = 16.5;
    [_editButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)]];
    [_container addSubview:_editButton];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(29);
        make.bottom.equalTo(self.avatar.mas_bottom).offset(8);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(215);
    }];
}

- (void)initInfoView {
    _userName = [[UILabel alloc] init];
    _userName.text = @"name";
    _userName.textColor = [UIColor blackColor];
    _userName.font = [UIFont boldSystemFontOfSize:26.0];
    [_container addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.width.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop);//和导航栏底部对齐
        
    }];

    
    _vIcon = [[UIImageView alloc] init];
    _vIcon.image = [UIImage imageNamed:@"iconVHotsoon"];
    _vIcon.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _vIcon.layer.cornerRadius = 9;
    _vIcon.contentMode = UIViewContentModeCenter;
    [_container addSubview:_vIcon];
    [_vIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_left);
        make.top.equalTo(self.avatar.mas_bottom).offset(21);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    _vTitle = [[UITextView alloc] init];
       _vTitle.text = @"火山达人";
       _vTitle.textColor = [UIColor grayColor];
       _vTitle.font = [UIFont systemFontOfSize:14.0];
       _vTitle.scrollEnabled = NO;
       _vTitle.editable = NO;
       _vTitle.textContainerInset = UIEdgeInsetsMake(3, 8, 3, 8);
       _vTitle.textContainer.lineFragmentPadding = 0;
       [_vTitle sizeToFit];
       [_container addSubview:_vTitle];
       [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.vIcon.mas_right).offset(2);
           make.top.equalTo(self.vIcon.mas_top);
           
       }];
    
    _locIcon = [[UIImageView alloc] init];
    _locIcon.image = [UIImage imageNamed:@"iconMyProfileLocation"];
    _locIcon.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _locIcon.layer.cornerRadius = 9;
    _locIcon.contentMode = UIViewContentModeCenter;
    [_container addSubview:_locIcon];
    [_locIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vIcon.mas_left);
        make.top.equalTo(self.vIcon.mas_bottom).offset(12);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    _userIntro = [[UILabel alloc] init];
    _userIntro.text = @"Intro placeholder";
    _userIntro.textColor = [UIColor grayColor];
    _userIntro.font = [UIFont systemFontOfSize:14.0];
    _userIntro.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 34;
    [_container addSubview:_userIntro];
    [_userIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_left).offset(-3);
        make.top.equalTo(self.locIcon.mas_bottom).offset(7);
    }];
    
    _city = [[UITextView alloc] init];
    _city.text = @"北京";
    _city.textColor = [UIColor grayColor];
    _city.font = [UIFont systemFontOfSize:14.0];
    _city.scrollEnabled = NO;
    _city.editable = NO;
    _city.textContainerInset = UIEdgeInsetsMake(3, 8, 3, 8);
    _city.textContainer.lineFragmentPadding = 0;
    [_city sizeToFit];
    [_container addSubview:_city];
    [_city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locIcon.mas_right).offset(2);
        make.top.equalTo(self.locIcon.mas_top);
    }];
    
    _flame = [[UILabel alloc] init];
    _flame.text = @"54";
    _flame.textColor = [UIColor grayColor];
    _flame.font = [UIFont boldSystemFontOfSize:16.0];
    [_container addSubview:_flame];
    [_flame mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(50);
    }];
    
    _flameTitle = [[UILabel alloc] init];
    _flameTitle.text = @"火力";
    _flameTitle.textColor = [UIColor grayColor];
    _flameTitle.font = [UIFont boldSystemFontOfSize:12.0];
    [_container addSubview:_flameTitle];
    [_flameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flame.mas_bottom).offset(5);
        make.left.equalTo(self.flame.mas_left);
    }];
    
    _followerNum = [[UILabel alloc] init];
    _followerNum.text = @"73";
    _followerNum.textColor = [UIColor grayColor];
    _followerNum.font = [UIFont boldSystemFontOfSize:16.0];
    [_container addSubview:_followerNum];
    [_followerNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flame);
        make.left.equalTo(self.flame.mas_right).offset(30);
    }];
    
    _followerNumTitle = [[UILabel alloc] init];
    _followerNumTitle.text = @"粉丝";
    _followerNumTitle.textColor = [UIColor grayColor];
    _followerNumTitle.font = [UIFont boldSystemFontOfSize:12.0];
    [_container addSubview:_followerNumTitle];
    [_followerNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.followerNum.mas_bottom).offset(5);
        make.left.equalTo(self.followerNum.mas_left);
    }];
    
    _followedNum = [[UILabel alloc] init];
    _followedNum.text = @"146";
    _followedNum.textColor = [UIColor grayColor];
    _followedNum.font = [UIFont boldSystemFontOfSize:16.0];
    [_container addSubview:_followedNum];
    [_followedNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flame);
        make.left.equalTo(self.followerNum.mas_right).offset(30);
    }];
    
    _followedNumTitle = [[UILabel alloc] init];
    _followedNumTitle.text = @"关注";
    _followedNumTitle.textColor = [UIColor grayColor];
    _followedNumTitle.font = [UIFont boldSystemFontOfSize:12.0];
    [_container addSubview:_followedNumTitle];
    [_followedNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.followedNum.mas_bottom).offset(5);
        make.left.equalTo(self.followedNum.mas_left);
    }];
    
}

- (void)initData:(HTSUserModel *)user {
    [_avatar setImage: [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:user.avatar]]]];
    [_userName setText:user.name];
    if(![user.intro isEqual: @""]) {
        [_userIntro setText:user.intro];
    }
    [_vIcon setImage:[UIImage imageNamed:@"iconVHotsoon"]];
    [_flame setText:[NSString stringWithFormat:@"%ld",(long)user.flameCount]];
    [_followerNum setText:[NSString stringWithFormat:@"%ld",(long)user.followingCount]];
    [_followedNum setText:[NSString stringWithFormat:@"%ld",(long)user.followerCount]];
}


@end
