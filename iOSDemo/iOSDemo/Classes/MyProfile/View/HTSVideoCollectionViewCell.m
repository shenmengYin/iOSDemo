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
#import <SDWebImage/SDWebImage.h>

@interface HTSVideoCollectionViewCell ()

@property (nonatomic) HTSVideoCellViewModel *viewModel;

@end

@implementation UIButton (RACTitleSupport)
@dynamic racExt_Title;
- (void)setRacExt_Title:(NSString *)racExt_Title
{
  [self setTitle:racExt_Title forState:UIControlStateNormal];
}
- (NSString *)racExt_Title
{
  return [self titleForState:UIControlStateNormal];
}
@end

@implementation HTSVideoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_coverImageView];
        
        _likeButton = [[UIButton alloc] init];
        //[_likeButton setTitle:@"0" forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"iconProfileLike"] forState:UIControlStateNormal];
        [self.contentView addSubview:_likeButton];
        
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self.contentView);
        }];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.equalTo(self.contentView).offset(10);
            make.bottom.right.equalTo(self.contentView).inset(10);
        }];
    }
    return self;
}

- (void)updateWithImageURL:(NSString*) imageURL likeCount:(NSInteger) likeCount{
    [_likeButton setTitle:[@(likeCount) stringValue] forState:UIControlStateNormal];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"cover"]];
}

//-(void)initWithVideo:(HTSVideoModel *)video{
//    [self.imageView setImage:[UIImage imageNamed:@"cover"]];
//    [self.likeButton setTitle:[NSString stringWithFormat: @"%ld", video.likeCount] forState:UIControlStateNormal];
//}

- (void)bindWithViewModel:(HTSVideoCellViewModel *)viewModel
{
    RAC(self, imageURL) = [viewModel.coverImageSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(self, likeButton.racExt_Title) = [viewModel.displaySignal takeUntil:self.rac_prepareForReuseSignal];
}

@end
