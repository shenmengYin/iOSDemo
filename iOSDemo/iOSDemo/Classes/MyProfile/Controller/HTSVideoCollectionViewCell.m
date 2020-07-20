//
//  HTSVideoCollectionViewCell.m
//  iOSDemo
//
//  Created by Shenmeng Yin on 2020-07-17.
//  Copyright © 2020 Shenmeng Yin. All rights reserved.
//

#import "HTSVideoCollectionViewCell.h"
#import "HTSVideoModel.h"
#import <Masonry/Masonry.h>
#import "HTSVideoCellViewModel.h"

@interface HTSVideoCollectionViewCell ()

@property (nonatomic) HTSVideoCellViewModel *viewModel;

@end

@implementation HTSVideoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
        
        _likeButton = [[UIButton alloc] init];
        [_likeButton setTitle:@"0" forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"iconProfileLike"] forState:UIControlStateNormal];
        [self.contentView addSubview:_likeButton];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self.contentView);
        }];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.right.equalTo(self.contentView).inset(10);
        }];
        
    }
    return self;
}

//-(void)initWithVideo:(HTSVideoModel *)video{
//    [self.imageView setImage:[UIImage imageNamed:@"cover"]];
//    [self.likeButton setTitle:[NSString stringWithFormat: @"%ld", video.likeCount] forState:UIControlStateNormal];
//}

- (void)bindWithViewModel:(HTSVideoCellViewModel *)viewModel
{
    RAC(_imageView, image) = [viewModel.coverImageSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_likeButton.titleLabel, text) = [viewModel.displaySignal takeUntil:self.rac_prepareForReuseSignal];
    _viewModel = viewModel;
}

@end
